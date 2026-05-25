-- Create colleges table
CREATE TABLE colleges (
    college_id SERIAL PRIMARY KEY,
    college_name VARCHAR(100)
);

-- Create students table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100),
    college_id INT,
    join_date DATE,
    FOREIGN KEY (college_id)
    REFERENCES colleges(college_id)
);

-- Create skill modules table
CREATE TABLE skill_modules (
    skill_id SERIAL PRIMARY KEY,
    skill_name VARCHAR(100)
);

-- Create student progress table
CREATE TABLE student_progress (
    progress_id SERIAL PRIMARY KEY,
    student_id INT,
    skill_id INT,
    level_reached INT,
    completed BOOLEAN,
    failed BOOLEAN,
    completion_date DATE,
    FOREIGN KEY (student_id)
    REFERENCES students(student_id),
    FOREIGN KEY (skill_id)
    REFERENCES skill_modules(skill_id)
);

-- Create daily activity table
CREATE TABLE daily_activity (
    activity_id SERIAL PRIMARY KEY,
    student_id INT,
    activity_date DATE,
    FOREIGN KEY(student_id)
    REFERENCES students(student_id)
);

-- Create placements table
CREATE TABLE placements (
    placement_id SERIAL PRIMARY KEY,
    student_id INT,
    placed BOOLEAN,
    FOREIGN KEY(student_id)
    REFERENCES students(student_id)
);
-- Colleges
INSERT INTO colleges (college_name)
VALUES
('QIS College'),
('Narayana Engineering College'),
('VIT'),
('SRM');

-- Students
INSERT INTO students
(student_name,college_id,join_date)
VALUES
('Zubair',1,'2025-01-01'),
('Rahul',1,'2025-01-10'),
('Sneha',2,'2025-01-12'),
('Anjali',2,'2025-01-15'),
('Arjun',3,'2025-01-20'),
('Kiran',4,'2025-01-22');

-- Skill modules
INSERT INTO skill_modules (skill_name)
VALUES
('Aptitude'),
('SQL'),
('Python'),
('Machine Learning');

-- Student Progress
INSERT INTO student_progress
(student_id,skill_id,level_reached,
completed,failed,completion_date)
VALUES
(1,1,55,TRUE,FALSE,'2025-02-20'),
(2,1,35,FALSE,TRUE,'2025-02-22'),
(3,1,60,TRUE,FALSE,'2025-02-15'),
(4,2,70,TRUE,FALSE,'2025-03-01'),
(5,3,40,FALSE,TRUE,'2025-03-03'),
(6,4,80,TRUE,FALSE,'2025-03-05');

-- Daily activity
INSERT INTO daily_activity
(student_id,activity_date)
VALUES
(1,'2025-04-01'),
(1,'2025-04-02'),
(1,'2025-04-03'),
(1,'2025-04-04'),
(1,'2025-04-05'),
(1,'2025-04-06'),
(1,'2025-04-07'),
(2,'2025-04-01'),
(2,'2025-04-03');

-- Placements
INSERT INTO placements(student_id,placed)
VALUES
(1,TRUE),
(2,FALSE),
(3,TRUE),
(4,TRUE),
(5,FALSE),
(6,TRUE);



-- Q1: Average time taken to reach Level 50 in Aptitude by college

SELECT 
    c.college_name,
    ROUND(
        AVG(sp.completion_date - s.join_date),
        2
    ) AS avg_days_to_reach_level50
FROM student_progress sp
JOIN students s
    ON sp.student_id = s.student_id
JOIN colleges c
    ON s.college_id = c.college_id
JOIN skill_modules sm
    ON sp.skill_id = sm.skill_id
WHERE sm.skill_name = 'Aptitude'
AND sp.level_reached >= 50
GROUP BY c.college_name
ORDER BY avg_days_to_reach_level50;