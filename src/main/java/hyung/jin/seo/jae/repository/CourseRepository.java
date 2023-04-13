package hyung.jin.seo.jae.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import hyung.jin.seo.jae.model.Course;
import hyung.jin.seo.jae.model.Student;

public interface CourseRepository extends JpaRepository<Course, Long>, JpaSpecificationExecutor<Course>{  
	
	List<Course> findAllByEndDateIsNull();
	
	List<Course> findAllByEndDateIsNotNull();
	
	Course findByIdAndEndDateIsNull(Long id);
	
	long countByEndDateIsNull();
}
