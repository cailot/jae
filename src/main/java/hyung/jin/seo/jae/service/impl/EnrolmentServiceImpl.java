package hyung.jin.seo.jae.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityNotFoundException;

import org.apache.commons.lang3.StringUtils;
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
		// List<Enrolment> enrols = enrolmentRepository.findAllByStudentId(studentId);
		// List<EnrolmentDTO> dtos = new ArrayList<>();
		// for(Enrolment enrol: enrols){
		// 	EnrolmentDTO dto = new EnrolmentDTO(enrol);
		// 	dtos.add(dto);
		// }
		List<EnrolmentDTO> dtos = enrolmentRepository.findEnrolmentByStudentId(studentId);
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

	@Override
	public List<Long> findClazzIdByStudentId(Long studentId) {
		List<Long> clazzIds = enrolmentRepository.findClazzIdByStudentId(studentId);
		return clazzIds;
	}

	@Override
	public List<Long> findEnrolmentIdByStudentId(Long studentId) {
		List<Long> enrolmentIds = enrolmentRepository.findEnrolmentIdByStudentId(studentId);
		return enrolmentIds;
	}

	@Override
	public Enrolment getEnrolment(Long id) {
		Enrolment enrol = enrolmentRepository.findById(id).get();
		return enrol;
	}

	@Override
	public Enrolment updateEnrolment(Enrolment enrolment, Long id) {
		// search by getId
		Enrolment existing = enrolmentRepository.findById(id).orElseThrow(() -> new EntityNotFoundException("Enrolment not found"));
		// Update info
		// StartWeek
		if(enrolment.getStartWeek()!=existing.getStartWeek()){
			existing.setStartWeek(enrolment.getStartWeek());
		}
		// EndWeek
		if(enrolment.getEndWeek()!=existing.getEndWeek()){
			existing.setEndWeek(enrolment.getEndWeek());
		}
		// cancelled
		if(enrolment.isCancelled()!=existing.isCancelled()){
			existing.setCancelled(enrolment.isCancelled());
		}
		// cancellationReason
		if(!StringUtils.equalsIgnoreCase(StringUtils.defaultString(enrolment.getCancellationReason()), StringUtils.defaultString(existing.getCancellationReason()))){
			existing.setCancellationReason(StringUtils.defaultString(enrolment.getCancellationReason()));
		}
		// update the existing record
		Enrolment updated = enrolmentRepository.save(existing);
		return updated;
	}

	@Override
	public void deleteEnrolment(Long id) {
		enrolmentRepository.deleteById(id);
	}
}
