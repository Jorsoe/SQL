--1
SELECT *
FROM Student

--2
SELECT s_no,s_name
FROM Student

--3
SELECT s_no,s_name,s_birthday
FROM Student
WHERE s_sex = '��'

--4
SELECT s_no,s_name,s_sex,s_birthday
FROM Student
WHERE s_sex = 'Ů' AND s_birthday <= '1980-01-01'

--5
SELECT s_no,s_name,s_sex,s_birthday
FROM Student
WHERE s_name LIKE '��%' AND s_sex = '��'

--6
SELECT s_no,s_name
FROM Student
WHERE s_name LIKE '%һ%'

--7
SELECT t_no,t_name,t_title
FROM Teacher
WHERE t_title != '��ʦ'

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
WHERE t_birthday > '1960-12-31' AND t_title = '��ʦ'
ORDER BY t_birthday ASC

--��ѯ�������1965�����ʦ�����ڵĿγ�����
SELECT DISTINCT Course.course_name
FROM Teacher,Course,Teaching
WHERE Teaching.t_no = (SELECT t_no
					   FROM Teacher
					   WHERE t_birthday > '1965-12-31'
					   AND	Teacher.t_no = Teaching.t_no)
AND Course.course_no = Teaching.course_no

--��ѯ����������ͼ��������α���Щ��ʦ���ڣ��г���ʦ������Ϣ,���Խ�ʦ����������
SELECT Teacher.t_no,t_name,t_sex,t_title,t_birthday
FROM Teacher,Teaching
WHERE Teaching.course_no = (SELECT course_no
							FROM Course
							WHERE course_name IN ('���������','���������')
							AND Course.course_no = Teaching.course_no)
AND Teacher.t_no = Teaching.t_no
ORDER BY Teacher.t_no ASC

--��ѯ�ҿ�ѧ�����г�s_no,s_name,class_no,s_sex��s_birthday����ѧ����������
SELECT DISTINCT Student.s_no,s_name,class_no,s_sex,s_birthday
FROM Student,Choice
WHERE Student.s_no = (SELECT s_no
					  FROM Choice
					  WHERE score < 60
					  AND Choice.s_no = Student.s_no)
ORDER BY s_no ASC

--��ѯ�����ϵѧ���б���Ϣϵѧ��ƽ���ɼ��ߵ�ѧ���ľ�����Ϣ
SELECT Student.s_no
FROM Student,Choice
WHERE ( score > (SELECT AVG(score)
				 FROM Choice
				 WHERE s_no = (SELECT s_no
							   FROM Student
							   Where class_no = (SELECT class_no
												 FROM Class
												 WHERE class_dept = '��Ϣϵ'
												 AND Student.class_no = Class.class_no)
												 AND Choice.s_no = Student.s_no))
AND Student.s_no = Choice.s_no)