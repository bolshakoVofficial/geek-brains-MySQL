use ovp;

-- personal information about users and profiles
create or replace view v_users_info as
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
	group by u.id;
	

select * from v_users_info as vui;


-- information about videos
create or replace view v_videos_info as
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

select * from v_videos_info;