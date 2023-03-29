package hyung.jin.seo.jae.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;

import hyung.jin.seo.jae.model.Student;
import hyung.jin.seo.jae.model.StudentDTO;
import hyung.jin.seo.jae.service.StudentService;

@Controller
public class JaeController {
	
	private static final Logger LOG = LoggerFactory.getLogger(JaeController.class);

	@Autowired
	private StudentService studentService;
	
	private static Gson gson = new Gson();
	
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String uploads(HttpSession session) {

		Student std = studentService.getStudent(1L);
		session.setAttribute("std", new StudentDTO(std));
		return "testPage";
	}
}
