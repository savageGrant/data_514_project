--(Booking trend) For each city, how many reviews are received for December of each year?--

SELECT l.neighbourhood,
    EXTRACT(YEAR FROM r.date) as year,
    COUNT(r.id) as review_count
    FROM Reviews r
    left join listings l
    on l.listing_id = r.listing_id
    Where extract(MONTH FROM r.date) = 12
GROUP BY l.Neighbourhood, year
ORDER BY review_count desc
 