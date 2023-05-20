package hyung.jin.seo.jae.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hyung.jin.seo.jae.dto.ElearningDTO;
import hyung.jin.seo.jae.dto.StudentDTO;
import hyung.jin.seo.jae.model.Elearning;
import hyung.jin.seo.jae.model.Student;
import hyung.jin.seo.jae.service.ElearningService;
import hyung.jin.seo.jae.service.StudentService;
import hyung.jin.seo.jae.utils.JaeConstants;
import hyung.jin.seo.jae.utils.JaeUtils;

@Controller
@RequestMapping("student")
public class JaeStudentController {

	@Autowired
	private StudentService studentService;
	
	// register new student
	@PostMapping("/register")
	@ResponseBody
	public StudentDTO registerStudent(@RequestBody StudentDTO formData) {
		// 1. create Student without elearning
		Student std = formData.convertToOnlyStudent();
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
			dtos.add(dto);
		}
		return dtos;
	}
	
	// search student by ID
	@GetMapping("/get/{id}")
	@ResponseBody
	StudentDTO getStudents(@PathVariable Long id) {
		Student std = studentService.getStudent(id);
		if(std==null) return new StudentDTO(); // return empty if not found
		StudentDTO dto = new StudentDTO(std);
		return dto;
	}
	
	// update existing student
	@PutMapping("/update")
	@ResponseBody
	public StudentDTO updateStudent(@RequestBody StudentDTO formData) {
		Student std = formData.convertToStudent();
		// 7. update Student
		std = studentService.updateStudent(std, std.getId());
		// 8. convert Student to StudentDTO
		StudentDTO dto = new StudentDTO(std);
		return dto;
	}
	
	
	// // update existing student
	// @PutMapping("/updateOnlyStudent")
	// @ResponseBody
	// public StudentDTO updateOnlyStudent(@RequestBody StudentDTO formData) {
	// 	Student std = formData.convertToStudent();
	// 	// update Student
	// 	std = studentService.updateStudent(std, std.getId());
	// 	// convert Student to StudentDTO
	// 	StudentDTO dto = new StudentDTO(std);
	// 	return dto;
	// }
	
	// de-activate student by Id
	@PutMapping("/inactivate/{id}")
	@ResponseBody
	public void inactivateStudent(@PathVariable Long id) {
		studentService.deactivateStudent(id);
	}
	

	// de-activate student by Id
	@PutMapping("/activate/{id}")
	@ResponseBody
	public StudentDTO activateStudent(@PathVariable Long id) {
		Student std = studentService.activateStudent(id);
		StudentDTO dto = new StudentDTO(std);
		return dto;
	}

	// search student list with state, branch, grade, start date or active
	@GetMapping("/list")
	public String listStudents(@RequestParam(value="listState", required=false) String state, @RequestParam(value="listBranch", required=false) String branch, @RequestParam(value="listGrade", required=false) String grade, @RequestParam(value="listYear", required=false) String year, @RequestParam(value="listActive", required=false) String active, Model model, HttpServletRequest request, HttpSession session) {
        String queryString = request.getQueryString();
		System.out.println(queryString);
		//System.out.println(state+"\t"+branch+"\t"+grade+"\t"+year+"\t"+active);

		List<Student> students = studentService.listStudents(state, branch, grade, year, active);
		List<StudentDTO> dtos = new ArrayList<StudentDTO>();
		for (Student std : students) {
			StudentDTO dto = new StudentDTO(std);
			// try {
				// convert date format to dd/MM/yyyy
				// String startDate = JaeUtils.convertToddMMyyyyFormat(dto.getRegisterDate());
				int startWeek = 10;//JaeUtils.academicWeeks(startDate);
				dto.setRegisterDate(dto.getRegisterDate()+"|"+startWeek);
				// dto.setEnrolmentDate(JaeUtils.convertToddMMyyyyFormat(dto.getEnrolmentDate()));
				// dto.setEndDate(JaeUtils.convertToddMMyyyyFormat(dto.getEndDate()));
			// } catch (ParseException e) {
			// 	e.printStackTrace();
			// }
			dtos.add(dto);
		}
		model.addAttribute(JaeConstants.STUDENT_LIST, dtos);
		
		session.setAttribute("query", queryString);
		return "studentListPage";
	}




	// register new student
	@PostMapping("/list/register")
	@ResponseBody
	public StudentDTO registerStudentList(@RequestBody StudentDTO formData) {
		Student std = formData.convertToOnlyStudent();
		std = studentService.addStudent(std);
		return new StudentDTO(std);
	}

	// update existing student in student list page
	@PutMapping("/list/update")
	@ResponseBody
	public StudentDTO updateStudentList(@RequestBody StudentDTO formData) {
		Student std = formData.convertToStudent();		
		// 7. update Student
		std = studentService.updateStudent(std, std.getId());
		// 8. convert Student to StudentDTO
		StudentDTO dto = new StudentDTO(std);
		return dto;
	}
	
}
