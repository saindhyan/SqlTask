/*	1. Print the names of professors who work in departments
	   that have fewer than 50 PhD students.*/

			SELECT P.pname
			FROM prof P JOIN dept D ON P.dname=D.dname
			WHERE numphds<=50;

/*	2. Print the names of the students with the lowest GPA */

			SELECT S.sname
			FROM student S 
			WHERE S.gpa<=ALL(SELECT gpa FROM student);			 
				 
				 
/*	3. For each Computer Sciences class, print the class number,
	   section number, and the average gpa of the students
	   enrolled in the class section.*/

			SELECT C.cno,S.sectno, AVG(St.gpa) as avg_gpa 
			FROM ((enroll E JOIN student st ON st.sid=E.sid) 
				  JOIN section S ON S.sectno=e.sectno )
				  JOIN course C ON(E.cno=C.cno)
			WHERE C.dname='Computer Sciences' 
			GROUP BY C.cno,S.sectno


/*	4. Print the names and section numbers of all sections with
	   more than six students enrolled in them */

			SELECT DISTINCT dname , sectno 
			FROM section 
			WHERE sectno IN  (SELECT sectno 
							  FROM enroll 
							  GROUP BY sectno 
							  HAVING COUNT(sid )>6);


/*	5. Print the name(s) and sid(s) of the student(s) enrolled in
	   the most sections.*/

			SELECT sname , sid 
			FROM student 
			WHERE sid IN (SELECT sid 
						  FROM enroll 
			 			  GROUP BY sid 
						  HAVING COUNT(DISTINCT sectno) = (SELECT MAX(seccount)
														   FROM (
															   SELECT count( DISTINCT sectno) 
															   AS seccount
															   FROM enroll
															   GROUP BY sid)AS counts));							
									
									
/*	6. Print the names of departments that have one or more majors
	   who are under 18 years old.*/

			SELECT  D.dname 
			FROM (major M 
				  JOIN student S ON M.sid = S.sid) 
				  JOIN dept D ON D.dname=M.dname  
			WHERE S.age<18


/*	7. Print the names and majors of students who are taking one of
	   the College Geometry courses.*/

			SELECT S.sname,M.dname 
			FROM ((student S JOIN major M ON M.sid=S.sid) 
				  JOIN enroll E ON S.sid=E.sid) 
				  JOIN course C ON C.cno=E.cno 
			WHERE C.cname LIKE '%College Geometry%'


/*	8. For those departments that have no major taking a College 
	   Geometry course print the department name and the number 
	   of PhD students in the department.*/

			SELECT D.dname ,D.numphds 
			FROM dept D
			WHERE  D.dname  NOT IN (SELECT C.dname 
									FROM course C 
									JOIN major M ON M.dname=C.dname
									WHERE C.cname LIKE '%College Geometry%')
						

/*	9. Print the names of students who are taking 
	  both a Computer Sciences course and a Mathematics course.*/

			SELECT S.sname 
			FROM student S JOIN enroll E ON S.sid=E.sid 
			WHERE E.dname='Computer Sciences' 
			AND S.sid IN (SELECT student.sid 
							FROM student  
							JOIN enroll ON student.sid=enroll.sid
							WHERE dname='Mathematics')																
																				
													
/*	10. Print the age difference between the oldest and the
	    youngest Computer Sciences major.*/

			WITH age as(
						SELECT S.age 
								FROM student S JOIN major M ON M.sid=S.sid 
								WHERE M.dname='Computer Sciences')
			SELECT MAX(age)-MIN(age) FROM age


/*	11. For each department that has one or more majors with a 
		GPA under 1.0, print the name of the department and the average 
		GPA of its majors.*/

			SELECT M.dname ,AVG(S.gpa) 
			FROM major M JOIN student S ON S.sid=M.sid 
			AND M.dname IN (SELECT dname  
							FROM student join major on major.sid=student.sid 
							WHERE gpa <1.0) 
			GROUP BY M.dname


/*	12. Print the ids, names and GPAs of the students who are currently 
		taking all the Civil Engineering courses.*/

			SELECT S.sid , S.sname , S.gpa
			FROM student S
			WHERE S.sid IN (
						SELECT sid 
						FROM enroll
						JOIN course ON enroll.cno = course.cno
						WHERE course.dname = 'Civil Engineering'
						GROUP BY sid
						HAVING COUNT(DISTINCT enroll.cno )=(
						SELECT COUNT(course.cno)
						FROM course 
						WHERE dname='Civil Engineering'
						));