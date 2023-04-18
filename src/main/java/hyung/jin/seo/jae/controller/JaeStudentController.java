package hyung.jin.seo.jae.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hyung.jin.seo.jae.model.Elearning;
import hyung.jin.seo.jae.model.ElearningDTO;
import hyung.jin.seo.jae.model.Student;
import hyung.jin.seo.jae.model.StudentDTO;
import hyung.jin.seo.jae.service.ElearningService;
import hyung.jin.seo.jae.service.StudentService;

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
	
	// update existing student
	@PutMapping("/update")
	@ResponseBody
	public StudentDTO updateStudent(@RequestBody StudentDTO formData) {
		Student std = formData.convertToStudent();
		
		if((std.getElearnings() != null) && (std.getElearnings().size() > 0)) {
			// 1. check if any related courses come
			Set<ElearningDTO> crss = formData.getElearnings();
			Set<Long> cidList = new HashSet<Long>(); // extract Course Id
			for(ElearningDTO crsDto : crss) {
				cidList.add(Long.parseLong(crsDto.getId()));
			}
			long[] courseId = cidList.stream().mapToLong(Long::longValue).toArray();
			// 2. get Course in Student
			Set courses = std.getElearnings();
			// 3. clear existing course
			courses.clear();
			for(long cid : courseId) {
				// 4. get course info
				Elearning crs = elearningService.getElearning(cid);
				// 6. add Student to Course
				crs.getStudents().add(std);
				// 5. add Course to Student
				courses.add(crs);
			}
		}
		// 7. update Student
		std = studentService.updateStudent(std, std.getId());
		// 8. convert Student to StudentDTO
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
