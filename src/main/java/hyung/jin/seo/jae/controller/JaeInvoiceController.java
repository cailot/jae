package hyung.jin.seo.jae.controller;

import java.text.ParseException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpSession;

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
import hyung.jin.seo.jae.dto.MaterialDTO;
import hyung.jin.seo.jae.dto.MoneyDTO;
import hyung.jin.seo.jae.dto.OutstandingDTO;
import hyung.jin.seo.jae.dto.PaymentDTO;
import hyung.jin.seo.jae.model.Enrolment;
import hyung.jin.seo.jae.model.Invoice;
import hyung.jin.seo.jae.model.Material;
import hyung.jin.seo.jae.model.Outstanding;
import hyung.jin.seo.jae.model.Payment;
import hyung.jin.seo.jae.service.BookService;
import hyung.jin.seo.jae.service.CycleService;
import hyung.jin.seo.jae.service.EnrolmentService;
import hyung.jin.seo.jae.service.InvoiceService;
import hyung.jin.seo.jae.service.MaterialService;
import hyung.jin.seo.jae.service.OutstandingService;
import hyung.jin.seo.jae.service.PaymentService;
import hyung.jin.seo.jae.utils.JaeConstants;
import hyung.jin.seo.jae.utils.JaeUtils;
import io.micrometer.core.instrument.util.StringUtils;

@Controller
@RequestMapping("invoice")
public class JaeInvoiceController {

	@Autowired
	private InvoiceService invoiceService;

	@Autowired
	private EnrolmentService enrolmentService;

	@Autowired
	private BookService bookService;

	@Autowired
	private MaterialService materialService;

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
		// 1. flush session from previous payment
		clearSession(session);
		List dtos = new ArrayList();
		List<EnrolmentDTO> enrolments = new ArrayList<EnrolmentDTO>();
		List<MaterialDTO> materials = new ArrayList<MaterialDTO>();
		Long invoId = invoiceService.getInvoiceIdByStudentId(studentId);
		double paidAmount = formData.getAmount();
		// 2. get Invoice
		Invoice invoice = invoiceService.findInvoiceById(invoId);
		// 3. check if full paid or not
		double amount = invoice.getAmount();
		boolean fullPaid =  (amount - paidAmount) <= 0;
		// 4. make payment
		Payment payment = formData.convertToPayment();
		Payment paid = paymentService.addPayment(payment);
		// 5. update Invoice
		invoice.setPaidAmount(paidAmount + invoice.getPaidAmount());
		invoice.addPayment(paid);
		invoice.setPaymentDate(LocalDate.now());
		// 6. Create MoneyDTO for header
		MoneyDTO header = new MoneyDTO();
		List<String> headerGrade = new ArrayList<String>();
		String headerDueDate = JaeUtils.getToday();
		// 7-1 if full paid, return EnrolmentDTO list
		if(fullPaid){
			invoiceService.updateInvoice(invoice, invoId);
			// 8-1. bring to EnrolmentDTO
			List<EnrolmentDTO> enrols = enrolmentService.findEnrolmentByInvoice(invoId);
			for(EnrolmentDTO enrol : enrols){
				enrol.setInvoiceId(String.valueOf(invoId));
				
				// 9-1. set period of enrolment to extra field
				String start = cycleService.academicStartSunday(Integer.parseInt(enrol.getYear()), enrol.getStartWeek());
				String end = cycleService.academicEndSaturday(Integer.parseInt(enrol.getYear()), enrol.getEndWeek());
				enrol.setExtra(start + " ~ " + end);

				// 10-1. set headerGrade
				if(!headerGrade.contains(enrol.getGrade())){
					headerGrade.add(enrol.getGrade().toUpperCase());
				}
				// 11-1. set earliest start date to headerDueDate
				try {
					if(JaeUtils.isEarlier(start, headerDueDate)){
						headerDueDate = start;
					}
				} catch (ParseException e) {
					e.printStackTrace();
				}

				// 12-1. add to dtos
				enrolments.add(enrol);
			}	
			// 13-1. set EnrolmentDTO objects into session for payment receipt
			session.setAttribute(JaeConstants.PAYMENT_ENROLMENTS, enrolments);
			
			// 14-1. bring to MaterialDTO - bring materials by invoice id from Book_Invoice table
			materials = materialService.findMaterialByInvoiceId(invoId);
			// 15-1. set MaterialDTO payment date
			for(MaterialDTO material : materials){
				material.setPaymentDate(JaeUtils.getToday());
				// material update
				Material mat = materialService.getMaterial(Long.parseLong(material.getId()));
				mat.setPaymentDate(LocalDate.now());
				materialService.updateMaterial(mat, Long.parseLong(material.getId()));
			}
			// 16-1. set MaterialDTO objects into session for payment receipt
			session.setAttribute(JaeConstants.PAYMENT_MATERIALS, materials);
			// 17-1. Header Info - Due Date & Grade
			header.setRegisterDate(headerDueDate);
			header.setInfo(String.join(", ", headerGrade));
			session.setAttribute(JaeConstants.PAYMENT_HEADER, header);
			// 18-1. return
			dtos.addAll(enrolments);
			dtos.addAll(materials);
			return dtos;
		// 7-2. if not full paid, return OutstandingDTO list
		}else{
			// 8-2. create Outstanding
			Outstanding outstanding = new Outstanding();
			outstanding.setPaid(paidAmount);
			outstanding.setRemaining(invoice.getAmount()-invoice.getPaidAmount());
			outstanding.setAmount(invoice.getAmount());
			// 9-2. add Outstanding to Invoice
			invoice.addOutstanding(outstanding);
			invoiceService.updateInvoice(invoice, invoId);
			// 10-2. bring to EnrolmentDTO
			List<EnrolmentDTO> enrols = enrolmentService.findEnrolmentByInvoice(invoId);
			for(EnrolmentDTO enrol : enrols){
				enrol.setInvoiceId(String.valueOf(invoId));
				// 11-2. set period of enrolment to extra field
				String start = cycleService.academicStartSunday(Integer.parseInt(enrol.getYear()), enrol.getStartWeek());
				String end = cycleService.academicEndSaturday(Integer.parseInt(enrol.getYear()), enrol.getEndWeek());
				enrol.setExtra(start + " ~ " + end);

				// 12-2. set headerGrade
				if(!headerGrade.contains(enrol.getGrade())){
					headerGrade.add(enrol.getGrade().toUpperCase());
				}
				// 13-2. set earliest start date to headerDueDate
				try {
					if(JaeUtils.isEarlier(start, headerDueDate)){
						headerDueDate = start;
					}
				} catch (ParseException e) {
					e.printStackTrace();
				}

				// 14-2. add to dtos
				enrolments.add(enrol);
			}	
			// 15-2. set EnrolmentDTO objects into session for payment receipt
			session.setAttribute(JaeConstants.PAYMENT_ENROLMENTS, enrolments);
			// 16-2. get outstanding
			List<OutstandingDTO> outstandingDTOs = outstandingService.getOutstandingtByInvoiceId(invoId);
			// 17-2. set OutstandingDTO objects into session for payment receipt
			session.setAttribute(JaeConstants.PAYMENT_OUTSTANDINGS, outstandingDTOs);

			// 18-2. bring to MaterialDTO - bring materials by invoice id
			materials = materialService.findMaterialByInvoiceId(invoId);
			// 19-2. set BookDTO payment date
			for(MaterialDTO material : materials){
				material.setPaymentDate(JaeUtils.getToday());
				// material update
				Material mat = materialService.getMaterial(Long.parseLong(material.getId()));
				mat.setPaymentDate(LocalDate.now());
				materialService.updateMaterial(mat, Long.parseLong(material.getId()));
			}
			// 20-2. set BookDTO objects into session for payment receipt
			session.setAttribute(JaeConstants.PAYMENT_MATERIALS, materials);

			// 21-2. Header Info - Due Date & Grade
			header.setRegisterDate(headerDueDate);
			header.setInfo(String.join(", ", headerGrade));
			session.setAttribute(JaeConstants.PAYMENT_HEADER, header);
			// 22-2. return
			dtos.addAll(enrolments);
			dtos.addAll(materials);
			dtos.addAll(outstandingDTOs);
			return dtos;
		}
	}

	// register new invoice
	@PostMapping("/issue/{studentId}")
	@ResponseBody
	public InvoiceDTO issueInvoice(@PathVariable("studentId") Long studentId, @RequestBody(required = false) String info, HttpSession session) {
		// 1. get latest invoice by student id
		InvoiceDTO dto = invoiceService.getInvoiceDTOByStudentId(studentId);
		// 2. update invoice if info exists
		if(StringUtils.isNotBlank(info)){
			Invoice invoice = invoiceService.findInvoiceById(dto.getId());
			invoice.setInfo(info);
			invoiceService.updateInvoice(invoice, dto.getId());
		}
		// 3. set payment elements related to invoice into session
		session.setAttribute(JaeConstants.PAYMENT_INVOICE, dto);

		// 4. return dto
		return dto;
	}


	// update additional memo for Enrolment or Outstanding
	@PostMapping("/updateInfo/{dataType}/{dataId}")
	@ResponseBody
	public ResponseEntity<String> updateInformation(@PathVariable("dataType") String dataType, @PathVariable("dataId") Long dataId, @RequestBody(required = false) String info){
		// 1. check dataType
		if(JaeConstants.ENROLMENT.equalsIgnoreCase(dataType)){
			// 2-1. get Enrolment
			Enrolment enrolment = enrolmentService.getEnrolment(dataId);
			enrolment.setInfo(info);
			// 3-1. update Enrolment
			enrolmentService.updateEnrolment(enrolment, dataId);
			// 4-1. return flag
			return ResponseEntity.ok("Enrolment Success");
		}else if(JaeConstants.OUTSTANDING.equalsIgnoreCase(dataType)){
			// 2-2. get Outstanding
			Outstanding outstanding = outstandingService.getOutstanding(dataId);
			// 3-2. update Outstanding
			outstanding.setInfo(info);
			outstandingService.updateOutstanding(outstanding, dataId);
			// 4-2. return flag
			return ResponseEntity.ok("Outstanding Success");
		}else if(JaeConstants.BOOK.equalsIgnoreCase(dataType)){
			// 2-3. get Material
			Material material = materialService.getMaterial(dataId);
			// 3-3. update Material
			material.setInfo(info);
			materialService.updateMaterial(material, dataId);
			// 4-2. return flag
			return ResponseEntity.ok("Material Success");
		}else{
			return ResponseEntity.ok("Error");
		}
	}


	private void clearSession(HttpSession session){
		Enumeration<String> names = session.getAttributeNames();
		while(names.hasMoreElements()){
			String name = names.nextElement();
			session.removeAttribute(name);
		}
	}
}
