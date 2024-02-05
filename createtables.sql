--	CREATION STUDENT TABLE 

		CREATE TABLE student (
		  sid INTEGER PRIMARY KEY,
		  sname VARCHAR(255),
		  sex VARCHAR(1),
		  age INTEGER,
		  year INTEGER,
		  gpa DOUBLE PRECISION
		);


--	CREATION DEPARTMENT TABLE 

		CREATE TABLE dept (
		  dname VARCHAR(255) PRIMARY KEY,
		  numphds INTEGER
		);


--	CREATION PROFESSOR TABLE 

		CREATE TABLE prof (
		  pname VARCHAR(255),
		  dname VARCHAR(255),
		  PRIMARY KEY (pname),
		  FOREIGN KEY (dname) REFERENCES dept (dname)
		);


--	CREATION COURSE TABLE 

		CREATE TABLE course (
		  cno VARCHAR(255),
		  cname VARCHAR(255),
		  dname VARCHAR(255),
		  PRIMARY KEY (cno, dname),
		  FOREIGN KEY (dname) REFERENCES dept (dname)
		);


--	CREATION MAJOR TABLE 

		CREATE TABLE major (
		  dname VARCHAR(255),
		  sid INTEGER,
		  PRIMARY KEY (dname, sid),
		  FOREIGN KEY (dname) REFERENCES dept (dname),
		  FOREIGN KEY (sid) REFERENCES student (sid)
		);


--	CREATION SECTION TABLE 

		CREATE TABLE section (
		  dname VARCHAR(255),
		  cno VARCHAR(255),
		  sectno INTEGER,
		  pname VARCHAR(255),
		  PRIMARY KEY (dname, cno, sectno),
		  FOREIGN KEY (dname, cno) REFERENCES course (dname, cno)
		);


--	CREATION ENROLL TABLE 

		CREATE TABLE enroll (

			sid INTEGER  ,
			grade NUMERIC,
			dname VARCHAR(255) ,
			cno VARCHAR(255) ,
			sectno INTEGER ,

		  PRIMARY KEY (sid, dname, cno, sectno),
		  FOREIGN KEY (sid) REFERENCES student (sid),
		  FOREIGN KEY (dname, cno, sectno)REFERENCES section (dname, cno, sectno)
		);