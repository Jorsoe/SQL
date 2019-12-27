--1
CREATE VIEW SubS
AS SELECT s_no,s_name,s_birthday
   FROM Student

--2	
CREATE VIEW S_SC_C(s_no,s_name,course_name,score)
AS SELECT Student.s_no,s_name,course_name,score
   FROM Student,Course,Choice
   WHERE Student.s_no = Choice.s_no
   AND Choice.course_no = Course.course_no	

--3
CREATE VIEW S_Avg(s_no,average_score)
AS SELECT Student.s_no,AVG(score)
   FROM Student,Choice
   WHERE Student.s_no = Choice.s_no
   GROUP BY Student.s_no

--4
CREATE VIEW Class_View(class_no,class_name,course_num)
AS SELECT Class.class_no,class_name,COUNT(s_no)
   FROM Student,Class
   WHERE Class.class_no = Student.class_no
   GROUP BY Class.class_no,class_name

--5
CREATE VIEW Teacher_Teacher(t_no,t_name,class_name)
AS SELECT Teacher.t_no,t_name,course_name
   FROM Teacher,Teaching,Course
   WHERE Teacher.t_no = Teaching.t_no
   AND Teaching.course_no = Course.course_no

--6
SELECT course_name,score
FROM S_SC_C
WHERE s_name = '张彬'

--7
SELECT AVG(average_score)
FROM S_Avg
WHERE s_no = 991102

--8
DROP VIEW S_Avg
--9.创建数据库原理与应用视图，包含讲授这门课的教师号和名称
CREATE VIEW Teacher_SQL(t_no,t_name)
AS SELECT Teacher.t_no,t_name
   FROM Teacher ,Teaching,Course
   WHERE Teacher.t_no = Teaching.t_no
   AND Teaching.course_no = Course.course_no
   AND course_name = '数据库原理与应用'
   
--10.创建最高分视图，包含每门课程的最高分
CREATE VIEW Max_Score
AS SELECT course_name,MAX(score) AS max_score
   FROM Choice,Course
   WHERE Choice.course_no = Course.course_no
   GROUP BY course_name
   
--11.创建计算机系王姓学生视图，包含学号和姓名
CREATE VIEW WANG_View(s_no,s_name)
AS SELECT s_no,s_name
   FROM Student ,Class
   WHERE Student.class_no = Class.class_no
   AND s_name like '王%'
   AND class_special = '计算机'
   
--12.从Teacher_SQL中拿出教师号和名称
SELECT t_no,t_name
FROM Teacher_SQL

--13.连接SubS和S_SC_C视图，输出学生姓名，学号，生日，所选课程名，以及成绩
SELECT DISTINCT SubS.s_no,SubS.s_name,s_birthday,course_name,score
FROM SubS,S_SC_C
WHERE SubS.s_no = S_SC_C.s_no