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
	
	@GetMapping("/list")
	public String list(HttpSession session) {
		return "listPage";
	}

	@GetMapping("/teacher")
	public String setting(HttpSession session) {
		return "teacherPage";
	}
	
}
