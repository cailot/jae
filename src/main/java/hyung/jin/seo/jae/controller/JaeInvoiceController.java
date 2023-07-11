package hyung.jin.seo.jae.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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
import hyung.jin.seo.jae.dto.MoneyDTO;
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
import io.micrometer.core.instrument.util.StringUtils;

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
			// 9. create Invoice
			InvoiceDTO dto = invoiceService.addInvoice(invoice);
			// 10. return flag;
			return dto;
		}
	}

	// make payment and return updated invoice
	@PostMapping("/payment/{studentId}")
	@ResponseBody
	public List makePayment(@PathVariable("studentId") Long studentId, @RequestBody PaymentDTO formData, HttpSession session) {
		List<EnrolmentDTO> dtos = new ArrayList<EnrolmentDTO>();
		//List<MoneyDTO> dtos = new ArrayList<MoneyDTO>();
		Long invoId = invoiceService.getInvoiceIdByStudentId(studentId);
		double paidAmount = formData.getAmount();
		// 1. get Invoice
		Invoice invoice = invoiceService.findInvoiceById(invoId);
		// 2. check if full paid or not
		double amount = invoice.getAmount();
		boolean fullPaid =  (amount - paidAmount) <= 0;
		// 3. make payment
		Payment payment = formData.convertToPayment();
		Payment paid = paymentService.addPayment(payment);
		// 3. update Invoice
		invoice.setPaidAmount(paidAmount + invoice.getPaidAmount());
		invoice.setPayment(paid);
		invoice.setPayCompleteDate(LocalDate.now());
		// // 4. bring to EnrolmentDTO
		// List<EnrolmentDTO> enrols = enrolmentService.findEnrolmentByInvoice(invoId);
		// for(EnrolmentDTO enrol : enrols){
		// 	enrol.setInvoiceId(String.valueOf(invoId));
		// 	// 5. set period of enrolment to extra field
		// 	String start = cycleService.academicStartSunday(Integer.parseInt(enrol.getYear()), enrol.getStartWeek());
		// 	String end = cycleService.academicEndSaturday(Integer.parseInt(enrol.getYear()), enrol.getEndWeek());
		// 	enrol.setExtra(start + " ~ " + end);
		// 	// 6. add to dtos
		// 	dtos.add(enrol);
		// }	
		// // 7. set EnrolmentDTO objects into session for payment receipt
		// session.setAttribute(JaeConstants.PAYMENT_ENROLMENTS, dtos);
			
		// 8-1 if full paid, return EnrolmentDTO list
		if(fullPaid){
			invoiceService.updateInvoice(invoice, invoId);
			// 4. bring to EnrolmentDTO
			List<EnrolmentDTO> enrols = enrolmentService.findEnrolmentByInvoice(invoId);
			for(EnrolmentDTO enrol : enrols){
				enrol.setInvoiceId(String.valueOf(invoId));
				// 5. set period of enrolment to extra field
				String start = cycleService.academicStartSunday(Integer.parseInt(enrol.getYear()), enrol.getStartWeek());
				String end = cycleService.academicEndSaturday(Integer.parseInt(enrol.getYear()), enrol.getEndWeek());
				enrol.setExtra(start + " ~ " + end);
				// 6. add to dtos
				dtos.add(enrol);
			}	
			// 7. set EnrolmentDTO objects into session for payment receipt
			session.setAttribute(JaeConstants.PAYMENT_ENROLMENTS, dtos);
		
			// remove Outstandings from session
			session.removeAttribute(JaeConstants.PAYMENT_OUTSTANDINGS);
			// 9-1. return
			return dtos;
		// 8-2. if not full paid, return OutstandingDTO list
		}else{
			// 9-2. create Outstanding
			Outstanding outstanding = new Outstanding();
			outstanding.setPaid(paidAmount);
			outstanding.setRemaining(invoice.getAmount()-invoice.getPaidAmount());
			outstanding.setAmount(invoice.getAmount());
			// 10-2. add Outstanding to Invoice
			invoice.addOutstanding(outstanding);
			invoiceService.updateInvoice(invoice, invoId);

			// 4. bring to EnrolmentDTO
			List<EnrolmentDTO> enrols = enrolmentService.findEnrolmentByInvoice(invoId);
			for(EnrolmentDTO enrol : enrols){
				enrol.setInvoiceId(String.valueOf(invoId));
				// 5. set period of enrolment to extra field
				String start = cycleService.academicStartSunday(Integer.parseInt(enrol.getYear()), enrol.getStartWeek());
				String end = cycleService.academicEndSaturday(Integer.parseInt(enrol.getYear()), enrol.getEndWeek());
				enrol.setExtra(start + " ~ " + end);
				// 6. add to dtos
				dtos.add(enrol);
			}	
			// 7. set EnrolmentDTO objects into session for payment receipt
			session.setAttribute(JaeConstants.PAYMENT_ENROLMENTS, dtos);
		
			// 11-2. get outstanding
			List<OutstandingDTO> outstandingDTOs = outstandingService.getOutstandingtByInvoiceId(invoId);
			// 12-2. set OutstandingDTO objects into session for payment receipt
			session.setAttribute(JaeConstants.PAYMENT_OUTSTANDINGS, outstandingDTOs);
			// 13-2. return
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


	// update Info for Enrolment or Outstanding
	@PostMapping("/updateInfo/{dataType}/{dataId}")
	@ResponseBody
	public ResponseEntity<String> updateInformation(@PathVariable("dataType") String dataType, @PathVariable("dataId") Long dataId, @RequestBody(required = false) String info){
		// 1. check dataType
		if(dataType.equals("enrolment")){
			// 2. get Enrolment
			Enrolment enrolment = enrolmentService.getEnrolment(dataId);
			enrolment.setInfo(info);
			// 3. update Enrolment
			enrolmentService.updateEnrolment(enrolment, dataId);
			// 4. return flag
			return ResponseEntity.ok("Enrolment Success");
		}else {
			return ResponseEntity.ok("Enrolment fail");
		}
	}
}
