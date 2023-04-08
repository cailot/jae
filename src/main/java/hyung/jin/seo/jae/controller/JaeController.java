package hyung.jin.seo.jae.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import hyung.jin.seo.jae.model.Student;
import hyung.jin.seo.jae.model.StudentDTO;
import hyung.jin.seo.jae.service.StudentService;
import hyung.jin.seo.utils.JaeConstants;

@Controller
public class JaeController {

	private static final Logger LOG = LoggerFactory.getLogger(JaeController.class);

	@Autowired
	private StudentService studentService;

	@GetMapping("/test")
	public String student(HttpSession session) {
		return "testPage";
	}
	
	
	@GetMapping("/list")
	public String list(HttpSession session) {
		return "listPage";
	}


	
}
