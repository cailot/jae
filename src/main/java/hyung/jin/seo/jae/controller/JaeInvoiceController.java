package hyung.jin.seo.jae.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import hyung.jin.seo.jae.dto.EnrolmentDTO;
import hyung.jin.seo.jae.dto.InvoiceDTO;
import hyung.jin.seo.jae.dto.OutstandingDTO;
import hyung.jin.seo.jae.dto.PaymentDTO;
import hyung.jin.seo.jae.model.Enrolment;
import hyung.jin.seo.jae.model.Invoice;
import hyung.jin.seo.jae.model.Outstanding;
import hyung.jin.seo.jae.model.Payment;
import hyung.jin.seo.jae.service.CycleService;
import hyung.jin.seo.jae.service.EnrolmentService;
import hyung.jin.seo.jae.service.InvoiceService;
import hyung.jin.seo.jae.service.OutstandingService;
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

	@Autowired
	private OutstandingService outstandingService;

	@Autowired
	private CycleService cycleService;
	
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
		
		Long invoId = invoiceService.getInvoiceIdByStudentId(studentId);
		
		///////////////////////////////////////////////////////
		// if no data comes, it means no enrolment in invoice
		///////////////////////////////////////////////////////
		if((formData==null) || (formData.length==0)) {
			// 1. get Enrolment by invoice Id
			// for(Long invoId : invoId){
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
			// for(Long invoId : invoId){
				if(invoId!=null){
					invoiceId = invoId;
					// break;
				}
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

	
	// // make payment and return updated invoice
	// @PostMapping("/paymentFull/{studentId}")
	// @ResponseBody
	// public Object makeFullPayment(@PathVariable("studentId") Long studentId, @RequestBody PaymentDTO formData, HttpSession session) {
	
	// 	List<EnrolmentDTO> dtos = new ArrayList<EnrolmentDTO>();
	// 	Long invoId = invoiceService.getInvoiceIdByStudentId(studentId);
	// 	double paidAmount = formData.getAmount();
	// 	// boolean partialPaid = false;
	// 	// for(Long invoiceId : invoId){
	// 		// 1. get Invoice
	// 		Invoice invoice = invoiceService.findInvoiceById(invoId);
	// 		// 2. make payment
	// 		Payment payment = formData.convertToPayment();
	// 		Payment paid = paymentService.addPayment(payment);
	// 		// 3. update Invoice
	// 		invoice.setPaidAmount(paidAmount + invoice.getPaidAmount());
	// 		invoice.setPayment(paid);
	// 		// 4. check whether full paid or not
	// 		// if(invoice.getTotalAmount() > invoice.getPaidAmount()){
	// 		// 	partialPaid = true;
	// 		// }
	// 		// // 5. if partial paid, add Outstanding
	// 		// if(partialPaid){
	// 		// 	Outstanding outstanding = new Outstanding();
	// 		// 	outstanding.setPaid(paidAmount);
	// 		// 	outstanding.setRemaining(invoice.getTotalAmount()-invoice.getPaidAmount());
	// 		// 	outstanding.setTotal(invoice.getTotalAmount());
	// 		// 	// add Outstanding to Invoice
	// 		// 	invoice.addOutstanding(outstanding);
	// 		// }
	// 		invoice.setPayCompleteDate(LocalDate.now());
	// 		// 6. save Invoice
	// 		invoiceService.updateInvoice(invoice, invoId);
	// 		// 7. bring to EnrolmentDTO
	// 		List<EnrolmentDTO> enrols = enrolmentService.findEnrolmentByInvoice(invoId);
	// 		for(EnrolmentDTO enrol : enrols){
	// 			enrol.setInvoiceId(String.valueOf(invoId));
	// 			// 8. set period of enrolment to extra field
	// 			String start = cycleService.academicStartSunday(Integer.parseInt(enrol.getYear()), enrol.getStartWeek());
	// 			String end = cycleService.academicEndSaturday(Integer.parseInt(enrol.getYear()), enrol.getEndWeek());
	// 			enrol.setExtra(start + " ~ " + end);
	// 			// 9. add to dtos
	// 			dtos.add(enrol);
	// 		}	
	// 	// }
	// 	// 10. set EnrolmentDTO objects into session for payment receipt
	// 	session.setAttribute(JaeConstants.PAYMENTS, dtos);
	// 	// 11. return
	// 	return dtos;
	// }

	// // make payment and return updated invoice
	// @PostMapping("/paymentPartial/{studentId}")
	// @ResponseBody
	// // public List<OutstandingDTO> makePartialPayment(@PathVariable("studentId") Long studentId, @RequestBody PaymentDTO formData, HttpSession session) {
	// public Object makePartialPayment(@PathVariable("studentId") Long studentId, @RequestBody PaymentDTO formData, HttpSession session) {
	
	// 	List<EnrolmentDTO> dtos = new ArrayList<EnrolmentDTO>();
	// 	// 1. get latest Invoice
	// 	Long invoiceId = invoiceService.getInvoiceIdByStudentId(studentId);
	// 	double paidAmount = formData.getAmount();
	// 	// boolean partialPaid = false;
	// 	// for(Long invoiceId : invoiceIds){
	// 		// 1. get Invoice
	// 		Invoice invoice = invoiceService.findInvoiceById(invoiceId);
	// 		// 2. make payment
	// 		Payment payment = formData.convertToPayment();
	// 		Payment paid = paymentService.addPayment(payment);
	// 		// 3. update Invoice
	// 		invoice.setPaidAmount(paidAmount + invoice.getPaidAmount());
	// 		invoice.setPayment(paid);
	// 		// // 4. check whether full paid or not
	// 		// if(invoice.getTotalAmount() > invoice.getPaidAmount()){
	// 		// 	partialPaid = true;
	// 		// }
	// 		// // 5. if partial paid, add Outstanding
	// 		// if(partialPaid){
	// 		Outstanding outstanding = new Outstanding();
	// 		outstanding.setPaid(paidAmount);
	// 		outstanding.setRemaining(invoice.getTotalAmount()-invoice.getPaidAmount());
	// 		outstanding.setTotal(invoice.getTotalAmount());
	// 		// add Outstanding to Invoice
	// 		invoice.addOutstanding(outstanding);
	// 		// }
	// 		invoice.setPayCompleteDate(LocalDate.now());
	// 		// 6. save Invoice
	// 		invoiceService.updateInvoice(invoice, invoiceId);
	// 		// 7. bring to EnrolmentDTO
	// 		List<EnrolmentDTO> enrols = enrolmentService.findEnrolmentByInvoice(invoiceId);
	// 		for(EnrolmentDTO enrol : enrols){
	// 			enrol.setInvoiceId(String.valueOf(invoiceId));
	// 			// 8. set period of enrolment to extra field
	// 			String start = cycleService.academicStartSunday(Integer.parseInt(enrol.getYear()), enrol.getStartWeek());
	// 			String end = cycleService.academicEndSaturday(Integer.parseInt(enrol.getYear()), enrol.getEndWeek());
	// 			enrol.setExtra(start + " ~ " + end);
	// 			// 9. add to dtos
	// 			dtos.add(enrol);
	// 		}	
	// 	// }
	// 	// 10. set EnrolmentDTO objects into session for payment receipt
	// 	session.setAttribute(JaeConstants.PAYMENTS, dtos);
	// 	// get outstanding
	// 	List<OutstandingDTO> outstandingDTOs = outstandingService.getOutstandingtByInvoiceId(invoiceId);
	// 	// 11. return
	// 	return outstandingDTOs;
	// }

	// make payment and return updated invoice
	@PostMapping("/payment/{studentId}")
	@ResponseBody
	public Object makePayment(@PathVariable("studentId") Long studentId, @RequestBody PaymentDTO formData, HttpSession session) {
		List<EnrolmentDTO> dtos = new ArrayList<EnrolmentDTO>();
		Long invoId = invoiceService.getInvoiceIdByStudentId(studentId);
		double paidAmount = formData.getAmount();
		// 1. get Invoice
		Invoice invoice = invoiceService.findInvoiceById(invoId);
		// 2. check if full paid or not
		double totalAmount = invoice.getTotalAmount();
		boolean fullPaid =  (totalAmount - paidAmount) <= 0;
		// 3. make payment
		Payment payment = formData.convertToPayment();
		Payment paid = paymentService.addPayment(payment);
		// 3. update Invoice
		invoice.setPaidAmount(paidAmount + invoice.getPaidAmount());
		invoice.setPayment(paid);
		invoice.setPayCompleteDate(LocalDate.now());

		// 5-1. bring to EnrolmentDTO
		List<EnrolmentDTO> enrols = enrolmentService.findEnrolmentByInvoice(invoId);
		for(EnrolmentDTO enrol : enrols){
			enrol.setInvoiceId(String.valueOf(invoId));
			// 6-1. set period of enrolment to extra field
			String start = cycleService.academicStartSunday(Integer.parseInt(enrol.getYear()), enrol.getStartWeek());
			String end = cycleService.academicEndSaturday(Integer.parseInt(enrol.getYear()), enrol.getEndWeek());
			enrol.setExtra(start + " ~ " + end);
			// 7-1. add to dtos
			dtos.add(enrol);
		}	
		// 8-1. set EnrolmentDTO objects into session for payment receipt
		session.setAttribute(JaeConstants.PAYMENTS, dtos);
			
		// 4-1 if full paid, return EnrolmentDTO list
		if(fullPaid){
			invoiceService.updateInvoice(invoice, invoId);
			// 9-1. return
			return dtos;
			// 4-2. if not full paid, return OutstandingDTO list
		}else{
			// 5-2. create Outstanding
			Outstanding outstanding = new Outstanding();
			outstanding.setPaid(paidAmount);
			outstanding.setRemaining(invoice.getTotalAmount()-invoice.getPaidAmount());
			outstanding.setTotal(invoice.getTotalAmount());
			// 6-2. add Outstanding to Invoice
			invoice.addOutstanding(outstanding);
			invoiceService.updateInvoice(invoice, invoId);
			// 10-2. get outstanding
			List<OutstandingDTO> outstandingDTOs = outstandingService.getOutstandingtByInvoiceId(invoId);
			// 11-2. return
			return outstandingDTOs;
		}
	}

	// register new invoice
	@PostMapping("/issue/{studentId}")
	@ResponseBody
	public InvoiceDTO issueInvoice(@PathVariable("studentId") Long studentId) {
		// 1. get latest invoice by student id
		InvoiceDTO dto = invoiceService.getInvoiceByStudentId(studentId);
		return dto;
	}
		
	// // get start date of the week
	// @GetMapping("/startSunday/{year}/{week}")
	// @ResponseBody
	// String getStartDateofWeek(@PathVariable("year") int year, @PathVariable("week") int week) {
	// 	String date = cycleService.academicStartSunday(year, week);
	// 	return date;
	// }

	// // get end date of the week
	// @GetMapping("/endSaturday/{year}/{week}")
	// @ResponseBody
	// String getEndDateofWeek(@PathVariable("year") int year, @PathVariable("week") int week) {
	// 	String date = cycleService.academicEndSaturday(year, week);
	// 	return date;
	// }



}
