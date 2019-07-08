create table MEMBER(id_no number(4),
               id varchar2(20) not null unique,
               pw varchar2(20) not null,
               name varchar2(20) not null,
               nickname varchar2(20) not null,
               gender varchar2(5) not null,
               age int not null,
               phone varchar2(20),
               email varchar2(30));
               
               
               	select * from board order by b_id desc;
				select * from review;
				select * from member;
				
				select * from board where b_id=1;
				
				
				select * from review;
				
				
				
			select * from(select ROW_NUMBER() over(order by r_id desc)as rn, review.* from review) where rn >= 1 and rn <=2