package hyung.jin.seo.jae.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import hyung.jin.seo.jae.model.CourseBook;
import hyung.jin.seo.jae.model.CourseFee;
import hyung.jin.seo.jae.model.Elearning;
import hyung.jin.seo.jae.model.Student;

public interface CourseBookRepository extends JpaRepository<CourseBook, Long>{  
	
	List<CourseBook> findAll();
	
	List<CourseBook> findByYear(String year);

	List<CourseBook> findByGradeAndYear(String grade, String year);
	
	long count();
}
