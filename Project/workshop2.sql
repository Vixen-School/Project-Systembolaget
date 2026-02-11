create table Lecturers (
	lecturer_id int auto_increment primary key,
    name varchar(500) not null,
    email varchar(500) not null
);

create table Courses (
	course_id int auto_increment primary key,
    title varchar(500)
);

create table Students (
	student_id int auto_increment primary key,
    name varchar(500) not null,
    email varchar(500) not null
);

-- Junction table
create table Enrollment (
	student_id int,
    course_id int,
    primary key (student_id, course_id),
    foreign key (student_id) references Students(student_id),
    foreign key (course_id) references Courses(course_id)
);

