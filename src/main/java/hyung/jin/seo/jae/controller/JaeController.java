package hyung.jin.seo.jae.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import hyung.jin.seo.jae.service.ElearningService;
import hyung.jin.seo.jae.service.StudentService;

@Controller
public class JaeController {

	private static final Logger LOG = LoggerFactory.getLogger(JaeController.class);

	@Autowired
	private StudentService studentService;

	@Autowired
	private ElearningService elearningService;

	@GetMapping("/test")
	public String student(HttpSession session) {
		return "testPage";
	}
	
	
	@GetMapping("/list")
	public String list(HttpSession session) {
		return "listPage";
	}

	@GetMapping("/setting")
	public String setting(HttpSession session) {
		return "settingPage";
	}
	
}
