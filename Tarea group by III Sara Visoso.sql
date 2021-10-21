--Cómo obtenemos todos los nombres y correos de nuestros clientes canadienses para una campaña?
select c.first_name, c.email from customer c join address  a on a.address_id =c.address_id 
join city ci on ci.city_id=a.city_id
join country co on co.country_id =ci.country_id where co.country='Canada';


--Qué cliente ha rentado más de nuestra sección de adultos?
select concat( c.first_name,' ', c.last_name) as cliente, count(r.rental_id) as cant 
from customer c 
join rental r on c.customer_id =r.customer_id 
join inventory i on r.inventory_id=i.inventory_id join film f on i.film_id=f.film_id 
group by (cliente, f.rating) having f.rating='NC-17' order by cant desc limit 1;

--Qué películas son las más rentadas en todas nuestras stores?
select f.film_id, f.title, count(r.rental_id) as cant_veces from film f join inventory i on f.film_id=i.film_id 
join rental r on r.inventory_id=i.inventory_id  group by (f.film_id) order by cant_veces desc

--Cuál es nuestro revenue por store?
select s.store_id, sum(p.amount) as revenue from store s join inventory i on s.store_id=i.store_id 
join rental r on r.inventory_id=i.inventory_id 
join payment p on p.rental_id=r.rental_id 
group by(s.store_id)
