package hyung.jin.seo.jae.controller;

import java.util.ArrayList;
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

import hyung.jin.seo.jae.dto.ClazzDTO;
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
	// @GetMapping("/search/class/{id}")
	// @ResponseBody
	// List<EnrolmentDTO> searchEnrolmentByClazz(@PathVariable Long id) {
	// 	List<EnrolmentDTO> dtos = enrolmentService.findEnrolmentByClazz(id);
	// 	return dtos;
	// }

	// search enrolment by clazz Id & student Id
	// @GetMapping("/search/class/{classId}/student/{studentId}")
	// @ResponseBody
	// List<EnrolmentDTO> searchEnrolmentByClazzAndStudent(@PathVariable Long classId, @PathVariable Long studentId) {
	// 	List<EnrolmentDTO> dtos = enrolmentService.findEnrolmentByClazzAndStudent(classId, studentId);
	// 	return dtos;
	// }


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

	// search clazz by student Id
	@GetMapping("/getClazz/student/{id}")
	@ResponseBody
	List<ClazzDTO> searchClazzByStudent(@PathVariable Long id) {
		List<Long> clazzIds = enrolmentService.findClazzIdByStudentId(id);
		List<ClazzDTO> dtos = new ArrayList<ClazzDTO>();
		for (Long clazzId : clazzIds) {
			Clazz clazz = clazzService.getClazz(clazzId);
			ClazzDTO dto = new ClazzDTO(clazz);
			dtos.add(dto);
		}
		return dtos;
	}

}
