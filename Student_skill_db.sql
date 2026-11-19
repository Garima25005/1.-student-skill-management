CREATE DATABASE IF NOT EXISTS student_skill_db;
USE student_skill_db;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    email_address VARCHAR(100) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    programming_score DOUBLE CHECK (programming_score BETWEEN 0 AND 100),
    mathematics_score DOUBLE CHECK (mathematics_score BETWEEN 0 AND 100)
);

CREATE TABLE student_skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    skill_name VARCHAR(50),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
);

INSERT INTO students VALUES
(101, 'Garima', 'garima@gmail.com', 'B.Tech CSE', 88.0, 92.0),
(102, 'Beauty', 'beauty@gmail.com', 'B.Tech CSE', 45.0, 80.0),
(103, 'Trisha', 'trisha@gmail.com', 'BCA', 76.0, 72.0),
(104, 'Ayushi', 'ayushi@gmail.com', 'B.Tech IT', 55.0, 60.0);

INSERT INTO student_skills (student_id, skill_name) VALUES
(101, 'Java'), (101, 'Spring Boot'), (101, 'MySQL'),
(102, 'Java'), (102, 'Python'),
(103, 'Spring Boot'), (103, 'HTML'),
(104, 'MySQL'), (104, 'C++');

-- 1, 2 & 3: Average Score, Performance Category, aur Stronger Subject
SELECT student_id, student_name,
    ROUND((programming_score + mathematics_score) / 2, 2) AS average_score,
    CASE 
        WHEN (programming_score + mathematics_score) / 2 >= 85 THEN 'Excellent'
        WHEN (programming_score + mathematics_score) / 2 >= 70 THEN 'Good'
        WHEN (programming_score + mathematics_score) / 2 >= 50 THEN 'Satisfactory'
        ELSE 'Needs Improvement'
    END AS performance_category,
    CASE 
        WHEN programming_score > mathematics_score THEN 'Programming'
        WHEN mathematics_score > programming_score THEN 'Mathematics'
        ELSE 'Equal'
    END AS stronger_subject
FROM students;

-- 4: Search by ID, Email, or Course
SELECT * FROM students 
WHERE student_id = 101 OR email_address = 'garima@gmail.com' OR course_name = 'B.Tech CSE';

-- 5: Merit List (Descending Order)
SELECT student_id, student_name, ROUND((programming_score + mathematics_score) / 2, 2) AS average_score
FROM students ORDER BY average_score DESC;

-- 6: Same Technical Skills wale Students
SELECT s1.student_name AS student_1, s2.student_name AS student_2, sk1.skill_name AS common_skill
FROM student_skills sk1
JOIN student_skills sk2 ON sk1.skill_name = sk2.skill_name AND sk1.student_id < sk2.student_id
JOIN students s1 ON sk1.student_id = s1.student_id
JOIN students s2 ON sk2.student_id = s2.student_id;

-- 7: Programming < 50 lekin Mathematics >= 75 wale Students
SELECT * FROM students WHERE programming_score < 50 AND mathematics_score >= 75;
