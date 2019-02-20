-- TYPE YOUR SQL QUERY BELOW

-- PART 1: Create a SQL query that maps out the daily average users before and after the feature change

------------------------- SQLite, strftime ------------------------------------------
.headers on
-- users before faeture change
select distinct(id), firstname, lastname
from (select user.id, firstname, lastname, login_timestamp
      from user left join login_history
      on user.id=login_history.user_id)
      as login_userInfo
where login_timestamp < strftime('%s','2018-06-02');

-- users after faeture change
select distinct(id), firstname, lastname
from (select user.id, firstname, lastname, login_timestamp
      from user left join login_history
      on user.id=login_history.user_id)
      as login_userInfo
where login_timestamp > strftime('%s','2018-06-02');

------------------------- mysql, UNIX_TIMESTAMP---------------------------------
-- users before faeture change
select distinct(id), firstname, lastname
from (select user.id, firstname, lastname, login_timestamp
      from user left join login_history
      on user.id=login_history.user_id)
      as login_userInfo
where login_timestamp < UNIX_TIMESTAMP(STR_TO_DATE('Jun 2 2018', '%M %d %Y'));

-- users after faeture change
select distinct(id), firstname, lastname
from (select user.id, firstname, lastname, login_timestamp
      from user left join login_history
      on user.id=login_history.user_id)
      as login_userInfo
where login_timestamp > UNIX_TIMESTAMP(STR_TO_DATE('Jun 2 2018', '%M %d %Y'));

-- PART 2: Create a SQL query that indicates the number of status changes by card

------------------------- SQLite, no right join----------------------------
.headers on
select id,  name, count(change_id) as numOfChange
from (select card.id, card_change_history.id as change_id, name
	 from card_change_history join card
	 on card.id=card_change_history.cardID)
	 as A
group by id;

------------------------- mysql -------------------------------------------
select id,  name, count(change_id) as numOfChange
from (select card.id, card_change_history.id as change_id, name
	 from card_change_history right join card
	 on card.id=card_change_history.cardID)
	 as A
group by id;
