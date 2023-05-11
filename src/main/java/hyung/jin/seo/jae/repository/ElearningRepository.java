package hyung.jin.seo.jae.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import hyung.jin.seo.jae.model.Elearning;

public interface ElearningRepository extends JpaRepository<Elearning, Long>{  
	
	List<Elearning> findAll();
	
	List<Elearning> findAllByGrade(String grade);
	
	Optional<Elearning> findById(Long id);
	
	long count();
}
