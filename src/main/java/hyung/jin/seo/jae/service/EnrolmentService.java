package hyung.jin.seo.jae.service;

import java.util.List;

import hyung.jin.seo.jae.dto.EnrolmentDTO;
import hyung.jin.seo.jae.model.Enrolment;

public interface EnrolmentService {
	// list all enrolments
	List<EnrolmentDTO> allEnrolments();

	// list enrolments by student Id
	List<EnrolmentDTO> findEnrolmentByStudent(Long studentId);

	// list enrolments by clazz Id
	List<EnrolmentDTO> findEnrolmentByClazz(Long claszzId);

	// list enrolments by clazz Id and student Id
	List<EnrolmentDTO> findEnrolmentByClazzAndStudent(Long clazzId, Long studentId);

	// return total count
	long checkCount();

	// add enrolment
	EnrolmentDTO addEnrolment(Enrolment enrolment);
}