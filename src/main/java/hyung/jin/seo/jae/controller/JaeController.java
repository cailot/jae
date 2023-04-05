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
@RequestMapping("student")
public class JaeController {

	private static final Logger LOG = LoggerFactory.getLogger(JaeController.class);

	@Autowired
	private StudentService studentService;

	// private static Gson gson = new Gson();

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
		List<Student> students = studentService.searchStudents(keyword);
		List<StudentDTO> dtos = new ArrayList<StudentDTO>();
		for (Student std : students) {
			StudentDTO dto = new StudentDTO(std);
			if (StringUtils.isNotBlank(dto.getMemo())) // replace escape character single quote
			{
				String newMemo = dto.getMemo().replaceAll("\'", "&#39;");
				dto.setMemo(newMemo);
			}
			dtos.add(dto);
		}
		return dtos;
	}

	// register new student
	@PutMapping("/update")
	@ResponseBody
	public StudentDTO updateStudent(@RequestBody StudentDTO formData) {
		Student std = formData.convertToStudent();
		std = studentService.updateStudent(std, std.getId());
		StudentDTO dto = new StudentDTO(std);
		return dto;
	}

	// de-activate student by Id
	@PutMapping("/inactivate/{id}")
	@ResponseBody
	public void inactivateStudent(@PathVariable Long id) {
		studentService.dischargeStudent(id);
	}
	
	
	// search student list with state, branch, grade, start date or active
	@GetMapping("/list")
	@ResponseBody
	List<Student> listStudents(@RequestParam("state") String state, @RequestParam("branch") String branch, @RequestParam("grade") String grade, @RequestParam("start") String start, @RequestParam("active") String active) {
        System.out.println(state+"\t"+branch+"\t"+grade+"\t"+start+"\t"+active+"\t");
		List<Student> students = studentService.listStudents(state, branch, grade, "", active);
        return students;
	}
}
