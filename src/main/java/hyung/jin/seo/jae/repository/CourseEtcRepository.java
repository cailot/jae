package hyung.jin.seo.jae.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import hyung.jin.seo.jae.model.CourseEtc;
import hyung.jin.seo.jae.model.CourseFee;
import hyung.jin.seo.jae.model.Elearning;
import hyung.jin.seo.jae.model.Student;

public interface CourseEtcRepository extends JpaRepository<CourseEtc, Long>, JpaSpecificationExecutor<CourseEtc>{  
	
	List<CourseEtc> findAll();
	
	long count();
}
