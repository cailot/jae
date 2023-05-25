package hyung.jin.seo.jae.service.impl;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hyung.jin.seo.jae.dto.EnrolmentDTO;
import hyung.jin.seo.jae.model.Enrolment;
import hyung.jin.seo.jae.repository.EnrolmentRepository;
import hyung.jin.seo.jae.service.EnrolmentService;

@Service
public class EnrolmentServiceImpl implements EnrolmentService {
	
	@Autowired
	private EnrolmentRepository enrolmentRepository;

	@Override
	public List<EnrolmentDTO> allEnrolments() {
		List<Enrolment> enrols = enrolmentRepository.findAll();
		List<EnrolmentDTO> dtos = new ArrayList<>();
		for(Enrolment enrol: enrols){
			EnrolmentDTO dto = new EnrolmentDTO(enrol);
			dtos.add(dto);
		}
		return dtos;
	}

	@Override
	public List<EnrolmentDTO> findEnrolmentByStudent(Long studentId) {
		List<Enrolment> enrols = enrolmentRepository.findAllByStudentId(studentId);
		List<EnrolmentDTO> dtos = new ArrayList<>();
		for(Enrolment enrol: enrols){
			EnrolmentDTO dto = new EnrolmentDTO(enrol);
			dtos.add(dto);
		}
		return dtos;
	}

	@Override
	public List<EnrolmentDTO> findEnrolmentByClazz(Long claszzId) {
		List<Enrolment> enrols = enrolmentRepository.findAllByClazzId(claszzId);
		List<EnrolmentDTO> dtos = new ArrayList<>();
		for(Enrolment enrol: enrols){
			EnrolmentDTO dto = new EnrolmentDTO(enrol);
			dtos.add(dto);
		}
		return dtos;
	}

	@Override
	public List<EnrolmentDTO> findEnrolmentByClazzAndStudent(Long clazzId, Long studentId) {
		List<Enrolment> enrols = enrolmentRepository.findAllByClazzIdAndStudentId(clazzId, studentId);
		List<EnrolmentDTO> dtos = new ArrayList<>();
		for(Enrolment enrol: enrols){
			EnrolmentDTO dto = new EnrolmentDTO(enrol);
			dtos.add(dto);
		}
		return dtos;
	}

	@Override
	public EnrolmentDTO addEnrolment(Enrolment enrolment) {
		Enrolment enrol = enrolmentRepository.save(enrolment);
		EnrolmentDTO dto = new EnrolmentDTO(enrol);
		return dto;
	}

	@Override
	public long checkCount() {
		long count = enrolmentRepository.count();
		return count;
	}

}
