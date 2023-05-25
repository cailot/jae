package hyung.jin.seo.jae.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import hyung.jin.seo.jae.dto.ClazzDTO;
import hyung.jin.seo.jae.model.Clazz;

public interface ClazzRepository extends JpaRepository<Clazz, Long>{  
																			
	@Query("SELECT new hyung.jin.seo.jae.dto.ClazzDTO(c.id, c.fee, c.name, c.day, c.startDate, c.active, c.course.id, c.cycle.id, c.course.grade, c.course.description, c.cycle.year) FROM Clazz c WHERE c.course.grade = ?1 AND c.cycle.year = ?2")
	List<ClazzDTO> findClassForGradeNCycle(String grade, int year);
}
