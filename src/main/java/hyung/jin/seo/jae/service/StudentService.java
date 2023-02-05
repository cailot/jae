package hyung.jin.seo.jae.service;

import java.util.List;

import hyung.jin.seo.jae.model.Student;

public interface StudentService {

	List<Student> allStudents();
	
	public Student getStudent(Long id);
	
    void addStudent(Student std);
    
 	long checkCount();
    
	Student updateStudent(Student newStudent, Long id);

	void dischargeStudent(Long id);
	
	void deleteStudent(Long id);
}
