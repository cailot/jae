package hyung.jin.seo.jae.controller;

import java.io.IOException;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import hyung.jin.seo.jae.model.Student;
import hyung.jin.seo.jae.model.StudentDTO;
import hyung.jin.seo.jae.service.StudentService;

@Controller
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
	
	@PostMapping("/register")
	@ResponseBody
	public StudentDTO registerStudent(@RequestBody String formData) {
		String detail = "[From Server] : " + formData;
		//System.out.println(detail);
		Student std = studentService.getStudent(1L);
		
//		StudentDTO dto = new StudentDTO();
//		dto.setId("1");
//		dto.setFirstName("Jin");
//		dto.setLastName("Seo");
//		dto.setAddress("38 Belmore Rd, Balwyn");
//		dto.setBranch("boxhill");
//		dto.setContactNo1("0433 195 038");
//		dto.setContactNo2("0433 195 056");
//		dto.setEmail("jinhyung.seo@gmail.com");
//		dto.setEnrolmentDate("11/03/2023");
//		dto.setGrade("s7");
//		dto.setMemo("This is long long memo\n And second row starts...\n3rd row...");
//		dto.setState("nt");
		
		StudentDTO dto = new StudentDTO(std);
		System.out.println("Before : " + detail + "\nAfter : " + dto);
		
		return dto;
	}
}
