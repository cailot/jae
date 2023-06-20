package hyung.jin.seo.jae.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import hyung.jin.seo.jae.dto.EnrolmentDTO;
import hyung.jin.seo.jae.model.Enrolment;

public interface EnrolmentRepository extends JpaRepository<Enrolment, Long>{  
	
	// find all enrolments by student id
	// List<Enrolment> findAllByClazzId(long clazzId);

	// find all enrolments by student id
	// List<Enrolment> findAllByStudentId(long studentId);

	// find all enrolments by student id
	// List<Enrolment> findAllByClazzIdAndStudentId(long clazzId, long studentId);

	// bring latest EnrolmentDTO by student id
	@Query("SELECT new hyung.jin.seo.jae.dto.EnrolmentDTO(e.id, e.enrolmentDate, e.cancelled, e.cancellationReason, e.startWeek, e.endWeek, e.credit, e.discount, e.amount, e.student.id, e.clazz.id, e.clazz.course.description, e.clazz.course.price, e.clazz.cycle.year, e.clazz.course.grade, e.clazz.day) FROM Enrolment e WHERE e.student.id = ?1 and e.old = false") 
	List<EnrolmentDTO> findEnrolmentByStudentId(long studentId);

	// bring latest EnrolmentDTO by student id
	@Query("SELECT new hyung.jin.seo.jae.dto.EnrolmentDTO(e.id, e.enrolmentDate, e.cancelled, e.cancellationReason, e.startWeek, e.endWeek, e.credit, e.discount, e.amount, e.student.id, e.clazz.id, e.clazz.course.description, e.clazz.course.price, e.clazz.cycle.year, e.clazz.course.grade, e.clazz.day) FROM Enrolment e WHERE e.clazz.id = ?1 and e.old = false") 
	List<EnrolmentDTO> findEnrolmentByClazzId(long clazzId);

	// bring latest EnrolmentDTO by invoice id
	@Query("SELECT new hyung.jin.seo.jae.dto.EnrolmentDTO(e.id, e.enrolmentDate, e.cancelled, e.cancellationReason, e.startWeek, e.endWeek, e.credit, e.discount, e.amount, e.student.id, e.clazz.id, e.clazz.course.description, e.clazz.course.price, e.clazz.cycle.year, e.clazz.course.grade, e.clazz.day) FROM Enrolment e WHERE e.invoice.id = ?1 and e.old = false") 
	List<EnrolmentDTO> findEnrolmentByInvoiceId(long invoiceId);

	// bring latest EnrolmentDTO by clazz id & student id
	@Query("SELECT new hyung.jin.seo.jae.dto.EnrolmentDTO(e.id, e.enrolmentDate, e.cancelled, e.cancellationReason, e.startWeek, e.endWeek, e.credit, e.discount, e.amount, e.student.id, e.clazz.id, e.clazz.course.description, e.clazz.course.price, e.clazz.cycle.year, e.clazz.course.grade, e.clazz.day) FROM Enrolment e WHERE e.clazz.id = ?1 and e.student.id = ?2 and e.old = false")	
	List<EnrolmentDTO> findEnrolmentByClazzIdAndStudentId(long clazzId, long studentId);	

	// return class id by student id
	@Query("SELECT e.clazz.id FROM Enrolment e WHERE e.student.id = ?1 and e.old = false")
	List<Long> findClazzIdByStudentId(long clazzId);

	// return enrolment id by student id
	@Query("SELECT e.id FROM Enrolment e WHERE e.student.id = ?1 and e.old = false")
	List<Long> findEnrolmentIdByStudentId(long studentId);

	// return enrolment id by invoice id
	@Query("SELECT e.id FROM Enrolment e WHERE e.invoice.id = ?1 and e.old = false")
	List<Long> findEnrolmentIdByInvoiceId(long invoiceId);
}
