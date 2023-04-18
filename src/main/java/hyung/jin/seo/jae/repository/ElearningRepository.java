package hyung.jin.seo.jae.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import hyung.jin.seo.jae.model.Elearning;
import hyung.jin.seo.jae.model.Student;

public interface ElearningRepository extends JpaRepository<Elearning, Long>, JpaSpecificationExecutor<Elearning>{  
	
	List<Elearning> findAllByEndDateIsNull();
	
	List<Elearning> findAllByEndDateIsNotNull();
	
	Elearning findByIdAndEndDateIsNull(Long id);
	
	long countByEndDateIsNull();
}
