use ovp;

-- most liked videos
select 
	m.name as video_name,
	l.video_id,
	ch.name as channel_name,
	count(*) as likes_count
from media m
join videos v on m.id = v.media_id
join likes l on v.id = l.video_id
join channels as ch on ch.id = v.channel_id
group by l.video_id
order by likes_count desc
limit 10;


-- most viewed videos with likes
select
	m.name as video_name,
	ch.name as channel_name,
	v.views,
	v.id as video_id,
	count(*) as likes_count
from videos as v
join media as m on v.media_id = m.id
join channels as ch on ch.id = v.channel_id
join likes as l on v.id = l.video_id
group by l.video_id
order by v.views desc
limit 10;


-- user's subscriptions count
select
	(select 
	concat(firstname, ' ', lastname)
	from users where id = 1) as username,
	count(*) as number_of_subscriptions
from users_subscriptions as us
where us.user_id = 1;



-- channel's subscribers count
select
	ch.name as channel_name,
	count(*) as number_of_subscribers
from users_subscriptions as us
join channels as ch on ch.id = us.channel_id
where ch.id = 1;




-- most popular languages
select
	l.name as language,
	count(*) as videos
from media as m
join videos as v on v.media_id = m.id
join languages as l on l.id = m.language_id
group by l.id
order by videos desc
limit 10;


-- most popular category (number of videos)
select
	c.name as category,
	count(*) as number_of_videos
from videos as v
join categories as c on c.id = v.category_id
group by c.id
order by number_of_videos;



-- most popular category (likes)
select 
	c.name as category_name,
	count(*) as likes
from likes as l 
join videos as v on l.video_id = v.id
join categories as c on c.id = v.category_id
group by c.id
order by likes desc;


-- likes, views, comments on video
select
	v.id,
	m.name as video_name,
	v.views as number_of_views,
	(select count(*) from likes where likes.video_id = 1
	) as number_of_likes,
	(select count(*) from comments where comments.video_id = 1
	) as number_of_comments
from videos as v
join likes as l on v.id = l.video_id
join comments as c on c.video_id = v.id
join media as m on m.id = v.media_id
where v.id = 1
group by v.id;


-- how many videos in playlist
select
	p.name as playlist_name,
	count(*) as number_of_videos
from playlists as p
join videos as v on v.playlist_id = p.id
where p.id = 1
group by p.id;


-- user search history
select
	concat(firstname, ' ', lastname) as username,
	sh.search_request,
	sh.searched_at
from users as u
join search_histories as sh on sh.user_id = u.id
where u.id = 1;



-- user watch history
select
	concat(firstname, ' ', lastname) as username,
	m.name as video_name,
	ch.name as channel_name,
	wh.watched_at
from users as u
join watch_histories as wh on wh.user_id = u.id
join videos as v on v.id = wh.video_id
join media as m on v.media_id = m.id
join channels as ch on ch.id = v.channel_id
where u.id = 1;


-- get user info
select 
	concat(u.firstname, ' ', u.lastname) as username,
	timestampdiff(year, p.birthday, now()) as age,
	p.gender,
	p.country,
	m.id as photo_id,
	u.email,
	u.phone,
	count(*) as number_of_subscriptions
from media as m
join profiles as p on p.photo_id = m.id
join users as u on u.id = p.user_id
join users_subscriptions as us on us.user_id = u.id
join channels as ch on ch.id = us.channel_id
where u.id = 1
group by u.id;



-- most popular channels
select
	name, subscribers
from channels
order by subscribers desc
limit 10;


-- user's favourite categories (likes)
select 
	concat(firstname, ' ', lastname) as username,
	c.name as category_name,
	count(*) as likes
from users as u 
join likes as l on l.user_id = u.id
join videos as v on v.id = l.video_id
join categories as c on c.id = v.category_id
where u.id = 1
group by c.id
order by likes desc
limit 10;





select 
	v.id as video_id,
	ch.id as channel_id,
	m.id as media_id,
	c.id as category_id,
	views,
	playlist_id,
	m.name,
	m.description,
	ch.subscribers,
	ch.created_at as channel_created_at,
	ch.created_by_user_id,
	m.created_at as media_created_at,
	m.language_id
from videos as v
join categories as c on c.id = v.category_id
join playlists as p on p.id = v.playlist_id
join channels as ch on ch.id = v.channel_id
join media as m on m.id = v.media_id












