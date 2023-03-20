package hyung.jin.seo.jae.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import hyung.jin.seo.jae.model.Student;

public interface StudentRepository extends JpaRepository<Student, Long>, JpaSpecificationExecutor<Student>{  
	
	List<Student> findAllByEndDateIsNull();
	
	List<Student> findAllByEndDateIsNotNull();
	
	Student findByIdAndEndDateIsNull(Long id);
	
	long countByEndDateIsNull();
}
