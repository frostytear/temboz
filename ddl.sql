create table fm_feeds (
	feed_uid	integer primary key,
	feed_xml	varchar(255) unique not null,
	feed_etag	varchar(255),
	feed_modified	varchar(255),
	feed_html	varchar(255) not null,
	feed_title	varchar(255),
	feed_desc	text,
	feed_errors	int default 0
);

create table fm_items (
	item_uid	integer primary key,
	item_feed_uid	int,
	-- references fm_feeds (feed_uid) on delete cascade,
	item_loaded	timestamp,
	item_created	timestamp,
	item_modified	timestamp,
	item_viewed	timestamp,
	item_link	varchar(255),
	item_md5hex	char(32) not null,
	item_title	text,
	item_content	text,
	item_creator	varchar(255),
	item_rating	default 0
);

create trigger update_timestamp after insert on fm_items
begin
	update fm_items set item_loaded = julianday("now")
	where item_uid=new.item_uid;
end;
