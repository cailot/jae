package hyung.jin.seo.jae.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import hyung.jin.seo.jae.utils.JaeConstants;

@Controller
@RequestMapping("invoice")
public class JaeInvoiceController {

	@Autowired
	private InvoiceService invoiceService;

	@Autowired
	private EnrolmentService enrolmentService;

	@Autowired
	private PaymentService paymentService;

	// how to access receipt page by http://localhost:8080/invoice/my.
	// please create controller method for this.
	@GetMapping("/my")
	public String my() {
		return "receipt";
	}	


	
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

	
	// make payment and return updated invoice
	@PostMapping("/payment/{studentId}")
	@ResponseBody
	public List<EnrolmentDTO> makePayment(@PathVariable("studentId") Long studentId, @RequestBody PaymentDTO formData, HttpSession session) {
		

		List<EnrolmentDTO> dtos = new ArrayList<EnrolmentDTO>();
		List<Long> invoiceIds = invoiceService.getInvoiceIdByStudentId(studentId);
		double paidAmount = formData.getAmount();
		boolean fullPaid = false;
		for(Long invoiceId : invoiceIds){
			// 1. get Invoice
			Invoice invoice = invoiceService.findInvoiceById(invoiceId);
			// 2. make payment
			Payment payment = formData.convertToPayment();
			Payment paid = paymentService.addPayment(payment);
			// 3. update Invoice
			invoice.setPaidAmount(paidAmount + invoice.getPaidAmount());
			invoice.setPayment(paid);
			// 4. check whether full paid or not
			if(invoice.getTotalAmount() <= invoice.getPaidAmount()){
				fullPaid = true;
			}
			if(fullPaid){
				invoice.setPayCompleteDate(LocalDate.now());
			}
			// 5. save Invoice
			invoiceService.updateInvoice(invoice, invoiceId);
			// 6. bring to EnrolmentDTO
			List<EnrolmentDTO> enrols = enrolmentService.findEnrolmentByInvoice(invoiceId);
			for(EnrolmentDTO enrol : enrols){
				enrol.setInvoiceId(String.valueOf(invoiceId));
				// 7. add to dtos
				dtos.add(enrol);
			}	
		}

		// 8. set EnrolmentDTO objects into session for payment receipt
		session.setAttribute(JaeConstants.PAYMENTS, dtos);
		
		// 8. return
		return dtos;
	}

}
