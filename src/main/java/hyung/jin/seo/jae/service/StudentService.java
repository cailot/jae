package hyung.jin.seo.jae.service;

import java.util.List;

import hyung.jin.seo.jae.model.Student;

public interface StudentService {

	// bring all students
	List<Student> allStudents();
	
	// bring active students
	List<Student> currentStudents();
	
	// bring inactive students
	List<Student> stoppedStudents();
	
	
	List<Student> listStudents(String state, String branch, String grade, String year, String active);
	
	Student getStudent(Long id);
	
    Student addStudent(Student std);
    
 	long checkCount();
    
	Student updateStudent(Student newStudent, Long id);

	void dischargeStudent(Long id);
	
	void deleteStudent(Long id);
}
