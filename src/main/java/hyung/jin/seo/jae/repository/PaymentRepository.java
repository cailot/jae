package hyung.jin.seo.jae.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import hyung.jin.seo.jae.model.Payment;

public interface PaymentRepository extends JpaRepository<Payment, Long>{  
	
	// bring PaymentDTO by invoice id
	// @Query("SELECT new hyung.jin.seo.jae.dto.PaymentDTO(p.id, p.amount, p.method, p.registerDate, p.invoiceId, p.info) FROM Payment p WHERE p.invoiceid = ?1") 
	// List<PaymentDTO> findPaymentByInvoiceId(long invoiceId);

	@Query(value = "SELECT p.id, p.amount, p.method, p.register_date, p.invoiceId, p.info FROM Payment p WHERE p.invoiceId = ?1", nativeQuery = true)
	Payment findByInvoiceId(Long invoiceId);


}
