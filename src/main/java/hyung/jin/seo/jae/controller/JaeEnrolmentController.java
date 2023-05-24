package hyung.jin.seo.jae.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import hyung.jin.seo.jae.dto.EnrolmentDTO;
import hyung.jin.seo.jae.model.Clazz;
import hyung.jin.seo.jae.model.Enrolment;
import hyung.jin.seo.jae.model.Student;
import hyung.jin.seo.jae.service.ClazzService;
import hyung.jin.seo.jae.service.EnrolmentService;
import hyung.jin.seo.jae.service.StudentService;

@Controller
@RequestMapping("enrolment")
public class JaeEnrolmentController {

	@Autowired
	private EnrolmentService enrolmentService;

	@Autowired
	private ClazzService clazzService;

	@Autowired
	private StudentService studentService;

	// search enrolment by student Id
	@GetMapping("/search/student/{id}")
	@ResponseBody
	List<EnrolmentDTO> searchEnrolmentByStudent(@PathVariable Long id) {
		List<EnrolmentDTO> dtos = enrolmentService.findEnrolmentByStudent(id);
		return dtos;
	}

	// search enrolment by clazz Id
	@GetMapping("/search/class/{id}")
	@ResponseBody
	List<EnrolmentDTO> searchEnrolmentByClazz(@PathVariable Long id) {
		List<EnrolmentDTO> dtos = enrolmentService.findEnrolmentByClazz(id);
		return dtos;
	}

	// search enrolment by clazz Id & student Id
	@GetMapping("/search/class/{classId}/student/{studentId}")
	@ResponseBody
	List<EnrolmentDTO> searchEnrolmentByClazzAndStudent(@PathVariable Long classId, @PathVariable Long studentId) {
		List<EnrolmentDTO> dtos = enrolmentService.findEnrolmentByClazzAndStudent(classId, studentId);
		return dtos;
	}

	// enrole with student id
	@PostMapping("/makeEnrolment/{id}")
	@ResponseBody
	public ResponseEntity<String> makeEnrolment(@PathVariable Long id, @RequestBody Long[] clazzIds) {
		// 1. get student
		Student std = studentService.getStudent(id);
		// 2. add clazzes
		for(Long clazzId : clazzIds) {
			// 2-1. get clazz
			Clazz clazz = clazzService.getClazz(clazzId);
			// 2-2. create enrolment
			Enrolment enrolment = new Enrolment();
			enrolment.setClazz(clazz);
			enrolment.setStudent(std);
			// 2-3. save enrolment
			enrolmentService.addEnrolment(enrolment);
		}
		if(elearningIds.length==0) {
			// 3-1. simply return success
			return ResponseEntity.ok("Nothing associated");
		}else{
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
			return ResponseEntity.ok("Success");
		}
	}

	// count records number in database
	@GetMapping("/count")
	@ResponseBody
	long count() {
		long count = enrolmentService.checkCount();
		return count;
	}

	// bring all enrolments in database
	@GetMapping("/list")
	@ResponseBody
	public List<EnrolmentDTO> listEnrolments() {
 		List<EnrolmentDTO> dtos = enrolmentService.allEnrolments();
		return dtos;
	}
		
	// register new student
	@PostMapping("/register")
	@ResponseBody
	public EnrolmentDTO registerEnrolment(@RequestBody EnrolmentDTO formData) {
		System.out.println(formData);
		// 1. create bare Enrolment
		Enrolment enrolment = formData.convertToEnrolment();
		// 2. get Clazz
		Clazz clazz = clazzService.getClazz(Long.parseLong(formData.getClazzId()));
		// 3. get Student
		Student student = studentService.getStudent(Long.parseLong(formData.getStudentId()));
		// 4. assign Clazz & Student
		enrolment.setClazz(clazz);
		enrolment.setStudent(student);
		// 5. save Class
		EnrolmentDTO dto = enrolmentService.addEnrolment(enrolment);
		// 6. return dto;
		return dto;
	}


}
