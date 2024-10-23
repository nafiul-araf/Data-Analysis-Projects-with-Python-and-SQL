/*
Q-1: How can I create a stored procedure in MySQL to extract and store Bollywood movies, 
including their IMDb ratings, into a new table with grouped average ratings and release years?
*/
select * from movies;


delimiter $$ 
create procedure bollywood() 
begin 
    create table if not exists bollywood_table ( 
        movie_id int, 
        title varchar(200), 
        release_year year, 
        avg_imdb_rating decimal(3,1) 
    ); 

    insert into bollywood_table 
    select movie_id, title, release_year, round(avg(imdb_rating), 1) as avg_imdb_rating 
    from movies 
    where industry = 'Bollywood' 
    group by movie_id; 
end $$ 
delimiter ;

call bollywood();
select * from bollywood_table;






/*
Q-2: How can I create a MySQL stored procedure to calculate the average revenue of Bollywood movies
 and store the results in a new table, ensuring the table only creates if it does not already exist?
*/
select * from financials;

delimiter $$
create procedure bol_rev()
begin
create table if not exists bollywood_revenue(
                 movie_id int,
                 title varchar(150),
                 avg_revenue decimal(65, 2)
);
insert into bollywood_revenue
select m.movie_id, m.title, round(avg(f.revenue), 2) as avg_revenue from movies as m
join financials as f on m.movie_id = f.movie_id
where m.industry = 'Bollywood'
group by m.movie_id;
end $$
delimiter ;

call bol_rev();
select * from bollywood_revenue;



/*
Q-3: How can I create a MySQL stored procedure to list Bollywood actors along with the movies they've 
acted in and the total number of Bollywood movies, storing the data in a table and ordering the 
actors by the number of movies they have appeared in?
*/

delimiter $$

create procedure bol_actors()
begin
create table if not exists bollywood_actors(
             name varchar(100),
             movies_tile mediumtext,
             movie_count int
);
insert into bollywood_actors

select a.name, group_concat(m.title separator ', ') as movies_tile, 
count(m.movie_id) as movie_count from actors as a
join movie_actor as ma on a.actor_id = ma.actor_id
join movies as m on ma.movie_id = m.movie_id
where m.industry = 'Bollywood'
group by a.name
order by movie_count desc;

end $$
delimiter ;

call bol_actors();
select * from bollywood_actors;



/*
Q-4: How can I create a MySQL stored procedure to combine dish names and their variants, calculate 
the total price by summing the base price and variant price, and store the results in a new table?
*/
use food_db;

delimiter $$

create procedure d_p()
begin
create table if not exists dish_price(
             dish_name varchar(200),
             total_price decimal(65, 2)
);
insert into dish_price
select concat(i.name, '-', v.variant_name) as dish_name, 
       (i.price + v.variant_price) as total_price
from items as i
cross join variants as v;
end $$
delimiter ;

call d_p();
select * from dish_price;