create table Class
(class_no char(6) primary key,
class_name char(20) not null,
class_special varchar(20),
class_dept char(20))

create table Student
(s_no char(6) primary key,
class_no char(6) not null foreign key references Class(class_no),
s_name varchar(10) not null,
s_sex char(2) check(s_sex='男' or  s_sex='女'),
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
t_sex char(2) check(t_sex='男'or t_sex='女'),
t_birthday datetime not null,
t_title char(10))

create table Teaching(
course_no char(5) foreign key references Course(course_no),
t_no char(6) foreign key references Teacher(t_no)
primary key(course_no,t_no))

insert into Class
values('js9901','计算机99-1','计算机','计算机系'),
      ('js9902','计算机99-2','计算机','计算机系'),
      ('js0001','计算机00-1','计算机','计算机系'),
      ('js0002','计算机00-2','计算机','计算机系'),
      ('xx0001','信息00-1','信息','信息系'),
      ('xx0002','信息00-2','信息','信息系')
      
insert into Student
values('991101','js9901','张彬','男','1981-10-1'),
      ('991102','js9901','王蕾','女','1980-8-8'),
      ('991103','js9901','李建国','男','1981-4-5'),
      ('991104','js9901','李平方','男','1981-5-12'),
      ('991201','js9902','陈东辉','男','1980-2-8'),
      ('991202','js9902','葛鹏','男','1979-12-23'),
      ('991203','js9902','潘桃芝','女','1980-2-6'),
      ('991204','js9902','姚一峰','男','1981-5-7'),
      ('001101','js0001','宋大方','男','1980-4-9'),
      ('001102','js0001','许辉','女','1978-8-1'),
      ('001201','js0002','王一山','男','1980-12-4'),
      ('001202','js0002','牛莉','女','1981-6-9'),
      ('002101','xx0001','李丽丽','女','1981-9-19'),
      ('002102','xx0001','李王','男','1980-9-23')
     
insert into Course
values('01001','计算机基础','3'),
      ('01002','程序设计语言','5'),
      ('01003','数据结构','6'),
      ('02001','数据库原理与应用','6'),
      ('02002','计算机网络','6'),
      ('02003','微机原理与应用','8')
      
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
values('000001','李英','女','1964-11-3','讲师'),
      ('000002','王大山','男','1955-3-7','副教授'),
      ('000003','张朋','男','1960-10-5','讲师'),
      ('000004','陈为君','男','1970-3-2','助教'),
      ('000005','宋浩然','男','1966-12-4','讲师'),
      ('000006','许红霞','女','1951-5-8','副教授'),
      ('000007','徐永军','男','1948-4-8','教授'),
      ('000008','李桂菁','女','1940-11-3','教授'),
      ('000009','王一凡','女','1962-5-9','讲师'),
      ('000010','田峰','男','1972-11-5','助教')
      
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