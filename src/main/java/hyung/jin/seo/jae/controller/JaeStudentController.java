package hyung.jin.seo.jae.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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

import hyung.jin.seo.jae.dto.BookDTO;
import hyung.jin.seo.jae.dto.EnrolmentDTO;
import hyung.jin.seo.jae.dto.InvoiceDTO;
import hyung.jin.seo.jae.dto.StudentDTO;
import hyung.jin.seo.jae.model.Book;
import hyung.jin.seo.jae.model.Clazz;
import hyung.jin.seo.jae.model.Elearning;
import hyung.jin.seo.jae.model.Enrolment;
import hyung.jin.seo.jae.model.Invoice;
import hyung.jin.seo.jae.model.Student;
import hyung.jin.seo.jae.service.BookService;
import hyung.jin.seo.jae.service.ClazzService;
import hyung.jin.seo.jae.service.ElearningService;
import hyung.jin.seo.jae.service.EnrolmentService;
import hyung.jin.seo.jae.service.InvoiceService;
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

	@Autowired
	private InvoiceService invoiceService;

	@Autowired
	private BookService bookService;
	
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
		List<StudentDTO> dtos = studentService.listStudents(state, branch, grade, year, active);
		model.addAttribute(JaeConstants.STUDENT_LIST, dtos);
		return "studentListPage";
	}

	// associate elearnings with student
	@PostMapping("/associateElearning/{id}")
	@ResponseBody
	public ResponseEntity<String> associateElearning(@PathVariable Long id, @RequestBody Long[] elearningIds) {
		// 1. get student
		Student std = studentService.getStudent(id);
		// 2. empty elearning list
		Set<Elearning> elearningSet = std.getElearnings();
		elearningSet.clear();
		// 3. associate elearnings
		for(Long elearningId : elearningIds) {
			Elearning elearning = elearningService.getElearning(elearningId);
			elearningSet.add(elearning);
		}
		// 4. update student
		studentService.updateStudent(std, id);
		// 5. return success
		return ResponseEntity.ok("eLearning Success");
	}

	// @PostMapping("/associateClazz/{id}")
	// @ResponseBody
	// public ResponseEntity<String> associateClazz(@PathVariable Long id, @RequestBody EnrolmentDTO[] formData) {
	// 	// 1. get student
	// 	Student std = studentService.getStudent(id);
	// 	// 2. get enrolmentIds by studentId
	// 	List<Long> enrolmentIds = enrolmentService.findEnrolmentIdByStudentId(id);
	// 	// 3. create or update Enrolment
	// 	for(EnrolmentDTO data : formData) {
	// 		try{
	// 			// New Enrolment if no id comes in
	// 			if(data.getId()==null) {
	// 			// 4-A. associate clazz with student
	// 			Clazz clazz = clazzService.getClazz(Long.parseLong(data.getClazzId()));
	// 			// 5-A. create Enrolment
	// 			Enrolment enrolment = new Enrolment();
	// 			// 6-A. associate enrolment with clazz and student
	// 			enrolment.setClazz(clazz);
	// 			enrolment.setStudent(std);
	// 			enrolment.setStartWeek(data.getStartWeek());
	// 			enrolment.setEndWeek(data.getEndWeek());
	// 			// 7-A. save enrolment
	// 			enrolmentService.addEnrolment(enrolment);
	// 			}else {	// Update Enrolment if id comes in
	// 				// 4-B. get Enrolment
	// 				Enrolment enrolment = data.convertToEnrolment();
	// 				// 5-B. update Enrolment
	// 				enrolment = enrolmentService.updateEnrolment(enrolment, enrolment.getId());
	// 				// 6-B remove enrolmentId from enrolmentIds
	// 				enrolmentIds.remove(enrolment.getId());
	// 			}
	// 		}catch(NoSuchElementException e){
	// 			String message = "Error registering Course: " + e.getMessage();
	// 			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(message);
	// 		}				
	// 	}
	// 	// 7. archive enrolments not in formData
	// 	for(Long enrolmentId : enrolmentIds) {
	// 		enrolmentService.archiveEnrolment(enrolmentId);
	// 	}
	// 	// 8. trigger Invoice
	// 	triggerInvoice(id);
	// 	// 9. return success
	// 	return ResponseEntity.ok("Clazz Success");
	// }

	@PostMapping("/associateClazz/{id}")
	@ResponseBody
	public List<EnrolmentDTO> associateClazz(@PathVariable Long id, @RequestBody EnrolmentDTO[] formData) {
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
				String message = "Error registering Course: " + e.getMessage();
				return null;
			}				
		}
		// 7. archive enrolments not in formData
		for(Long enrolmentId : enrolmentIds) {
			enrolmentService.archiveEnrolment(enrolmentId);
		}
		// 8. trigger Invoice
		List<EnrolmentDTO> dtos = triggerInvoice(id);
		// 9. return success
		return dtos;
	}

	@PostMapping("/associateBook/{id}")
	@ResponseBody
	public List<BookDTO> associateBook(@PathVariable Long id, @RequestBody BookDTO[] formData) {
		// 1. get Invoice
		// Student std = studentService.getStudent(id);
		// 2. get enrolmentIds by studentId
		// List<Long> enrolmentIds = enrolmentService.findEnrolmentIdByStudentId(id);
		// 3. create or update Enrolment
		for(BookDTO data : formData) {
			System.out.println(data);
		}
			// try{
		// 		// 4. get Book
		// 		BookDTO book = bookService.getBook(Long.parseLong(data.getId()));
		// 		// 5-A. create Enrolment
		// 		Enrolment enrolment = new Enrolment();
		// 		// 6-A. associate enrolment with clazz and student
		// 		enrolment.setClazz(clazz);
		// 		enrolment.setStudent(std);
		// 		enrolment.setStartWeek(data.getStartWeek());
		// 		enrolment.setEndWeek(data.getEndWeek());
		// 		// 7-A. save enrolment
		// 		enrolmentService.addEnrolment(enrolment);
		// 		}else {	// Update Enrolment if id comes in
		// 			// 4-B. get Enrolment
		// 			Enrolment enrolment = data.convertToEnrolment();
		// 			// 5-B. update Enrolment
		// 			enrolment = enrolmentService.updateEnrolment(enrolment, enrolment.getId());
		// 			// 6-B remove enrolmentId from enrolmentIds
		// 			enrolmentIds.remove(enrolment.getId());
		// 		}
		// 	}catch(NoSuchElementException e){
		// 		String message = "Error associating Book: " + e.getMessage();
		// 		return null;
		// 	}				
		// }
		// // 7. archive enrolments not in formData
		// for(Long enrolmentId : enrolmentIds) {
		// 	enrolmentService.archiveEnrolment(enrolmentId);
		// }
		// // 8. trigger Invoice
		// List<EnrolmentDTO> dtos = triggerInvoice(id);
		// // 9. return success
		// return dtos;
		return null;
	}

	// as soon as Enrolment created or updated, it will trigger invoice
	private List<EnrolmentDTO> triggerInvoice(Long studentId){
		// 1. get latest Enrolment
		List<EnrolmentDTO> dtos = enrolmentService.findEnrolmentByStudent(studentId);
		
		// 2. create Invoice
		InvoiceDTO invoiceDTO = checkInvoice(studentId, dtos);

		// 3. assign invoice id to enrolment
		for(EnrolmentDTO data : dtos){
			data.setInvoiceId(invoiceDTO.getId());
			data.setAmount(invoiceDTO.getAmount());
		}
		return dtos;
	}


	// copy from InvoiceController
	public InvoiceDTO checkInvoice(Long studentId, List<EnrolmentDTO> formData){

		Long invoId = invoiceService.getInvoiceIdByStudentId(studentId);
		///////////////////////////////////////////////////////
		// if no data comes, it means no enrolment in invoice
		///////////////////////////////////////////////////////
		if((formData==null) || (formData.size()==0)) {
			// 1. get Enrolment by invoice Id
			// for(Long invoId : invoiceIds){
				if(invoId!=null){
					// 2. get enrolment Id by invoice Id
					List<Long> enrolmentIds = enrolmentService.findEnrolmentIdByInvoiceId(invoId);
					for(Long data : enrolmentIds) {
						// 3. archive Enrolment
						enrolmentService.archiveEnrolment(data);
					}
				}
			// }
			return null;
		}

		// 1. check whether Enrolment is already invoiced
		double total = 0;
		double credit = 0;
		double discount = 0;
		boolean alreadyInvoiced = false;
		long invoiceId = 0;
		// any null included, it should re-issue invoice
		alreadyInvoiced = (invoId==null) ? false : true;
		if(alreadyInvoiced){ // if already invoiced, get first invoice id
			// for(Long invoId : invoiceIds){
			// 	if(invoId!=null){
			 		invoiceId = invoId;
			// 		break;
			// 	}
			// }
			// 2. find Invoice if Enrolment is invoiced
			Invoice invoice = invoiceService.findInvoiceById(invoiceId);

			// update Invoice in case of any change from client

			for(EnrolmentDTO data : formData) {
				// 4. get Enrolment
				Enrolment enrolment = enrolmentService.getEnrolment(Long.parseLong(data.getId()));
				// 5. assign start-week, end-week, amount, credit, discount
				enrolment.setStartWeek(data.getStartWeek());
				enrolment.setEndWeek(data.getEndWeek());
				double cred = data.getCredit();
				// enrolment.setCredit(cred);
				double disc = data.getDiscount();
				// enrolment.setDiscount(disc);
				double amount = data.getAmount();
				// enrolment.setAmount(amount);
				// 6. sum total amount
				credit += cred;
				discount += disc;
				total += amount;
				// 7. add Enrolments to Invoice
				invoice.addEnrolment(enrolment);
			}
			// 8. update total
			invoice.setCredit(credit);
			invoice.setDiscount(discount);
			invoice.setAmount(total);
			// 9. update Invoice
			InvoiceDTO dto = invoiceService.updateInvoice(invoice, invoiceId);
			// return dto
			return dto;
		}else{

			// 3. create new invoice when no Invoice is found
			Invoice invoice = new Invoice();
			for(EnrolmentDTO data : formData) {
				// 4. get Enrolment
				Enrolment enrolment = enrolmentService.getEnrolment(Long.parseLong(data.getId()));
				// 5. assign start-week, end-week, amount, credit, discount
				enrolment.setStartWeek(data.getStartWeek());
				enrolment.setEndWeek(data.getEndWeek());
				double cred = data.getCredit();
				// enrolment.setCredit(cred);
				double disc = data.getDiscount();
				// enrolment.setDiscount(disc);
				double amount = (data.getAmount()==0) ? data.getPrice() * (data.getEndWeek() - data.getStartWeek() + 1) : data.getAmount();
				//double amount = data.getAmount();
				// enrolment.setAmount(amount);
				// 6. sum total amount
				credit += cred;
				discount += disc;
				total += amount;
				// 7. add Enrolments to Invoice
				invoice.addEnrolment(enrolment);
			}
			// 8. update total
			invoice.setCredit(credit);
			invoice.setDiscount(discount);
			invoice.setAmount(total);
			// 9. create Invoice
			InvoiceDTO dto = invoiceService.addInvoice(invoice);
			// 10. return flag;
			return dto;
		}
	}

}
