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
import java.util.List;
import java.util.ArrayList;


@RestController
public class JaeStudentController {

	//@Autowired
	//private AuxiliaryInformationService auxiliaryInformationService;
	
	private static final Logger LOG = LoggerFactory.getLogger(JaeStudentController.class);
	
	//private ObjectMapper mapper = new ObjectMapper();

    private List<Student> students = new ArrayList<Student>();
    
	@GetMapping("/students")
	List<Student> allStudents() {
        //List<Student> list = new ArrayList<Student>();
        // students.add(new Student(1, "Jin", "Seo"));
        // list.add(new Student(2, "Alex", "Kim"));
        // list.add(new Student(3, "Diniel", "Lee"));
        return students;
	}
	
    @GetMapping("/student/{id}")
	Student getStudent(@PathVariable Long id) {
		return new Student(id, "Andrew", "Bogards");
	}
	
    @PostMapping("/student")
	Student addStudent(@RequestBody Student std) {
		students.add(std);
        return std;
	}
    
    
    @PutMapping("/student/{id}")
	Student updateStudent(@RequestBody Student newStudent, @PathVariable Long id) {
		if(students!=null){
            for(Student st : students){
                if(st.getId()==id){
                    st.setFirstName(newStudent.getFirstName());
                    st.setLastName(newStudent.getLastName());
                    break;
                    //return newStudent;
                }
            }
            return newStudent;
        }else{
            return null;
        }
	}
    
    @DeleteMapping("/student/{id}")
	void deleteStudent(@PathVariable Long id) {
		if(students!=null){
           for(Student st : students){
               if(st.getId()==id){
                   students.remove(st);
                   break;
               }
           } 
        }
	}
    
    
}
