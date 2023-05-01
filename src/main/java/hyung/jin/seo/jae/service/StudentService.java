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
	
	// bring student list base on the condition
	List<Student> listStudents(String state, String branch, String grade, String year, String active);
	
	// search student list base on keyword where id, firstName or lastName
	List<Student> searchStudents(String keyword);
		
	Student getStudent(Long id);
	
    Student addStudent(Student std);
    
 	long checkCount();
    
	Student updateStudent(Student newStudent, Long id);

	void deactivateStudent(Long id);
	
	void activateStudent(Long id);
	
	void deleteStudent(Long id);
}
