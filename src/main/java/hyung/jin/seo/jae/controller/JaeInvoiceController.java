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
import hyung.jin.seo.jae.dto.InvoiceDTO;
import hyung.jin.seo.jae.dto.PaymentDTO;
import hyung.jin.seo.jae.model.Enrolment;
import hyung.jin.seo.jae.model.Invoice;
import hyung.jin.seo.jae.model.Payment;
import hyung.jin.seo.jae.service.EnrolmentService;
import hyung.jin.seo.jae.service.InvoiceService;
import hyung.jin.seo.jae.service.PaymentService;

@Controller
@RequestMapping("invoice")
public class JaeInvoiceController {

	@Autowired
	private InvoiceService invoiceService;

	@Autowired
	private EnrolmentService enrolmentService;

	@Autowired
	private PaymentService paymentService;


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
		
		List<Long> invoiceIds = invoiceService.getInvoiceIdByStudentId(studentId);
		
		///////////////////////////////////////////////////////
		// if no data comes, it means no enrolment in invoice
		///////////////////////////////////////////////////////
		if((formData==null) || (formData.length==0)) {
			// 1. get Enrolment by invoice Id
			for(Long invoId : invoiceIds){
				if(invoId!=null){
					// 2. get enrolment Id by invoice Id
					List<Long> enrolmentIds = enrolmentService.findEnrolmentIdByInvoiceId(invoId);
					for(Long data : enrolmentIds) {
						// 3. archive Enrolment
						enrolmentService.archiveEnrolment(data);
					}
				}
			}
			return null;
		}


		// 1. check whether Enrolment is already invoiced
		double total = 0;
		double credit = 0;
		double discount = 0;
		boolean alreadyInvoiced = false;
		long invoiceId = 0;
		// any null included, it should re-issue invoice
		alreadyInvoiced = invoiceIds.contains(null) ? false : true;
		if(alreadyInvoiced){ // if already invoiced, get first invoice id
			for(Long invoId : invoiceIds){
				if(invoId!=null){
					invoiceId = invoId;
					break;
				}
			}
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
			invoice.setTotalAmount(total);
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
			invoice.setTotalAmount(total);
			// 9. create Invoice
			InvoiceDTO dto = invoiceService.addInvoice(invoice);
			// 10. return flag;
			return dto;
		}
	}

	// make payment
	@PostMapping("/payment/{studentId}")
	@ResponseBody
	public ResponseEntity<String> makePayment(@PathVariable("studentId") Long studentId, @RequestBody PaymentDTO formData) {
		
		List<Long> invoiceIds = invoiceService.getInvoiceIdByStudentId(studentId);
		double paidAmount = formData.getAmount();
		
		for(Long invoiceId : invoiceIds){
			// 1. get Invoice
			Invoice invoice = invoiceService.findInvoiceById(invoiceId);
			// 2. make payment
			Payment payment = formData.convertToPayment();
			Payment paid = paymentService.addPayment(payment);
			// 3. update Invoice
			invoice.setPaidAmount(paidAmount);
			invoice.addPayment(paid);
			// 4. save Invoice
			invoiceService.updateInvoice(invoice, invoiceId);
		}


		return ResponseEntity.ok("\"Payment success\"");
	}

}
