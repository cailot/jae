package hyung.jin.seo.jae.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import hyung.jin.seo.jae.dto.EnrolmentDTO;
import hyung.jin.seo.jae.model.Enrolment;

public interface EnrolmentRepository extends JpaRepository<Enrolment, Long>{  
																			
	List<Enrolment> findAllByClazzId(long clazzId);

	List<Enrolment> findAllByStudentId(long studentId);

	List<Enrolment> findAllByClazzIdAndStudentId(long clazzId, long studentId);

	@Query("SELECT new hyung.jin.seo.jae.dto.EnrolmentDTO(e.id, e.enrolmentDate, e.cancelled, e.cancellationReason, e.startWeek, e.endWeek, e.student.id, e.clazz.id, e.clazz.course.description, e.clazz.fee, e.clazz.cycle.year, e.clazz.course.grade, e.clazz.day) FROM Enrolment e WHERE e.student.id = ?1") 
	List<EnrolmentDTO> findEnrolmentByStudentId(long studentId);

	// return class id by student id
	@Query("SELECT e.clazz.id FROM Enrolment e WHERE e.student.id = ?1")
	List<Long> findClazzIdByStudentId(long studentId);

	// return enrolment id by student id
	@Query("SELECT e.id FROM Enrolment e WHERE e.student.id = ?1")
	List<Long> findEnrolmentIdByStudentId(long studentId);
}
