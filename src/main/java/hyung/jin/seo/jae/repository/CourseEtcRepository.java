package hyung.jin.seo.jae.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import hyung.jin.seo.jae.model.CourseEtc;

public interface CourseEtcRepository extends JpaRepository<CourseEtc, Long>, JpaSpecificationExecutor<CourseEtc>{  
	
	List<CourseEtc> findAll();

	List<CourseEtc> findAllByNameNotLike(String keyword);
	
	long count();
}
