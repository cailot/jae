package hyung.jin.seo.jae.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import hyung.jin.seo.jae.dto.EnrolmentDTO;
import hyung.jin.seo.jae.model.Enrolment;

public interface EnrolmentRepository extends JpaRepository<Enrolment, Long>{  
																			
	// @Query("SELECT new hyung.jin.seo.jae.dto.ClazzDTO(c.id, c.fee, c.name, c.day, c.startDate, c.active, c.course.id, c.cycle.id, c.course.grade, c.course.description, c.cycle.year) FROM Clazz c WHERE c.course.grade = ?1 AND c.cycle.year = ?2")
	// List<ClazzDTO> findClassForGradeNCycle(String grade, int year);

	List<Enrolment> findAllByClazzId(long clazzId);

	List<Enrolment> findAllByStudentId(long studentId);

	List<Enrolment> findAllByClazzIdAndStudentId(long clazzId, long studentId);

	@Query("SELECT new hyung.jin.seo.jae.dto.EnrolmentDTO(e.id, e.enrolmentDate, e.cancelled, e.cancellationReason, e.startWeek, e.endWeek, e.clazz.name, e.clazz.fee, e.clazz.cycle.year) FROM Enrolment e WHERE e.student.id = ?1") 
	List<EnrolmentDTO> findEnrolmentByStudentId(long studentId);


}
