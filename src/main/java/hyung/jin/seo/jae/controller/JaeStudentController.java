package hyung.jin.seo.jae.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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

import hyung.jin.seo.jae.dto.EnrolmentDTO;
import hyung.jin.seo.jae.dto.StudentDTO;
import hyung.jin.seo.jae.model.Clazz;
import hyung.jin.seo.jae.model.Elearning;
import hyung.jin.seo.jae.model.Enrolment;
import hyung.jin.seo.jae.model.Student;
import hyung.jin.seo.jae.service.ClazzService;
import hyung.jin.seo.jae.service.ElearningService;
import hyung.jin.seo.jae.service.EnrolmentService;
import hyung.jin.seo.jae.service.StudentService;
import hyung.jin.seo.jae.utils.JaeConstants;

@Controller
@RequestMapping("student")
public class JaeStudentController {

	@Autowired
	private StudentService studentService;

	@Autowired
	private ElearningService elearningService;

	@Autowired
	private ClazzService clazzService;

	@Autowired
	private EnrolmentService enrolmentService;
	
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
		// 1. update Student
		std = studentService.updateStudent(std, std.getId());
		// 2. convert Student to StudentDTO
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
	public StudentDTO activateStudent(@PathVariable Long id) {
		Student std = studentService.activateStudent(id);
		StudentDTO dto = new StudentDTO(std);
		return dto;
	}

	// search student list with state, branch, grade, start date or active
	@GetMapping("/list")
	public String listStudents(@RequestParam(value="listState", required=false) String state, @RequestParam(value="listBranch", required=false) String branch, @RequestParam(value="listGrade", required=false) String grade, @RequestParam(value="listYear", required=false) String year, @RequestParam(value="listActive", required=false) String active, Model model) {
		List<Student> students = studentService.listStudents(state, branch, grade, year, active);
		List<StudentDTO> dtos = new ArrayList<StudentDTO>();
		for (Student std : students) {
			StudentDTO dto = new StudentDTO(std);
			int startWeek = 10;//JaeUtils.academicWeeks(startDate);
			dto.setRegisterDate(dto.getRegisterDate()+"|"+startWeek);
			dtos.add(dto);
		}
		model.addAttribute(JaeConstants.STUDENT_LIST, dtos);
		return "studentListPage";
	}

	// associate elearnings with student
	@PostMapping("/associateElearning/{id}")
	@ResponseBody
	public ResponseEntity<String> associateElearning(@PathVariable Long id, @RequestBody Long[] elearningIds) {
		// 1. get student
		Student std = studentService.getStudent(id);
		// 2. check whether elearnings are empty
		// if(elearningIds.length==0) {
		// 	// 3-1. simply return success
		// 	return ResponseEntity.ok("Nothing associated");
		// }else{
			// 3-2. empty elearning list
			Set<Elearning> elearningSet = std.getElearnings();
			elearningSet.clear();
			// 4. associate elearnings
			for(Long elearningId : elearningIds) {
				Elearning elearning = elearningService.getElearning(elearningId);
				// 5. associate elearning with student
				elearningSet.add(elearning);
			}
			// 6. update student
			studentService.updateStudent(std, id);
			// 7. return success
			return ResponseEntity.ok("eLearning Success");
		// }
	}

	@PostMapping("/associateClazz/{id}")
	@ResponseBody
	public ResponseEntity<String> associateClazz(@PathVariable Long id, @RequestBody EnrolmentDTO[] formData) {
		// 1. get student
		Student std = studentService.getStudent(id);
		// 2. get enrolmentIds by studentId
		List<Long> enrolmentIds = enrolmentService.findEnrolmentIdByStudentId(id);
		// 3. create or update Enrolment
		for(EnrolmentDTO data : formData) {
			try{
					// New Enrolment if no id comes in
					if(data.getId()==null) {
					// 4-A. associate clazz with student
					Clazz clazz = clazzService.getClazz(Long.parseLong(data.getClazzId()));
					// 5-A. create Enrolment
					Enrolment enrolment = new Enrolment();
					// 6-A. associate enrolment with clazz and student
					enrolment.setClazz(clazz);
					enrolment.setStudent(std);
					enrolment.setStartWeek(data.getStartWeek());
					enrolment.setEndWeek(data.getEndWeek());
					// 7-A. save enrolment
					enrolmentService.addEnrolment(enrolment);
				}else {	// Update Enrolment if id comes in
					// 4-B. get Enrolment
					Enrolment enrolment = data.convertToEnrolment();
					// 5-B. update Enrolment
					enrolment = enrolmentService.updateEnrolment(enrolment, enrolment.getId());
					// 6-B remove enrolmentId from enrolmentIds
					enrolmentIds.remove(enrolment.getId());
				}
			}catch(NoSuchElementException e){
				return ResponseEntity.ok("No such Clazz");
			}				
		}
		// 7. delete enrolments not in formData
		for(Long enrolmentId : enrolmentIds) {
			enrolmentService.deleteEnrolment(enrolmentId);
		}
		// 8. return success
		return ResponseEntity.ok("Enrolment Success");	
	}
}
