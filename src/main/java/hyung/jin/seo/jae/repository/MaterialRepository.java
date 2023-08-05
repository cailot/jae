package hyung.jin.seo.jae.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import hyung.jin.seo.jae.dto.EnrolmentDTO;
import hyung.jin.seo.jae.dto.MaterialDTO;
import hyung.jin.seo.jae.model.Material;

public interface MaterialRepository extends JpaRepository<Material, Long>{  
	
	List<Material> findAll();
	
	@Query("SELECT new hyung.jin.seo.jae.dto.MaterialDTO(m.id, m.registerDate, m.paymentDate, m.info, m.book.id, m.book.name, m.book.price, m.invoice.id) FROM Material m WHERE m.invoice.id = ?1") 
	List<MaterialDTO> findMaterialByInvoiceId(Long invoiceId);

	long count();
}
