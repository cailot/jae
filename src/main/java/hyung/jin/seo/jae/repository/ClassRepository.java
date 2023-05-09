package hyung.jin.seo.jae.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import hyung.jin.seo.jae.dto.ClassDTO;
import hyung.jin.seo.jae.model.Class;

public interface ClassRepository extends JpaRepository<Class, Long>{  
	
	@Query("SELECT new hyung.jin.seo.jae.dto.ClassDTO(c.id, c.fee, c.description, c.course.id, c.cycle.id, c.course.grade, c.course.day, c.cycle.year) FROM Class c WHERE c.course.grade = ?1 AND c.cycle.year = ?2")
	List<ClassDTO> findClassForGradeNCycle(String grade, int year);
}
