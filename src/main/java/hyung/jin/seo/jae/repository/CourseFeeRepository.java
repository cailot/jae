package hyung.jin.seo.jae.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import hyung.jin.seo.jae.model.CourseFee;
import hyung.jin.seo.jae.model.Elearning;
import hyung.jin.seo.jae.model.Student;

public interface CourseFeeRepository extends JpaRepository<CourseFee, Long>{  
	
	List<CourseFee> findAll();
	
	List<CourseFee> findByYear(String year);

	List<CourseFee> findByGradeAndYear(String grade, String year);
	
	long count();
}
