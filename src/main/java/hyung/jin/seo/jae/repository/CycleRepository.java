package hyung.jin.seo.jae.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import hyung.jin.seo.jae.model.Cycle;

public interface CycleRepository extends JpaRepository<Cycle, Long>{  
	
	List<Cycle> findAll();

	long count();
}
