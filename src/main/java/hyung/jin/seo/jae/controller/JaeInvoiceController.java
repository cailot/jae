package hyung.jin.seo.jae.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import hyung.jin.seo.jae.dto.ClazzDTO;
import hyung.jin.seo.jae.dto.CourseDTO;
import hyung.jin.seo.jae.dto.EnrolmentDTO;
import hyung.jin.seo.jae.dto.InvoiceDTO;
import hyung.jin.seo.jae.model.Clazz;
import hyung.jin.seo.jae.model.Course;
import hyung.jin.seo.jae.model.Enrolment;
import hyung.jin.seo.jae.model.Invoice;
import hyung.jin.seo.jae.model.Student;
import hyung.jin.seo.jae.service.ClazzService;
import hyung.jin.seo.jae.service.EnrolmentService;
import hyung.jin.seo.jae.service.InvoiceService;
import hyung.jin.seo.jae.service.StudentService;

@Controller
@RequestMapping("invoice")
public class JaeInvoiceController {

	@Autowired
	private InvoiceService invoiceService;

	@Autowired
	private EnrolmentService enrolmentService;


	// // search enrolment by student Id
	// @GetMapping("/search/student/{id}")
	// @ResponseBody
	// List<EnrolmentDTO> searchEnrolmentByStudent(@PathVariable Long id) {
	// 	List<EnrolmentDTO> dtos = enrolmentService.findEnrolmentByStudent(id);
	// 	return dtos;
	// }

	// // search enrolment by clazz Id
	// @GetMapping("/search/class/{id}")
	// @ResponseBody
	// List<EnrolmentDTO> searchEnrolmentByClazz(@PathVariable Long id) {
	// 	List<EnrolmentDTO> dtos = enrolmentService.findEnrolmentByClazz(id);
	// 	return dtos;
	// }

	// // search enrolment by clazz Id & student Id
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
		long count = invoiceService.checkCount();
		return count;
	}

	// bring all invoices in database
	@GetMapping("/list")
	@ResponseBody
	public List<InvoiceDTO> listInvoices() {
 		List<InvoiceDTO> dtos = invoiceService.allInvoices();
		return dtos;
	}
		
	// register new invoice
	@PostMapping("/create")
	@ResponseBody
	public ResponseEntity<String> createInvoice(@RequestBody InvoiceDTO[] formData) {
		try {
			if((formData==null) || (formData.length==0)) {
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("\"No Invoice data\"");
			}
			// 1. create bare Invoice
			Invoice invoice = new Invoice();
			double amount = 0;
			double credit = 0;
			double discount = 0;	
			for(InvoiceDTO data : formData) {
				amount += data.getAmount();
				credit += data.getCredit();
				discount += data.getDiscount();
				// 2. get Enrolment
				Enrolment enrolment = enrolmentService.getEnrolment(Long.parseLong(data.getEnrolmentId()));
				// 3. assign Enrolment
				invoice.addEnrolment(enrolment);
			}
			// 4. assign amount, credit, discount
			invoice.setAmount(amount);
			invoice.setCredit(credit);
			invoice.setDiscount(discount);
			// 5. add Invoice
			invoiceService.addInvoice(invoice);
			// 6. return flag;
			return ResponseEntity.ok("\"Invoice create success\"");
		} catch (Exception e) {
			String message = "Error creating Invoice: " + e.getMessage();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(message);
		}
	}


	



	// // search clazz by student Id
	// @GetMapping("/getClazz/student/{id}")
	// @ResponseBody
	// List<ClazzDTO> searchClazzByStudent(@PathVariable Long id) {
	// 	List<Long> clazzIds = enrolmentService.findClazzIdByStudentId(id);
	// 	List<ClazzDTO> dtos = new ArrayList<ClazzDTO>();
	// 	for (Long clazzId : clazzIds) {
	// 		Clazz clazz = clazzService.getClazz(clazzId);
	// 		ClazzDTO dto = new ClazzDTO(clazz);
	// 		dtos.add(dto);
	// 	}
	// 	return dtos;
	// }

}
