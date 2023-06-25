package hyung.jin.seo.jae.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import hyung.jin.seo.jae.dto.InvoiceDTO;
import hyung.jin.seo.jae.model.Invoice;

public interface InvoiceRepository extends JpaRepository<Invoice, Long>{  
	
	// bring latest InvoiceDTO by student id
	@Query("SELECT new hyung.jin.seo.jae.dto.InvoiceDTO(i.id, i.credit, i.discount, i.paidAmount, i.totalAmount, i.registerDate, i.payCompleteDate) FROM Invoice i WHERE i.id = (SELECT en.invoice.id FROM Enrolment en WHERE en.student.id = ?1 AND en.old = false)")
    InvoiceDTO findByStudentId(long studentId);

	// return invoice id by student id
	@Query("SELECT e.invoice.id FROM Enrolment e WHERE e.student.id = ?1 and e.old = false order by e.enrolmentDate desc")
	List<Long> findInvoiceIdByStudentId(long studentId);
}
