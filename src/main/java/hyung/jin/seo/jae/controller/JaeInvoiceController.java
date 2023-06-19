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
	@PostMapping("/create/{studentId}")
	@ResponseBody
	public InvoiceDTO createInvoice(@PathVariable("studentId") Long studentId, @RequestBody EnrolmentDTO[] formData) {
		// 0. if no data comes, simply return null
		if((formData==null) || (formData.length==0)) {
			return null;
		}
		// 1. check whether Enrolment is already invoiced
		double total = 0;
		boolean alreadyInvoiced = false;
		long invoiceId = 0;
		for(EnrolmentDTO data : formData) {
			// 2. get Enrolment
			Enrolment enrolment = enrolmentService.getEnrolment(Long.parseLong(data.getId()));
			// 3. check whether Enrolment is already invoiced
			alreadyInvoiced = (enrolment.getInvoice()!=null) ? true : false;
			if(alreadyInvoiced){
				invoiceId = enrolment.getInvoice().getId();
			}
		}
		// any null included, it should re-issue invoice
		List<Long> invoieIds = invoiceService.findInvoiceIdByStudentId(studentId);
		// 4. retrieve Invoice if Enrolment is invoiced
		if(alreadyInvoiced) {
			InvoiceDTO dto = invoiceService.getInvoice(invoiceId);
			return dto;
		}else{
			// 5. create new invoice when no Invoice is found
			Invoice invoice = new Invoice();
			for(EnrolmentDTO data : formData) {
				// 6. get Enrolment
				Enrolment enrolment = enrolmentService.getEnrolment(Long.parseLong(data.getId())); /// do i need to invoice same thing twice times ??

				// 7. assign start-week, end-week, amount, credit, discount
				enrolment.setStartWeek(data.getStartWeek());
				enrolment.setEndWeek(data.getEndWeek());
				enrolment.setCredit(data.getCredit());
				enrolment.setDiscount(data.getDiscount());
				double amount = data.getAmount();
				enrolment.setAmount(amount);
				// 8. sum total amount
				total += amount;
			
				// 9. add Enrolments to Invoice
				invoice.addEnrolment(enrolment);
			}
			// 10. update total
			invoice.setTotalAmount(total);
			
			// 11. create Invoice
			InvoiceDTO dto = invoiceService.addInvoice(invoice);
			// 12. return flag;
			return dto;

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
