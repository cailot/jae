package hyung.jin.seo.jae.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import hyung.jin.seo.jae.dto.BookDTO;
import hyung.jin.seo.jae.dto.ClazzDTO;
import hyung.jin.seo.jae.dto.EnrolmentDTO;
import hyung.jin.seo.jae.dto.OutstandingDTO;
import hyung.jin.seo.jae.model.Book;
import hyung.jin.seo.jae.model.Clazz;
import hyung.jin.seo.jae.model.Enrolment;
import hyung.jin.seo.jae.model.Student;
import hyung.jin.seo.jae.service.BookService;
import hyung.jin.seo.jae.service.ClazzService;
import hyung.jin.seo.jae.service.EnrolmentService;
import hyung.jin.seo.jae.service.OutstandingService;
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

	@Autowired
	private OutstandingService outstandingService;

	@Autowired
	private BookService bookService;

	// search enrolment by student Id and return mixed list of books, enrolments, outstandings
	@GetMapping("/search/student/{id}")
	@ResponseBody
	public List searchEnrolmentByStudent(@PathVariable Long id) {
		List dtos = new ArrayList();
		List<String> invoiceIds = new ArrayList();
		// 1. get enrolments
		List<EnrolmentDTO> enrols = enrolmentService.findEnrolmentByStudent(id);
		// 2. get invoice id and add to list dtos
		for(EnrolmentDTO enrol : enrols){
			invoiceIds.add(enrol.getInvoiceId());
		}
		// 3. when returns, dtos keep order of books, enrolments, outstandings
		// 3-A. get books by invoice id and add to list dtos
		for(String invoiceId : invoiceIds){
			List<BookDTO> books = bookService.findBookByInvoiceId(Long.parseLong(invoiceId));
			for(BookDTO book : books){
				dtos.add(book);
			}
			// for(Book book : books){
			// 	BookDTO dto = new BookDTO(book);
			// 	dtos.add(dto);
			// }
		}
		// 3-B. add enrolments to list dtos
		for(EnrolmentDTO enrol : enrols){
			dtos.add(enrol);
		}
		// 3-C. add outstandings to list dtos
		for(String invoiceId : invoiceIds){
			List<OutstandingDTO> stands = outstandingService.getOutstandingtByInvoiceId(Long.parseLong(invoiceId));
			for(OutstandingDTO stand : stands){
				dtos.add(stand);
			}
		}
		// 4. return dtos mixed by enrolments and outstandings
		return dtos;
	}

	// count records number in database
	@GetMapping("/count")
	@ResponseBody
	public long count() {
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
