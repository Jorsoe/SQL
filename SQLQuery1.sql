create table Class
(class_no char(6) primary key,
class_name char(20) not null,
class_special varchar(20),
class_dept char(20))

create table Student
(s_no char(6) primary key,
class_no char(6) not null foreign key references Class(class_no),
s_name varchar(10) not null,
s_sex char(2) check(s_sex='��' or  s_sex='Ů'),
s_birthday datetime)

create table Course
(course_no char(5) primary key,
course_name char(20) not null,
course_sorce numeric(6,2))

create table Choice
(s_no char(6)foreign key references Student(s_no),
course_no char(5) foreign key references Course(course_no),
score numeric(6,1)
primary key(s_no,course_no))

create table Teacher
(t_no char(6) primary key,
t_name varchar(10) not null,
t_sex char(2) check(t_sex='��'or t_sex='Ů'),
t_birthday datetime not null,
t_title char(10))

create table Teaching(
course_no char(5) foreign key references Course(course_no),
t_no char(6) foreign key references Teacher(t_no)
primary key(course_no,t_no))

insert into Class
values('js9901','�����99-1','�����','�����ϵ'),
      ('js9902','�����99-2','�����','�����ϵ'),
      ('js0001','�����00-1','�����','�����ϵ'),
      ('js0002','�����00-2','�����','�����ϵ'),
      ('xx0001','��Ϣ00-1','��Ϣ','��Ϣϵ'),
      ('xx0002','��Ϣ00-2','��Ϣ','��Ϣϵ')
      
insert into Student
values('991101','js9901','�ű�','��','1981-10-1'),
      ('991102','js9901','����','Ů','1980-8-8'),
      ('991103','js9901','���','��','1981-4-5'),
      ('991104','js9901','��ƽ��','��','1981-5-12'),
      ('991201','js9902','�¶���','��','1980-2-8'),
      ('991202','js9902','����','��','1979-12-23'),
      ('991203','js9902','����֥','Ů','1980-2-6'),
      ('991204','js9902','Ҧһ��','��','1981-5-7'),
      ('001101','js0001','�δ�','��','1980-4-9'),
      ('001102','js0001','���','Ů','1978-8-1'),
      ('001201','js0002','��һɽ','��','1980-12-4'),
      ('001202','js0002','ţ��','Ů','1981-6-9'),
      ('002101','xx0001','������','Ů','1981-9-19'),
      ('002102','xx0001','����','��','1980-9-23')
     
insert into Course
values('01001','���������','3'),
      ('01002','�����������','5'),
      ('01003','���ݽṹ','6'),
      ('02001','���ݿ�ԭ����Ӧ��','6'),
      ('02002','���������','6'),
      ('02003','΢��ԭ����Ӧ��','8')
      
insert into Choice
values('991101','01001','88.0')
insert into Choice(s_no,course_no)
 values('991102','01001')
insert into Choice  
values('991103','01001','91.0'),
      ('991104','01001','78.0'),
      ('991201','01001','67.0'),
      ('991101','01002','90.0'),
      ('991102','01002','58.0'),
      ('991103','01002','71.0'),
      ('991104','01002','85.0')
       
insert into Teacher
values('000001','��Ӣ','Ů','1964-11-3','��ʦ'),
      ('000002','����ɽ','��','1955-3-7','������'),
      ('000003','����','��','1960-10-5','��ʦ'),
      ('000004','��Ϊ��','��','1970-3-2','����'),
      ('000005','�κ�Ȼ','��','1966-12-4','��ʦ'),
      ('000006','���ϼ','Ů','1951-5-8','������'),
      ('000007','������','��','1948-4-8','����'),
      ('000008','���ݼ','Ů','1940-11-3','����'),
      ('000009','��һ��','Ů','1962-5-9','��ʦ'),
      ('000010','���','��','1972-11-5','����')
      
insert into Teaching
values('01001','000001'),
      ('01002','000002'),
      ('01003','000002'),
      ('02001','000003'),
      ('02002','000004'),
      ('01001','000005'),
      ('01002','000006'),
      ('01003','000007'),
      ('02001','000007'),
      ('02002','000008')