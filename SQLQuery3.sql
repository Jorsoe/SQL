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
						WHERE class_name = '�����99-1')

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
						WHERE course_name = '�����������')

--9
SELECT Student.s_no,s_name,class_name,Course.course_no,course_name,score
FROM Student,Choice,Course,Class
WHERE Student.s_no = Choice.s_no
AND Choice.course_no = Course.course_no 
AND Student.class_no = Class.class_no
AND class_dept = '�����ϵ'

--10
--������
SELECT t_name,course_name
FROM Teacher,Teaching,Course
WHERE Teacher.t_no = Teaching.t_no
AND Teaching.course_no = Course.course_no
--��������
SELECT t_name,course_name
FROM Teacher
LEFT OUTER JOIN Teaching
ON Teacher.t_no = Teaching.t_no
LEFT OUTER JOIN Course
ON Teaching.course_no = Course.course_no
--��������
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
				  WHERE s_name = '����')
				  
--13
SELECT s_name
FROM Student,Choice
WHERE Student.s_no = Choice.s_no
AND course_no IN (SELECT course_no
				   FROM Course
				   WHERE course_name != '���������')
				   
--14
SELECT t_name
FROM Teacher,Teaching
WhERE Teacher.t_no = Teaching.t_no
AND Teaching.course_no = (SELECT course_no
						  FROM Course
						  WHERE course_name = '���ݿ�ԭ����Ӧ��')
UNION
SELECT t_name
FROM Teacher,Teaching
WHERE Teacher.t_no = Teaching.t_no
AND Teaching.course_no = (SELECT course_no
						  FROM Course
						  WHERE course_name = '���ݽṹ')
		
--15
SELECT t_name
FROM Teacher,Teaching
WhERE Teacher.t_no = Teaching.t_no
AND Teaching.course_no = (SELECT course_no
						  FROM Course
						  WHERE course_name = '���ݿ�ԭ����Ӧ��')

--16.��ѯ����"΢��ԭ����Ӧ��"�γ̵Ŀγ̺��Լ���ʦ�ľ�����Ϣ
SELECT Teacher.t_no,t_name,t_sex,t_birthday,t_title,course_no
FROM Teacher,Teaching
WhERE Teacher.t_no = Teaching.t_no
AND Teaching.course_no = (SELECT course_no
						  FROM Course
						  WHERE course_name = '�����������')
						  
--17.��ѯ����ͬѧ���Ҽ����ѧ�ţ��������Ա��ѧ�����
SELECT Choice.s_no,s_name,s_sex,SUM(course_sorce) AS total_score
FROM Choice INNER JOIN Course
ON Choice.course_no = Course.course_no
			INNER JOIN Student
ON Choice.s_no = Student.s_no
WHERE score >= 60
AND s_name LIKE '��%'
GROUP BY Choice.s_no,s_name,s_sex

--18.��ѯ����Ůͬѧ��ѡ������
SELECT Student.s_no,s_name,COUNT(course_no) AS choice_num
FROM Student,Choice
WHERE Student.s_no = Choice.s_no
AND s_sex = 'Ů'
GROUP BY Student.s_no,s_name

--19.��ѯ���������ڿγ̵Ŀγ���
SELECT t_name,COUNT(Teacher.t_no) AS course_number
FROM Teacher,Teaching
WHERE Teacher.t_no = Teaching.t_no
AND t_title = '����'
GROUP BY t_name

--20.��ѯ�ű�����ͬ��ͬѧ�ľ�����Ϣ
SELECT *
FROM Student
WHERE class_no = (SELECT class_no
				  FROM Student
				  WHERE s_name = '�ű�')
UNION
SELECT *
FROM Student
WHERE class_no = (SELECT class_no
				  FROM Student
				  WHERE s_name = '���')

--21.ͳ�Ƹ����������ڿγ̵�ѧ������
SELECT t_name,COUNT(s_no) AS Student_Num
FROM Teacher,Teaching,Choice
WHERE Teaching.course_no = Choice.course_no
AND Teacher.t_no = Teaching.t_no
AND Teaching.t_no IN (SELECT t_no
					  FROM Teacher 
					  WHERE t_title = '������')
GROUP BY t_name

--22.ͳ��ȫ����ʦ���ڵĿγ���
SELECT t_no,COUNT(course_no)
FROM Teaching
WHERE Teaching.t_no IN (SELECT t_no
					   FROM Teacher)
GROUP BY t_no

--23.��ѯ1980���Ժ�Ĳ���ѡ�����ſ����ϵ�ѧ��ѡ��ѧ����
SELECT s_name
FROM Choice,Student
WHERE Student.s_no = Choice.s_no
AND Choice.s_no IN (SElECT s_no
					  FROM Student
				      WHERE s_birthday > '1980-01-01')
GROUP BY s_name
HAVING COUNT(course_no)>=2

--24.��ѯ������Ϣ00-1��ͬѧ��ѡ�μ��ɼ����
SELECT Student.s_no,s_name,Course.course_no,course_name,score
FROM Student,Course,Choice
WHERE Student.s_no = Choice.s_no AND Choice.course_no = Course.course_no
AND Student.class_no IN (SELECT class_no
						FROM Class
						WHERE class_name != '��Ϣ00-1')
						
--25.��ѯ��������ʦ���ο����������Ѳ�ѯ����Ž�һ��Num_ManTea��
SELECT t_name,COUNT(Teacher.t_no) AS course_number
INTO Num_ManTea
FROM Teacher,Teaching
WHERE Teacher.t_no = Teaching.t_no
AND t_sex = '��'
GROUP BY t_name