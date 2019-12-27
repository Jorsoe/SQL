--1
SELECT *
FROM Student

--2
SELECT s_no,s_name
FROM Student

--3
SELECT s_no,s_name,s_birthday
FROM Student
WHERE s_sex = '男'

--4
SELECT s_no,s_name,s_sex,s_birthday
FROM Student
WHERE s_sex = '女' AND s_birthday <= '1980-01-01'

--5
SELECT s_no,s_name,s_sex,s_birthday
FROM Student
WHERE s_name LIKE '李%' AND s_sex = '男'

--6
SELECT s_no,s_name
FROM Student
WHERE s_name LIKE '%一%'

--7
SELECT t_no,t_name,t_title
FROM Teacher
WHERE t_title != '讲师'

--8
SELECT s_no
FROM Choice
WHERE score IS NULL

--9
SELECT s_no,score
FROM Choice
WHERE score < 60
ORDER BY score DESC

--10
SELECT course_no,course_name
FROM Course
WHERE course_no IN ('01001','02001','02003')

--11
SELECT t_no,t_name,t_birthday
FROM Teacher
WHERE t_birthday BETWEEN '1970-01-01' AND '1970-12-31'

--12
SELECT course_no,COUNT(course_no) AS Number
FROM Choice
GROUP BY course_no

--13
SELECT t_no
FROM Teaching
GROUP BY t_no
HAVING (COUNT(course_no) >= 2)

--14
SELECT AVG(score) AS AvgScore,MAX(score) AS MaxScore,MIN(score) AS MinScore
FROM Choice
WHERE Course_no = '01001'

--15
SELECT t_name,t_birthday
FROM Teacher
WHERE t_birthday > '1960-12-31' AND t_title = '讲师'
ORDER BY t_birthday ASC

--查询年龄大于1965年的老师所教授的课程名称
SELECT DISTINCT Course.course_name
FROM Teacher,Course,Teaching
WHERE Teaching.t_no = (SELECT t_no
					   FROM Teacher
					   WHERE t_birthday > '1965-12-31'
					   AND	Teacher.t_no = Teaching.t_no)
AND Course.course_no = Teaching.course_no

--查询计算机基础和计算机网络课被哪些老师教授，列出教师所有信息,并以教师号升序排列
SELECT Teacher.t_no,t_name,t_sex,t_title,t_birthday
FROM Teacher,Teaching
WHERE Teaching.course_no = (SELECT course_no
							FROM Course
							WHERE course_name IN ('计算机基础','计算机网络')
							AND Course.course_no = Teaching.course_no)
AND Teacher.t_no = Teaching.t_no
ORDER BY Teacher.t_no ASC

--查询挂科学生，列出s_no,s_name,class_no,s_sex和s_birthday并以学号升序排列
SELECT DISTINCT Student.s_no,s_name,class_no,s_sex,s_birthday
FROM Student,Choice
WHERE Student.s_no = (SELECT s_no
					  FROM Choice
					  WHERE score < 60
					  AND Choice.s_no = Student.s_no)
ORDER BY s_no ASC

--查询计算机系学生中比信息系学生平均成绩高的学生的具体信息
SELECT Student.s_no
FROM Student,Choice
WHERE ( score > (SELECT AVG(score)
				 FROM Choice
				 WHERE s_no = (SELECT s_no
							   FROM Student
							   Where class_no = (SELECT class_no
												 FROM Class
												 WHERE class_dept = '信息系'
												 AND Student.class_no = Class.class_no)
												 AND Choice.s_no = Student.s_no))
AND Student.s_no = Choice.s_no)