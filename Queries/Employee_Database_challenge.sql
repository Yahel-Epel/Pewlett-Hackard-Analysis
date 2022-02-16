SELECT e.emp_no,
    e.first_name,
	e.last_name,
    titles.title,
	titles.from_date,
    titles.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles 
ON (e.emp_no = titles.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date = ('9999-01-01')
ORDER BY emp_no, emp_no DESC;

SELECT * FROM unique_titles;

-- The number of employees by their most recent job title who are about to retire.
SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

SELECT * FROM retiring_titles;

--DROP TABLE retiring_titles;

SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
    de.to_date,
	titles.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles
ON (e.emp_no = titles.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, emp_no DESC;

SELECT * FROM mentorship_eligibilty;
--DROP TABLE mentorship_eligibilty;

SELECT COUNT(me.title), me.title
INTO retirement_ready 
FROM mentorship_eligibilty as me
GROUP BY me.title
ORDER BY COUNT(me.title) DESC;

SELECT * FROM retirement_ready;

SELECT * FROM departments;
SELECT * FROM dept_info;

SELECT COUNT(me.emp_no), d.dept_name
--INTO dept_mentors
FROM mentorship_eligibilty AS me
INNER JOIN dept_emp AS de
ON (de.emp_no = me.emp_no)
INNER JOIN departments AS d
ON (d.dept_no = de.dept_no)
GROUP BY d.dept_name 
ORDER BY COUNT(d.dept_name) DESC;

SELECT * FROM dept_mentors;

