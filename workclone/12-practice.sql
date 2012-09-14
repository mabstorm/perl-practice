select 
    schedule.schedule_date,
    instructor.last_name as instructor_last_name,
    instructor.first_name as instructor_first_name,
    instructor.e_mail as instructor_e_mail,
    course.course_title
from
    student,
    attendance,
    schedule,
    instructor,
    course
where
    attendance.student_id = student.student_id
 and student.e_mail = 'csam@icm.co.jp'
 and schedule.schedule_id = attendance.schedule_id
 and instructor.instructor_id = schedule.instructor_id
 and course.course_id = schedule.course_id;