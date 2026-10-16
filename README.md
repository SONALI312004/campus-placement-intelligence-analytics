# Campus Placement Intelligence & Analytics System

## Project Overview
A MySQL-based database project designed to manage campus recruitment activities and analyze placement outcomes using SQL.

## Technologies Used
- MySQL
- SQL
- DBMS
- Relational Database Design
- ER Modeling

## Database Tables
The project contains nine related tables:
1. Students
2. Companies
3. Job Roles
4. Skills
5. Student Skills
6. Role Skills
7. Applications
8. Interview Rounds
9. Placement Offers

## Key Features
- Student eligibility checking based on CGPA, active backlogs, and academic percentages
- Technical skill matching between students and job roles
- Company-wise selection rate analysis
- Average and highest package analysis
- In-demand technical skill analysis
- Interview-round pass rate analysis
- Package rankings using window functions
- Department-wise placement summaries using CTEs

## SQL Concepts Demonstrated
- Primary and foreign keys
- Constraints and relational integrity
- INNER JOIN, LEFT JOIN, and CROSS JOIN
- CASE expressions
- Aggregate functions and GROUP BY
- Subqueries
- Common Table Expressions (CTEs)
- Window functions: RANK() and DENSE_RANK()

## How to Run
1. Open `campus_placement.sql` in a MySQL-compatible SQL editor.
2. Execute the table creation statements.
3. Execute the sample data insertion statements.
4. Run the analytical queries to view placement insights.

## Dataset
This project uses illustrative sample data for demonstration. It does not represent actual student records or verified company placement statistics.

## Future Enhancements
- Integrate a Power BI dashboard.
- Add more realistic placement records.
- Analyze placement trends across multiple graduating batches.
- Introduce weighted skill-matching scores.
