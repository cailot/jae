package hyung.jin.seo.jae.service;

import java.util.List;

import hyung.jin.seo.jae.dto.OutstandingDTO;
import hyung.jin.seo.jae.model.Outstanding;

public interface OutstandingService {
	
	// list all Outstanding
	List<OutstandingDTO> allOutstandings();
	
	// get total number of outstanding
 	long checkCount();

	// get Outstanding by Id
    OutstandingDTO getOutstanding(Long id);

	// get Outstanding by invoice Id
	List<OutstandingDTO> getOutstandingtByInvoiceId(Long invoiceId);

	// add Oustanding
	Outstanding addOutstanding(Outstanding stand);

}
