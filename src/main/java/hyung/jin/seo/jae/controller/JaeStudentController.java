package hyung.jin.seo.jae.controller;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import hyung.jin.seo.jae.model.Student;
import hyung.jin.seo.jae.repository.StudentRepository;
import hyung.jin.seo.jae.service.StudentService;

import java.util.List;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;


@RestController
public class JaeStudentController {

	@Autowired
	private StudentService studentService;
	
	private static final Logger LOG = LoggerFactory.getLogger(JaeStudentController.class);
	
	@GetMapping("/students")
	List<Student> allStudents() {
        List<Student> students = studentService.allStudents();
        return students;
	}
	
    @GetMapping("/student/{id}")
	Student getStudent(@PathVariable Long id) {
		Student std = studentService.getStudent(id);
        return std;
	}
	
    @PostMapping("/student")
	void addStudent(@RequestBody Student std) {
        studentService.addStudent(std);
	}
    
    @GetMapping("/count")
	long checkCount() {
        long count = studentService.checkCount();
        return count;
	}
    
    
    @PutMapping("/student/{id}")
	Student updateStudent(@RequestBody Student newStudent, @PathVariable Long id) {
    	Student updated = studentService.updateStudent(newStudent, id);
    	return updated;
    }
    
    @PutMapping("/student/discharge/{id}")
	void dischargeStudent(@PathVariable Long id) {
    	studentService.dischargeStudent(id);
    }
    
    @DeleteMapping("/student/{id}")
	void deleteStudent(@PathVariable Long id) {
		studentService.deleteStudent(id);
	}
    
    
}
