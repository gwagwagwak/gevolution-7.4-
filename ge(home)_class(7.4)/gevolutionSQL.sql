select * from tab;

desc table member;


select * from sequence;



select count(*) as totalCount from board;

select * from(select * from board where b_id < 18 order by b_id DESC) where rownum<=10;

drop table member;


SELECT ROWNUM, b.* FROM board b order by b_id desc;

SELECT ROWNUM, b.* FROM board b order by b_id desc;

SELECT ROWNUM, b.* FROM (SELECT * FROM board ORDER BY b_id desc) b where rownum<=11;
SELECT ROWNUM, b.* FROM (SELECT * FROM board ORDER BY b_id desc) b where rownum<=5 and rownum >= 2 ;

SELECT ROWNUM, b.* FROM (SELECT * FROM board ORDER BY b_id desc) b where rownum>=4;<!--rownum >, 크다비교 안됨  -->

select * from(select rownum, b_id, title, day from board order by b_id desc) where rownum >=2 and rownum <=10;

select * from(SELECT ROW_NUMBER() OVER(ORDER BY HIREDATE DESC)AS RN, b_id, title, day from board order by b_id desc) where rownum >=2 and rownum <=10;

select * from(select ROW_NUMBER() over(order by b_id desc)as rn, b_id, title, day from board) where rn <=10;

select * from(select ROW_NUMBER() over(order by b_id desc)as rn, b_id, title, day from board) where rn <=10 and rn >=5; <!--이거임  -->


select * from(select ROW_NUMBER() over(order by b_id desc)as rn, board.* from board) where rn <=11 and rn >=11; 





select * from(select ROW_NUMBER() over(order by b_id desc)as rn, b_id, title, day from board) where rn >= 7;



SELECT ROW_NUMBER() OVER(ORDER BY b.b_id desc)AS SEQ, b.* FROM board b;






select * from member;
select * from board order by b_id desc;
select * from review;

select * from(select * from board where b_id < ? order by b_id DESC) where rownum<=10;

select * from(select * from board where b_id < 15 order by b_id DESC) where rownum = 11;
select * from(select * from board where b_id < 15 order by b_id DESC);

select * from(select * from board where b_id < 15 order by b_id DESC) where rownum<=11 and rownum>=11;
select * from(select * from board where b_id < 15 order by b_id DESC) where rownum<=10 and  rownum>=1;
select * from(select * from board where b_id < 5 order by b_id DESC) where rownum<=10 and  rownum>=1;


select * from(select * from board where b_id < 32 order by b_id DESC) where rownum<=10;
select * from(select * from board where b_id < ? order by b_id DESC) where rownum>=1;

select * from board;


select rownum, b_id, title from board;


select * from board where b_id < 15 order by b_id DESC

select * from board order by b_id desc;

create table MEMBER(id_no number(4),
               id varchar2(20) not null unique,
               pw varchar2(20) not null,
               name varchar2(20) not null,
               nickname varchar2(20) not null,
               gender varchar2(5) not null,
               age int not null,
               phone varchar2(20),
               email varchar2(30));

  insert into member values(member_sequence1.NEXTVAL, 'test', 'test', '황상호', '과과곽', '남', 27, '010-5093', 'rmfhwlt0@');               
  insert into member values(member_sequence1.NEXTVAL, 'test2', 'test2', '황상호', '과과곽', '남', 27, '010-5093', 'rmfhwlt0@');               
  insert into member values(member_sequence1.NEXTVAL, 'test2', 'test2', '황상호', '과과곽', '남', 27, '010-5093', 'rmfhwlt0@');               
                
               
  select * from member;
  select * from board where b_id < 1
  
select * from board where b_id < 1 AND ROWNUM <= 1 order by b_id DESC;
  
               
alter table member add constraint member_id_no_pk primary key(id_no);   


               
create table BOARD( b_id number(10) primary key,
                 title varchar2(100) not null,
                 content varchar2(1000),
                 nickname varchar2(20) not null,
                 day varchar2(30),
                 hits number(5) default 0,
                 reply varchar2(100),
                 b_type varchar2(10),
                 game_name varchar2(30)
                 );
                 
                 select b_id from board order by b_id desc;
                 
                 <!-- 되는거 이거이거 -->
                 select * from(select ROW_NUMBER() over(order by b_id desc)as rn, board.* from board) where rn >= 1 and rn <=10;
                 
                 
                 
                 select rownum, b_id, title, content, nickname, day, hits, reply, b_type, b_type, game_name from(select * from board where b_id < ? order by b_id DESC) where rownum<=10 and rownum>=1;
                 	
                 
                 
                 
                 create table REVIEW( 
                 r_id number(10) primary key,                 
                 nickname varchar2(20) not null,
                 r_content varchar2(500),
                 day varchar2(30),                 
                 game_name varchar2(30) not null
                 );
                 
                 select * from board;
              
                 select * from cols where table_name = 'member';
                 select * from cols;
              
                 select b_id from board order by b_id desc;
                 
                 alter table board MODIFY (day default sysdate);
                 alter table board MODIFY (hits default 0);
                 
                 SELECT * FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = 'BOARD';
                 
                 drop table board;
                 
                 drop sequence board_sequence1;
                 
                 create sequence board_sequence1 start with 3;
                 create sequence member_sequence1;
                 
                 delete from board where b_id >30;
                 
                 SELECT LAST_NUMBER FROM USER_SEQUENCES  WHERE SEQUENCE_NAME = 'board_sequence1';
                 
  
                 drop table board;
                 
                 select * from board where b_id < 17 AND ROWNUM <= 10 order by b_id DESC;
   
                 select * from board order by b_id desc;
                 
                 select * from member;
   
   
   select nickname from member where id='test';
   
   delete from member where id = 'test2';
 
  insert into board values(board_sequence1.NEXTVAL, '제목', '내용', '과과곽',  to_char(SYSDATE, 'yy-mm-dd hh24:mi'),0 , '', '', '');                
				
                 
                 
                 