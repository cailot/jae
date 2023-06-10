package hyung.jin.seo.jae.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class JaeController {


	@GetMapping("/admin")
	public String adminJob(HttpSession session) {
		return "adminPage";
	}

	@GetMapping("/studentList")
	public String studentList(HttpSession session) {
		return "studentListPage";
	}

	@GetMapping("/courseList")
	public String courseList(HttpSession session) {
		return "courseListPage";
	}
	
	@GetMapping("/classList")
	public String classList(HttpSession session) {
		return "classListPage";
	}

	@GetMapping("/teacher")
	public String setting(HttpSession session) {
		return "teacherPage";
	}
	
}
