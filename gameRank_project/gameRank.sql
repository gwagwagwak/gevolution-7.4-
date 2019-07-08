select * from review;

update board set hits = hits+1 where b_id=24;
update board set hits = hits-1 where b_id=24;

select * from board;