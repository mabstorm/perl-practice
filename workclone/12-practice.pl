#!/usr/bin/perl

# By single SQL statement, get the name of instructor, the e-mail address of instructor, the name of training course and schedule which student’s email-address is “csam@icm.co.jp” from the database.
#
# I have assumed that "schedule" here means "schedule date" since "schedule" is not a field.

use 5.8.9;
use strict;
use DBI;
use warnings;
use feature qw(say);

my $student_email = 'csam@icm.co.jp';
my $db = DBI->connect("dbi:mysql:training_db:localhost", "root", "",
{AutoCommit=>0} );
my $dbh = $db->prepare( <<"SQL");
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
   and student.e_mail = ?
   and schedule.schedule_id = attendance.schedule_id
   and instructor.instructor_id = schedule.instructor_id
   and course.course_id = schedule.course_id
SQL
# if requiring this student to attend this lecture, add this line
#   and attendance.attend_status = 'YES'
$dbh->bind_param(1, $student_email);
$dbh->execute();

my $results = $dbh->fetchall_arrayref();
$dbh->finish();
$db->disconnect();

# print results
foreach my $result (@$results) {
  my ($schedule_date, $instructor_last_name, $instructor_first_name,
      $instructor_e_mail, $course_title) = @$result;
  say "schedule date: $schedule_date\tinstructor: $instructor_last_name, $instructor_first_name\t$instructor_e_mail\tcourse: $course_title";

}
 



