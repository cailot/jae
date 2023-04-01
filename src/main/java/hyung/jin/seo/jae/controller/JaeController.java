package hyung.jin.seo.jae.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import hyung.jin.seo.jae.model.Student;
import hyung.jin.seo.jae.model.StudentDTO;
import hyung.jin.seo.jae.service.StudentService;

@Controller
@RequestMapping("student")
public class JaeController {
	
	private static final Logger LOG = LoggerFactory.getLogger(JaeController.class);

	@Autowired
	private StudentService studentService;
	
	//private static Gson gson = new Gson();
	
	
	@GetMapping("/test")
	public String uploads(HttpSession session) {

//		Student std = studentService.getStudent(1L);
//		session.setAttribute("std", new StudentDTO(std));
		return "testPage";
	}
	
	// register new student
	@PostMapping("/register")
	@ResponseBody
	public StudentDTO registerStudent(@RequestBody StudentDTO formData) {
		Student std = formData.convertToStudent();
		std = studentService.addStudent(std);	       
		StudentDTO dto = new StudentDTO(std);
		return dto;
	}
	
	// search student with keyword - ID, firstName & lastName
	@GetMapping("/search")
	@ResponseBody
    List<StudentDTO> searchStudents(@RequestParam("keyword") String keyword) {
        System.out.println(keyword);
		List<Student> students = studentService.searchStudents(keyword);
		List<StudentDTO> dtos = new ArrayList<StudentDTO>();
		for(Student std : students) {
			dtos.add(new StudentDTO(std));
		}
        return dtos;
	}
}
