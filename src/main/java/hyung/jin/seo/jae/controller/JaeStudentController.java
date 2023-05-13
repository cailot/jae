package hyung.jin.seo.jae.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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

	private static final Logger LOG = LoggerFactory.getLogger(JaeStudentController.class);

	@Autowired
	private StudentService studentService;
	
	@Autowired
	private ElearningService elearningService;
	

	// register new student
	@PostMapping("/register")
	@ResponseBody
	public StudentDTO registerStudent(@RequestBody StudentDTO formData) {
		// 1. create Student without elearning
		Student std = formData.convertToOnlyStudent();
		// // 2. get elearning
		// Set<ElearningDTO> elearnings = formData.getElearnings();
		// for(ElearningDTO elearningDto : elearnings){
		// 	Elearning elearn = elearningService.getElearning(Long.parseLong(elearningDto.getId()));
		// 	// 3. associate elearning to Student
		// 	std.getElearnings().add(elearn);
		// }
		// 4. save Student
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
			try {
				// convert date format to dd/MM/yyyy
				dto.setRegisterDate(JaeUtils.convertToddMMyyyyFormat(dto.getRegisterDate()));
				dto.setEndDate(JaeUtils.convertToddMMyyyyFormat(dto.getEndDate()));
			} catch (ParseException e) {
				e.printStackTrace();
			}
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
		
		// if((std.getElearnings() != null) && (std.getElearnings().size() > 0)) {
		// 	// 1. check if any related courses come
		// 	Set<ElearningDTO> crss = formData.getElearnings();
		// 	Set<Long> cidList = new HashSet<Long>(); // extract Course Id
		// 	for(ElearningDTO crsDto : crss) {
		// 		cidList.add(Long.parseLong(crsDto.getId()));
		// 	}
		// 	long[] courseId = cidList.stream().mapToLong(Long::longValue).toArray();
		// 	// 2. get Course in Student
		// 	Set<Elearning> courses = std.getElearnings();
		// 	// 3. clear existing course
		// 	courses.clear();
		// 	for(long cid : courseId) {
		// 		// 4. get course info
		// 		Elearning crs = elearningService.getElearning(cid);
		// 		// 5. add Course to Student
		// 		courses.add(crs);
		// 	}
		// }
		// 7. update Student
		std = studentService.updateStudent(std, std.getId());
		// 8. convert Student to StudentDTO
		StudentDTO dto = new StudentDTO(std);
		return dto;
	}
	
	
	// update existing student
	@PutMapping("/updateOnlyStudent")
	@ResponseBody
	public StudentDTO updateOnlyStudent(@RequestBody StudentDTO formData) {
		Student std = formData.convertToStudent();
		// update Student
		std = studentService.updateStudent(std, std.getId());
		// convert Student to StudentDTO
		StudentDTO dto = new StudentDTO(std);
		return dto;
	}
	
	// de-activate student by Id
	@PutMapping("/inactivate/{id}")
	@ResponseBody
	public void inactivateStudent(@PathVariable Long id) {
		studentService.deactivateStudent(id);
	}
	

	// de-activate student by Id
	@PutMapping("/activate/{id}")
	@ResponseBody
	public void activateStudent(@PathVariable Long id) {
		studentService.activateStudent(id);
	}

	// search student list with state, branch, grade, start date or active
	@GetMapping("/list")
	public String listStudents(@RequestParam(value="listState", required=false) String state, @RequestParam(value="listBranch", required=false) String branch, @RequestParam(value="listGrade", required=false) String grade, @RequestParam(value="listYear", required=false) String year, @RequestParam(value="listActive", required=false) String active, Model model) {
        System.out.println(state+"\t"+branch+"\t"+grade+"\t"+year+"\t"+active+"\t");
		List<Student> students = studentService.listStudents(state, branch, grade, year, active);
		List<StudentDTO> dtos = new ArrayList<StudentDTO>();
		for (Student std : students) {
			StudentDTO dto = new StudentDTO(std);
			try {
				// convert date format to dd/MM/yyyy
				String startDate = JaeUtils.convertToddMMyyyyFormat(dto.getRegisterDate());
				int startWeek = 10;//JaeUtils.academicWeeks(startDate);
				dto.setRegisterDate(startDate+"|"+startWeek);
				// dto.setEnrolmentDate(JaeUtils.convertToddMMyyyyFormat(dto.getEnrolmentDate()));
				dto.setEndDate(JaeUtils.convertToddMMyyyyFormat(dto.getEndDate()));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			dtos.add(dto);
		}
		model.addAttribute(JaeConstants.STUDENT_LIST, dtos);
		return "listPage";
	}
}
