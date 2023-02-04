package hyung.jin.seo.jae.controller;

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
import java.util.List;
import java.util.ArrayList;


@RestController
public class JaeStudentController {

	
	@Autowired
	private StudentRepository studentRepository;
	
	
	private static final Logger LOG = LoggerFactory.getLogger(JaeStudentController.class);
	
	@GetMapping("/students")
	List<Student> allStudents() {
        List<Student> students = studentRepository.findAll();
       
//        students.forEach((student) -> {
//            System.out.println(student);
//        });
       
        return students;
	}
	
    @GetMapping("/student/{id}")
	Student getStudent(@PathVariable Long id) {
		Student std = studentRepository.findById(id).get();
        //System.out.println(std);
        return std;
	}
	
    @PostMapping("/student")
	void addStudent(@RequestBody Student std) {
        Student saved = studentRepository.save(std);
        //System.out.println(saved);
	}
    
    @GetMapping("/count")
	long checkCount() {
        long count = studentRepository.count();
        return count;
	}
    
    
    @PutMapping("/student/{id}")
	void updateStudent(@RequestBody Student newStudent, @PathVariable Long id) {
		// search by getId
        Student existing = studentRepository.findById(id).get();
        // Update info
        existing.setFirstName(newStudent.getFirstName());
        // update the existing record
        Student updated = studentRepository.save(existing);
        //System.out.println(updated);
     }
    
    @DeleteMapping("/student/{id}")
	void deleteStudent(@PathVariable Long id) {
        try{
		    studentRepository.deleteById(id);
        }catch(org.springframework.dao.EmptyResultDataAccessException e){
            System.out.println("Nothing to delete");
        }
	}
    
    
}
