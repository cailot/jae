package hyung.jin.seo.jae.service;

import java.util.List;

import hyung.jin.seo.jae.dto.InvoiceDTO;
import hyung.jin.seo.jae.model.Invoice;

public interface InvoiceService {
	
	// list all Invoice
	List<InvoiceDTO> allInvoices();
	
	// get total number of cycle
 	long checkCount();

	// get Invoice by Id
    InvoiceDTO getInvoice(Long id);

	// add Invoice
	InvoiceDTO addInvoice(Invoice invoice);

	// update Invoice
	InvoiceDTO updateInvoice(Invoice invoice, Long id);
}
