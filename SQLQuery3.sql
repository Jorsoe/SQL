--1
SELECT Student.s_no,s_name,course_no,score
FROM Student,Choice
WHERE Student.s_no = Choice.s_no

--2
SELECT s_name,course_name,score
INTO new_table
FROM Student,Course,Choice
WHERE Student.s_no = Choice.s_no AND Choice.course_no = Course.course_no

--3
SELECT Student.s_no,s_name,Course.course_no,course_name,score
FROM Student,Course,Choice
WHERE Student.s_no = Choice.s_no AND Choice.course_no = Course.course_no
AND Student.class_no = (SELECT class_no
						FROM Class
						WHERE class_name = '计算机99-1')

--4
SELECT Choice.s_no,s_name,SUM(course_sorce) AS total_score
FROM Choice INNER JOIN Course
ON Choice.course_no = Course.course_no
			INNER JOIN Student
ON Choice.s_no = Student.s_no
WHERE score >= 60
GROUP BY Choice.s_no,s_name

--5
SELECT Student.s_no,s_name,AVG(score) AS average_score,COUNT(course_no) AS choice_num
FROM Student,Choice
WHERE Student.s_no = Choice.s_no
GROUP BY Student.s_no,s_name

--6
SELECT Student.s_no,s_name,Course.course_no,course_name
FROM Student,Choice,Course
WHERE Student.s_no = Choice.s_no
AND Choice.course_no = Course.course_no
AND score IS NULL

--7
SELECT Student.s_no,s_name,Course.course_no,course_name,course_sorce
FROM Student,Choice,Course
WHERE Student.s_no = Choice.s_no
AND Choice.course_no = Course.course_no
AND score < 60

--8
SELECT s_name,score
FROM Student,Choice
WHERE Student.s_no = Choice.s_no
AND Choice.course_no = (SELECT course_no
						FROM Course
						WHERE course_name = '程序设计语言')

--9
SELECT Student.s_no,s_name,class_name,Course.course_no,course_name,score
FROM Student,Choice,Course,Class
WHERE Student.s_no = Choice.s_no
AND Choice.course_no = Course.course_no 
AND Student.class_no = Class.class_no
AND class_dept = '计算机系'

--10
--内连接
SELECT t_name,course_name
FROM Teacher,Teaching,Course
WHERE Teacher.t_no = Teaching.t_no
AND Teaching.course_no = Course.course_no
--左外连接
SELECT t_name,course_name
FROM Teacher
LEFT OUTER JOIN Teaching
ON Teacher.t_no = Teaching.t_no
LEFT OUTER JOIN Course
ON Teaching.course_no = Course.course_no
--右外连接
SELECT t_name,course_name
FROM Teacher
RIGHT OUTER JOIN Teaching
ON Teaching.t_no = Teacher.t_no
RIGHT OUTER JOIN Course
ON Course.course_no = Teaching.course_no

--11
SELECT t_name,COUNT(Teacher.t_no) AS course_number
FROM Teacher,Teaching
WHERE Teacher.t_no = Teaching.t_no
GROUP BY t_name

--12
SELECT s_name
FROM Student
WHERE class_no = (SELECT class_no
				  FROM Student
				  WHERE s_name = '王蕾')
				  
--13
SELECT s_name
FROM Student,Choice
WHERE Student.s_no = Choice.s_no
AND course_no IN (SELECT course_no
				   FROM Course
				   WHERE course_name != '计算机基础')
				   
--14
SELECT t_name
FROM Teacher,Teaching
WhERE Teacher.t_no = Teaching.t_no
AND Teaching.course_no = (SELECT course_no
						  FROM Course
						  WHERE course_name = '数据库原理与应用')
UNION
SELECT t_name
FROM Teacher,Teaching
WHERE Teacher.t_no = Teaching.t_no
AND Teaching.course_no = (SELECT course_no
						  FROM Course
						  WHERE course_name = '数据结构')
		
--15
SELECT t_name
FROM Teacher,Teaching
WhERE Teacher.t_no = Teaching.t_no
AND Teaching.course_no = (SELECT course_no
						  FROM Course
						  WHERE course_name = '数据库原理与应用')

--16.查询讲授"微机原理与应用"课程的课程号以及老师的具体信息
SELECT Teacher.t_no,t_name,t_sex,t_birthday,t_title,course_no
FROM Teacher,Teaching
WhERE Teacher.t_no = Teaching.t_no
AND Teaching.course_no = (SELECT course_no
						  FROM Course
						  WHERE course_name = '程序设计语言')
						  
--17.查询姓李同学并且及格的学号，姓名，性别和学分情况
SELECT Choice.s_no,s_name,s_sex,SUM(course_sorce) AS total_score
FROM Choice INNER JOIN Course
ON Choice.course_no = Course.course_no
			INNER JOIN Student
ON Choice.s_no = Student.s_no
WHERE score >= 60
AND s_name LIKE '李%'
GROUP BY Choice.s_no,s_name,s_sex

--18.查询所有女同学的选课门数
SELECT Student.s_no,s_name,COUNT(course_no) AS choice_num
FROM Student,Choice
WHERE Student.s_no = Choice.s_no
AND s_sex = '女'
GROUP BY Student.s_no,s_name

--19.查询教授所教授课程的课程数
SELECT t_name,COUNT(Teacher.t_no) AS course_number
FROM Teacher,Teaching
WHERE Teacher.t_no = Teaching.t_no
AND t_title = '教授'
GROUP BY t_name

--20.查询张彬和许辉同班同学的具体信息
SELECT *
FROM Student
WHERE class_no = (SELECT class_no
				  FROM Student
				  WHERE s_name = '张彬')
UNION
SELECT *
FROM Student
WHERE class_no = (SELECT class_no
				  FROM Student
				  WHERE s_name = '许辉')

--21.统计副教授所教授课程的学生人数
SELECT t_name,COUNT(s_no) AS Student_Num
FROM Teacher,Teaching,Choice
WHERE Teaching.course_no = Choice.course_no
AND Teacher.t_no = Teaching.t_no
AND Teaching.t_no IN (SELECT t_no
					  FROM Teacher 
					  WHERE t_title = '副教授')
GROUP BY t_name

--22.统计全部老师讲授的课程数
SELECT t_no,COUNT(course_no)
FROM Teaching
WHERE Teaching.t_no IN (SELECT t_no
					   FROM Teacher)
GROUP BY t_no

--23.查询1980年以后的并且选了两门课以上的学生选的学生名
SELECT s_name
FROM Choice,Student
WHERE Student.s_no = Choice.s_no
AND Choice.s_no IN (SElECT s_no
					  FROM Student
				      WHERE s_birthday > '1980-01-01')
GROUP BY s_name
HAVING COUNT(course_no)>=2

--24.查询不是信息00-1班同学的选课及成绩情况
SELECT Student.s_no,s_name,Course.course_no,course_name,score
FROM Student,Course,Choice
WHERE Student.s_no = Choice.s_no AND Choice.course_no = Course.course_no
AND Student.class_no IN (SELECT class_no
						FROM Class
						WHERE class_name != '信息00-1')
						
--25.查询所有男老师的任课门数，并把查询结果放进一个Num_ManTea中
SELECT t_name,COUNT(Teacher.t_no) AS course_number
INTO Num_ManTea
FROM Teacher,Teaching
WHERE Teacher.t_no = Teaching.t_no
AND t_sex = '男'
GROUP BY t_name