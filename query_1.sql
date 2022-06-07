--Display list of stays in Portland, OR with details: name, neighbourhood, room type, how many guests it accommodates, property type and amenities, per night’s cost and is available for the next two days in descending order of rating.--
with dayone_temp as
    (select
     calendar.date as day_one,
     calendar.available as day_one_available,
     calendar.listing_id
     from calendar
     where calendar.date = dateadd(day, 1, CURRENT_DATE())
    ),
     daytwo_temp as
     (select
     calendar.date as day_two,
     calendar.available as day_two_available,
     calendar.listing_id
     from calendar
     where calendar.date = dateadd(day, 2, CURRENT_DATE())
     )
Select
    REVIEW_SCORES_VALUE,
    Name, 
    Neighbourhood, 
    Room_Type,
    accommodates,
    Property_Type,
    Amenities,
    listings.price,
    day_one_available,
    day_two_available
From LISTINGS
Left join dayone_temp on
    dayone_temp.listing_id = listings.listing_id
left join daytwo_temp on
    daytwo_temp.listing_id = listings.listing_id
WHERE CONTAINS(LOWER(NEIGHBOURHOOD), 'portland')
order by review_scores_value desc nulls last;
    
