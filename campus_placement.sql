
-- CAMPUS PLACEMENT INTELLIGENCE & ANALYTICS SYSTEM
-- STEP 1: DATABASE SCHEMA

-- Drop tables in dependency order so the script can be rerun
DROP TABLE IF EXISTS placement_offers;
DROP TABLE IF EXISTS interview_rounds;
DROP TABLE IF EXISTS applications;
DROP TABLE IF EXISTS role_skills;
DROP TABLE IF EXISTS student_skills;
DROP TABLE IF EXISTS job_roles;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS companies;
DROP TABLE IF EXISTS students;

-- 1. Students
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(50) NOT NULL,
    graduation_year INT NOT NULL,
    cgpa DECIMAL(4,2) NOT NULL,
    tenth_percentage DECIMAL(5,2),
    twelfth_percentage DECIMAL(5,2),
    active_backlogs INT DEFAULT 0,
    CHECK (cgpa BETWEEN 0 AND 10),
    CHECK (active_backlogs >= 0)
);

-- 2. Companies
CREATE TABLE companies (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL UNIQUE,
    industry VARCHAR(80),
    location VARCHAR(100)
);

-- 3. Job roles offered by companies
CREATE TABLE job_roles (
    role_id INT PRIMARY KEY,
    company_id INT NOT NULL,
    role_title VARCHAR(100) NOT NULL,
    min_cgpa DECIMAL(4,2) DEFAULT 0,
    max_backlogs INT DEFAULT 0,
    min_tenth_percentage DECIMAL(5,2) DEFAULT 0,
    min_twelfth_percentage DECIMAL(5,2) DEFAULT 0,
    package_lpa DECIMAL(8,2),
    FOREIGN KEY (company_id) REFERENCES companies(company_id),
    CHECK (min_cgpa BETWEEN 0 AND 10),
    CHECK (max_backlogs >= 0)
);

-- 4. Technical skills
CREATE TABLE skills (
    skill_id INT PRIMARY KEY,
    skill_name VARCHAR(60) NOT NULL UNIQUE
);

-- 5. Skills possessed by students
CREATE TABLE student_skills (
    student_id INT,
    skill_id INT,
    proficiency_level VARCHAR(20) DEFAULT 'Intermediate',
    PRIMARY KEY (student_id, skill_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

-- 6. Skills required for each job role
CREATE TABLE role_skills (
    role_id INT,
    skill_id INT,
    is_required BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (role_id, skill_id),
    FOREIGN KEY (role_id) REFERENCES job_roles(role_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

-- 7. Student applications to job roles
CREATE TABLE applications (
    application_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    role_id INT NOT NULL,
    application_date DATE NOT NULL,
    application_status VARCHAR(25) DEFAULT 'Applied',
    UNIQUE (student_id, role_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (role_id) REFERENCES job_roles(role_id)
);

-- 8. Interview rounds for each application
CREATE TABLE interview_rounds (
    round_id INT PRIMARY KEY,
    application_id INT NOT NULL,
    round_number INT NOT NULL,
    round_name VARCHAR(50) NOT NULL,
    round_status VARCHAR(20) DEFAULT 'Pending',
    interview_date DATE,
    UNIQUE (application_id, round_number),
    FOREIGN KEY (application_id)
        REFERENCES applications(application_id)
);

-- 9. Placement offers
CREATE TABLE placement_offers (
    offer_id INT PRIMARY KEY,
    application_id INT NOT NULL UNIQUE,
    offered_ctc_lpa DECIMAL(8,2) NOT NULL,
    offer_date DATE NOT NULL,
    offer_status VARCHAR(20) DEFAULT 'Accepted',
    FOREIGN KEY (application_id)
        REFERENCES applications(application_id)
);

-- Verify that all 9 tables were created
SHOW TABLES;



-- STEP 2: INSERT SAMPLE DATA

INSERT INTO students VALUES
(1, 'Aarav Sharma', 'aarav@gmail.com', 'CSE', 2027, 8.7, 90, 88, 0),
(2, 'Priya Das', 'priya@gmail.com', 'CSE', 2027, 9.2, 95, 93, 0),
(3, 'Rahul Patnaik', 'rahul@gmail.com', 'IT', 2027, 7.4, 78, 75, 1),
(4, 'Sneha Mohanty', 'sneha@gmail.com', 'CSE', 2027, 8.1, 85, 82, 0),
(5, 'Vikash Singh', 'vikash@gmail.com', 'ECE', 2027, 6.8, 72, 70, 2),
(6, 'Ananya Roy', 'ananya@gmail.com', 'IT', 2027, 8.9, 92, 90, 0),
(7, 'Rohan Mishra', 'rohan@gmail.com', 'CSE', 2027, 7.9, 80, 79, 0),
(8, 'Meera Sahu', 'meera@gmail.com', 'CSE', 2027, 9.5, 96, 94, 0);

INSERT INTO companies VALUES
(1, 'TCS', 'IT Services', 'Bengaluru'),
(2, 'Infosys', 'IT Services', 'Bengaluru'),
(3, 'Accenture', 'Consulting', 'Hyderabad'),
(4, 'Microsoft', 'Technology', 'Hyderabad');

INSERT INTO job_roles VALUES
(101, 1, 'Software Engineer', 6.0, 0, 60, 60, 4.5),
(102, 2, 'System Engineer', 6.5, 0, 60, 60, 5.0),
(103, 3, 'Data Analyst', 7.0, 0, 65, 65, 6.0),
(104, 4, 'Software Developer', 8.5, 0, 80, 80, 18.0);

INSERT INTO skills VALUES
(1, 'SQL'),
(2, 'Python'),
(3, 'Java'),
(4, 'C++'),
(5, 'Power BI'),
(6, 'Machine Learning');

INSERT INTO student_skills VALUES
(1, 1, 'Advanced'), (1, 2, 'Intermediate'), (1, 3, 'Intermediate'),
(2, 1, 'Advanced'), (2, 2, 'Advanced'), (2, 6, 'Advanced'),
(3, 1, 'Intermediate'), (3, 3, 'Intermediate'),
(4, 1, 'Intermediate'), (4, 2, 'Advanced'), (4, 5, 'Intermediate'),
(5, 3, 'Intermediate'), (5, 4, 'Intermediate'),
(6, 1, 'Advanced'), (6, 2, 'Advanced'), (6, 5, 'Advanced'),
(7, 3, 'Advanced'), (7, 4, 'Intermediate'),
(8, 1, 'Advanced'), (8, 2, 'Advanced'), (8, 3, 'Advanced'),
(8, 6, 'Advanced');

INSERT INTO role_skills VALUES
(101, 1, TRUE), (101, 3, TRUE),
(102, 1, TRUE), (102, 2, TRUE),
(103, 1, TRUE), (103, 2, TRUE), (103, 5, TRUE),
(104, 2, TRUE), (104, 3, TRUE), (104, 6, TRUE);

INSERT INTO applications VALUES
(1001, 1, 101, '2026-08-01', 'Selected'),
(1002, 2, 102, '2026-08-02', 'Selected'),
(1003, 3, 101, '2026-08-03', 'Rejected'),
(1004, 4, 103, '2026-08-04', 'Interview'),
(1005, 5, 101, '2026-08-05', 'Rejected'),
(1006, 6, 103, '2026-08-06', 'Selected'),
(1007, 7, 102, '2026-08-07', 'Interview'),
(1008, 8, 104, '2026-08-08', 'Selected'),
(1009, 1, 103, '2026-08-09', 'Interview'),
(1010, 4, 101, '2026-08-10', 'Selected');

INSERT INTO interview_rounds VALUES
(1, 1001, 1, 'Technical', 'Passed', '2026-08-05'),
(2, 1001, 2, 'HR', 'Passed', '2026-08-07'),
(3, 1002, 1, 'Technical', 'Passed', '2026-08-06'),
(4, 1002, 2, 'HR', 'Passed', '2026-08-08'),
(5, 1003, 1, 'Technical', 'Failed', '2026-08-09'),
(6, 1004, 1, 'Technical', 'Passed', '2026-08-11'),
(7, 1006, 1, 'Technical', 'Passed', '2026-08-12'),
(8, 1006, 2, 'HR', 'Passed', '2026-08-14'),
(9, 1008, 1, 'Technical', 'Passed', '2026-08-15'),
(10, 1010, 1, 'Technical', 'Passed', '2026-08-16');

INSERT INTO placement_offers VALUES
(1, 1001, 4.5, '2026-08-07', 'Accepted'),
(2, 1002, 5.0, '2026-08-08', 'Accepted'),
(3, 1006, 6.0, '2026-08-14', 'Accepted'),
(4, 1008, 18.0, '2026-08-16', 'Accepted'),
(5, 1010, 4.5, '2026-08-17', 'Accepted');

-- Verify the inserted data
SELECT * FROM students;
SELECT * FROM companies;
SELECT * FROM job_roles;


SELECT COUNT(*) AS total_students FROM students;

SELECT COUNT(*) AS total_companies FROM companies;

SELECT COUNT(*) AS total_job_roles FROM job_roles;

SELECT COUNT(*) AS total_applications FROM applications;

SELECT COUNT(*) AS total_offers FROM placement_offers;




-- STEP 4: STUDENT ELIGIBILITY SYSTEM

SELECT
    s.student_id,
    s.student_name,
    s.department,
    c.company_name,
    j.role_title,
    s.cgpa,
    s.active_backlogs,
    j.package_lpa,
    CASE
        WHEN s.cgpa >= j.min_cgpa
         AND s.active_backlogs <= j.max_backlogs
         AND s.tenth_percentage >= j.min_tenth_percentage
         AND s.twelfth_percentage >= j.min_twelfth_percentage
        THEN 'Eligible'
        ELSE 'Not Eligible'
    END AS eligibility_status
FROM students s
CROSS JOIN job_roles j
JOIN companies c
    ON j.company_id = c.company_id
ORDER BY s.student_id, c.company_name;



SELECT
    s.student_name,
    c.company_name,
    j.role_title,
    s.cgpa,
    j.package_lpa
FROM students s
CROSS JOIN job_roles j
JOIN companies c
    ON j.company_id = c.company_id
WHERE s.cgpa >= j.min_cgpa
  AND s.active_backlogs <= j.max_backlogs
  AND s.tenth_percentage >= j.min_tenth_percentage
  AND s.twelfth_percentage >= j.min_twelfth_percentage
ORDER BY j.package_lpa DESC, s.cgpa DESC;




-- STEP 6: STUDENT SKILL MATCHING SYSTEM

SELECT
    s.student_name,
    c.company_name,
    j.role_title,
    COUNT(rs.skill_id) AS total_required_skills,
    COUNT(ss.skill_id) AS matched_skills,
    ROUND(
        COUNT(ss.skill_id) * 100.0 /
        NULLIF(COUNT(rs.skill_id), 0), 2
    ) AS skill_match_percentage
FROM students s
CROSS JOIN job_roles j
JOIN companies c
    ON j.company_id = c.company_id
JOIN role_skills rs
    ON j.role_id = rs.role_id
LEFT JOIN student_skills ss
    ON s.student_id = ss.student_id
    AND rs.skill_id = ss.skill_id
GROUP BY
    s.student_id,
    s.student_name,
    c.company_name,
    j.role_id,
    j.role_title
ORDER BY skill_match_percentage DESC;





-- STEP 7: COMPANY-WISE PLACEMENT ANALYTICS

SELECT
    c.company_name,
    COUNT(a.application_id) AS total_applications,
    SUM(
        CASE
            WHEN a.application_status = 'Selected'
            THEN 1 ELSE 0
        END
    ) AS selected_students,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN a.application_status = 'Selected'
                THEN 1 ELSE 0
            END
        ) / NULLIF(COUNT(a.application_id), 0),
        2
    ) AS selection_rate_percentage,
    ROUND(AVG(po.offered_ctc_lpa), 2)
        AS average_package_lpa,
    MAX(po.offered_ctc_lpa) AS highest_package_lpa
FROM companies c
LEFT JOIN job_roles j
    ON c.company_id = j.company_id
LEFT JOIN applications a
    ON j.role_id = a.role_id
LEFT JOIN placement_offers po
    ON a.application_id = po.application_id
GROUP BY c.company_id, c.company_name
ORDER BY selection_rate_percentage DESC;




-- STEP 8: IN-DEMAND TECHNICAL SKILLS

SELECT
    sk.skill_name,
    COUNT(rs.role_id) AS companies_requiring_skill,
    COUNT(DISTINCT ss.student_id) AS students_with_skill
FROM skills sk
LEFT JOIN role_skills rs
    ON sk.skill_id = rs.skill_id
LEFT JOIN student_skills ss
    ON sk.skill_id = ss.skill_id
GROUP BY sk.skill_id, sk.skill_name
ORDER BY companies_requiring_skill DESC,
         students_with_skill DESC;




-- STEP 10: INTERVIEW ROUND ANALYTICS

SELECT
    round_name,
    COUNT(*) AS total_candidates,
    SUM(
        CASE WHEN round_status = 'Passed'
        THEN 1 ELSE 0 END
    ) AS candidates_passed,
    ROUND(
        100.0 * SUM(
            CASE WHEN round_status = 'Passed'
            THEN 1 ELSE 0 END
        ) / COUNT(*),
        2
    ) AS pass_percentage
FROM interview_rounds
GROUP BY round_name
ORDER BY pass_percentage DESC;





-- STEP 11: OVERALL PLACEMENT SUMMARY USING CTE

WITH placement_summary AS (
    SELECT
        s.student_id,
        s.student_name,
        s.department,
        s.cgpa,
        po.offered_ctc_lpa
    FROM students s
    LEFT JOIN applications a
        ON s.student_id = a.student_id
    LEFT JOIN placement_offers po
        ON a.application_id = po.application_id
        AND po.offer_status = 'Accepted'
)
SELECT
    department,
    COUNT(DISTINCT student_id) AS total_students,
    COUNT(DISTINCT CASE
        WHEN offered_ctc_lpa IS NOT NULL
        THEN student_id
    END) AS students_placed,
    ROUND(AVG(offered_ctc_lpa), 2) AS average_package_lpa,
    MAX(offered_ctc_lpa) AS highest_package_lpa
FROM placement_summary
GROUP BY department
ORDER BY students_placed DESC;



-- STEP 12: TOP 3 PLACEMENT OFFERS

SELECT
    s.student_name,
    c.company_name,
    j.role_title,
    po.offered_ctc_lpa
FROM placement_offers po
JOIN applications a
    ON po.application_id = a.application_id
JOIN students s
    ON a.student_id = s.student_id
JOIN job_roles j
    ON a.role_id = j.role_id
JOIN companies c
    ON j.company_id = c.company_id
WHERE po.offer_status = 'Accepted'
ORDER BY po.offered_ctc_lpa DESC
LIMIT 3;



SHOW TABLES;

SELECT 'Students' AS entity, COUNT(*) AS total FROM students
UNION ALL
SELECT 'Companies', COUNT(*) FROM companies
UNION ALL
SELECT 'Job Roles', COUNT(*) FROM job_roles
UNION ALL
SELECT 'Applications', COUNT(*) FROM applications
UNION ALL
SELECT 'Offers', COUNT(*) FROM placement_offers;

