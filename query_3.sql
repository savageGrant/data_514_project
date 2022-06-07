-- (Reminder to book again) Are there any listings that a reviewer has reviewed more than thrice that is also available in the same month as was reviewed by them previously? (check against all the months that the previous reviews were posted on, if any match then it qualifies). AND are there any other listings by the same host that can be suggested? Display listing’s name, url, description, host’s name, reviewer name, whether previously booked, availability days, minimum and maximum nights booking allowed. --

with rwtrol as
    ( select count(listing_id) as listing_count,
    listing_id,
    reviewer_id
     from reviews
     group by reviewer_id, listing_id
     having listing_count >=3
    ),
    mor as 
    ( select 
        distinct r.reviewer_id, r.listing_id, EXTRACT(Month FROM r.date) as month,
        h.host_id
        from reviews r
        inner join rwtrol on 
        r.reviewer_id = rwtrol.reviewer_id
        and r.listing_id = rwtrol.listing_id
        inner join hosts h on
        r.listing_id = h.listing_id
     where month >= Month(current_date())
    ),
    avail as
    (select
    listagg(Date, ', ') as available_dates,
    mor.reviewer_id,
    mor.host_id,
    calendar.listing_id,
    Minimum_nights,
    Maximum_nights
    from calendar
    inner join mor
     on mor.listing_id = calendar.listing_id
     where calendar.available = True
     and Extract(Month from calendar.date) = mor.month
     and extract(year from calendar.date) = 2022
     group by mor.reviewer_id, mor.host_id, calendar.listing_id, Minimum_nights, Maximum_nights

    ),
    other_listings as
    (select
    listagg(calendar.Date, ', ') as available_dates,
    calendar.Minimum_nights,
    calendar.Maximum_nights,
    l.listing_id,
    l.host_id,
    a.reviewer_id
    from listings l
    left join mor
     on mor.host_id = l.host_id
    left join avail a
     on a.host_id = l.host_id
    inner join calendar
     on l.listing_id = calendar.listing_id
     where calendar.available = True
     and Extract(Month from calendar.date) = mor.month
     and extract(year from calendar.date) = 2022
     group by l.listing_id, l.host_id, a.reviewer_id, calendar.Minimum_nights, calendar.Maximum_nights
    ),
    final_values as (select * from avail union select * from other_listings
    ),
    collected_info as (
    select 
        l.listing_id,
        l.name,
        l.description,
        l.listing_url,
        h.host_name,
        r.reviewer_name,
        f.available_dates,
        f.minimum_nights,
        f.maximum_nights,
        f.host_id,
        f.reviewer_id,
        iff(reviews.reviewer_id is null, false, true) as previously_booked
        from final_values f
        left join (select reviews.reviewer_id, reviews.listing_id from reviews group by reviewer_id, listing_id) reviews
            on (reviews.reviewer_id= f.reviewer_id and reviews.listing_id=f.listing_id) 
        left join (
            select name, listing_url, listing_id, description from listings group by name, listing_url, listing_id, description) l
        on f.listing_id = l.listing_id
        left join (
            select host_name, host_id from hosts group by host_name, host_id) h
        on f.host_id = h.host_id
        left join (
            select reviewer_name, reviewer_id from reviews group by reviewer_name, reviewer_id) r
        on f.reviewer_id = r.reviewer_id
        order by reviewer_id
        )
    select 
    name,
    listing_url,
    description,
    host_name,
    reviewer_name,
    previously_booked,
    available_dates,
    minimum_nights,
    maximum_nights
    from collected_info

