-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

--Players table

drop table if exists players;

create table players(
	player_id serial primary key,
    player_name text
 );

--matches table

drop table if exists matches;

create table matches(
	match_id serial primary key,
	player_winner integer references players(player_id),
	player_loser integer references players(player_id),
	UNIQUE (player_winner, player_loser)                       --to avoid matches between the same set of players
);

create view player_standings as
	select c.id as player_id, p.player_name, c.x as wins, (select count(*)/2 from matches) as matches
	from players p join (select p.player_id as id, count(m.player_winner) as x
		from players p left join matches m
		on p.player_id = m.player_winner
		group by p.player_id
		order by x desc) c
	on p.player_id = c.id
	order by x desc;








