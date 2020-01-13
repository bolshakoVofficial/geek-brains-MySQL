drop database if exists ovp;
create database ovp;
use ovp;

drop table if exists users;
create table users (
	id serial primary key,
	firstname varchar(100),
	lastname varchar(100),
	email varchar(100) unique,
	phone varchar(12) unique,
	index users_phone_index(phone),
	index users_firstname_lastname_index(firstname, lastname)
);


drop table if exists channels;
create table channels (
	id serial primary key,
	name varchar(150) unique,
	description text,
	created_by_user_id bigint unsigned not null comment 'owner of channel',
	subscribers bigint unsigned comment 'number of subscribers',
	created_at datetime default now(),
	
	index channels_name_index(name),
	foreign key (created_by_user_id) references users(id)
);


drop table if exists users_subscriptions;
create table users_subscriptions (
	user_id bigint unsigned not null,
	channel_id bigint unsigned not null,
	
	primary key (user_id, channel_id),
	foreign key (user_id) references users(id),
	foreign key (channel_id) references channels(id)
);


drop table if exists media_types;
create table media_types (
	id serial primary key,
	name varchar(255) unique
);


drop table if exists categories;
create table categories (
	id serial primary key,
	name varchar(100) unique
);


drop table if exists languages;
create table languages (
	id serial primary key,
	name varchar(150)
);

drop table if exists media;
create table media (
	id serial primary key,
	media_type_id bigint unsigned not null,
	channel_id bigint unsigned not null,
	name varchar(255) comment 'video title',
	description text comment 'video description',
	filename varchar(255),
	size int,
	language_id bigint unsigned not null,
	created_at datetime default now(),
	
	index (channel_id),
	foreign key (channel_id) references channels(id),
	foreign key (media_type_id) references media_types(id),
	foreign key (language_id) references languages(id)
);


drop table if exists profiles;
create table profiles (
	user_id serial primary key,
	birthday date,
	gender char(1),
	country varchar(30),
	photo_id bigint unsigned null,
	created_at datetime default now(),
	
	foreign key (user_id) references users(id),
	foreign key (photo_id) references media(id)
);


drop table if exists playlists;
create table playlists (
	id serial primary key,
	name varchar(100) unique comment 'title of a playlist',
	channel_id bigint unsigned not null,
	created_at datetime default now(),
	
	foreign key (channel_id) references channels(id)
);


drop table if exists videos;
create table videos (
	id serial primary key,
	channel_id bigint unsigned not null,
	media_id bigint unsigned not null,
	category_id bigint unsigned not null,
	views bigint unsigned,
	playlist_id bigint unsigned null comment 'null if video is not in playlist',
	
	index (category_id),
	foreign key (channel_id) references channels(id),
	foreign key (media_id) references media(id),
	foreign key (category_id) references categories(id),
	foreign key (playlist_id) references playlists(id)
);


drop table if exists likes;
create table likes (
	-- id serial primary key,
	user_id bigint unsigned not null,
	video_id bigint unsigned not null,
	created_at datetime default now(),
	
	foreign key (user_id) references users(id),
	foreign key (video_id) references videos(id),
	primary key (user_id, video_id)
);


drop table if exists comments;
create table comments (
	id serial primary key,
	user_id bigint unsigned not null,
	video_id bigint unsigned not null,
	created_at datetime default now(),
	body text,
	
	foreign key (user_id) references users(id),
	foreign key (video_id) references videos(id)
);


drop table if exists watch_histories;
create table watch_histories (
	user_id bigint unsigned not null,
	video_id bigint unsigned not null,
	watched_at datetime default now(),
	
	primary key (user_id, video_id),
	foreign key (user_id) references users(id),
	foreign key (video_id) references videos(id)
);


drop table if exists search_histories;
create table search_histories (
	id serial primary key,
	user_id bigint unsigned not null,
	search_request varchar(200),
	searched_at datetime default now(),
	
	foreign key (user_id) references users(id)
);


drop table if exists watch_later;
create table watch_later (
	user_id bigint unsigned not null,
	video_id bigint unsigned not null,
	
	primary key (user_id, video_id),
	foreign key (user_id) references users(id),
	foreign key (video_id) references videos(id)
);


