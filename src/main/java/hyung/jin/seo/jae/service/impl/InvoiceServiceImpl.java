package hyung.jin.seo.jae.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityNotFoundException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import hyung.jin.seo.jae.dto.InvoiceDTO;
import hyung.jin.seo.jae.model.Invoice;
import hyung.jin.seo.jae.repository.InvoiceRepository;
import hyung.jin.seo.jae.service.InvoiceService;

@Service
public class InvoiceServiceImpl implements InvoiceService {
	
	@Autowired
	private InvoiceRepository invoiceRepository;
   
	@Override
	public long checkCount() {
		long count = invoiceRepository.count();
		return count;
	}

	@Override
	public List<InvoiceDTO> allInvoices() {
		List<Invoice> invoices = invoiceRepository.findAll();
		List<InvoiceDTO> dtos = new ArrayList<>();
		for(Invoice invoice: invoices){
			InvoiceDTO dto = new InvoiceDTO(invoice);
			dtos.add(dto);
		}
		return dtos;
	}

	// add Invoice
	@Override
	@Transactional
	public InvoiceDTO addInvoice(Invoice invoice) {
		Invoice invo = invoiceRepository.save(invoice);
		InvoiceDTO dto = new InvoiceDTO(invo);
		return dto;
	}

	// find Invoice by id
	@Override
	public InvoiceDTO getInvoice(Long id) {
		Invoice invoice = invoiceRepository.findById(id).orElseThrow(() -> new EntityNotFoundException("Enrolment not found"));
		InvoiceDTO dto = new InvoiceDTO(invoice);
		return dto;
	}

	@Override
	@Transactional
	public InvoiceDTO updateInvoice(Invoice invoice, Long id) {
		// search by getId
		Invoice existing = invoiceRepository.findById(id).orElseThrow(() -> new EntityNotFoundException("Enrolment not found"));
		// Update info
		// StartWeek
		// if(enrolment.getStartWeek()!=existing.getStartWeek()){
		// 	existing.setStartWeek(enrolment.getStartWeek());
		// }
		// // EndWeek
		// if(enrolment.getEndWeek()!=existing.getEndWeek()){
		// 	existing.setEndWeek(enrolment.getEndWeek());
		// }
		// // cancelled
		// if(enrolment.isCancelled()!=existing.isCancelled()){
		// 	existing.setCancelled(enrolment.isCancelled());
		// }
		// // cancellationReason
		// if(!StringUtils.equalsIgnoreCase(StringUtils.defaultString(enrolment.getCancellationReason()), StringUtils.defaultString(existing.getCancellationReason()))){
		// 	existing.setCancellationReason(StringUtils.defaultString(enrolment.getCancellationReason()));
		// }
		// update the existing record
		Invoice updated = invoiceRepository.save(existing);
		InvoiceDTO dto = new InvoiceDTO(updated);
		return dto;
	}

	@Override
	public InvoiceDTO findInvoiceByStudentId(Long studentId) {
		return invoiceRepository.findByStudentId(studentId);
	}

	@Override
	public List<Long> findInvoiceIdByStudentId(Long studentId) {
		return invoiceRepository.findInvoiceIdByStudentId(studentId);
	}


}
