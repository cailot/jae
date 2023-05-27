package hyung.jin.seo.jae.service.impl;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import javax.persistence.EntityNotFoundException;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import hyung.jin.seo.jae.model.Student;
import hyung.jin.seo.jae.repository.StudentRepository;
import hyung.jin.seo.jae.service.StudentService;
import hyung.jin.seo.jae.specification.StudentSpecification;
import hyung.jin.seo.jae.utils.JaeConstants;
import hyung.jin.seo.jae.utils.JaeUtils;

@Service
public class StudentServiceImpl implements StudentService {

	@Autowired
	private StudentRepository studentRepository;

	@Override
	public List<Student> allStudents() {
		List<Student> students = studentRepository.findAll();
		return students;
	}
	
	@Override
	public List<Student> currentStudents() {
		List<Student> students = studentRepository.findAllByEndDateIsNull();
		return students;
	}

	@Override
	public List<Student> stoppedStudents() {
		List<Student> students = studentRepository.findAllByEndDateIsNotNull();
		return students;
	}



	@Override
	public List<Student> listStudents(String state, String branch, String grade, String year, String active) {
		List<Student> students = null;// studentRepository.findAll();

		Specification<Student> spec = Specification.where(null);
		
		if((StringUtils.isNotBlank(state))&&(!StringUtils.equals(state, JaeConstants.ALL))) {
			spec = spec.and(StudentSpecification.stateEquals(state));
		}
		if(StringUtils.isNotBlank(branch)&&(!StringUtils.equals(branch, JaeConstants.ALL))) {
			spec = spec.and(StudentSpecification.branchEquals(branch));
		}
		if(StringUtils.isNotBlank(grade)&&(!StringUtils.equals(grade, JaeConstants.ALL))) {
			spec = spec.and(StudentSpecification.gradeEquals(grade));
		}
		if(StringUtils.isNotBlank(year)&&(!StringUtils.equals(year, JaeConstants.ALL))) {
			// LocalDate lastDate = JaeUtils.lastAcademicDate(year);
			// spec = spec.and(StudentSpecification.startDateLessThanOrEqualTo(lastDate) );
		}

		switch ((active==null) ? JaeConstants.ALL : active) {

		case JaeConstants.CURRENT:
			spec = spec.and(StudentSpecification.hasNullVaule("endDate"));
			students = studentRepository.findAll(spec);
			break;

		case JaeConstants.STOPPED:
			spec = spec.and(StudentSpecification.hasNotNullVaule("endDate"));
			students = studentRepository.findAll(spec);
			break;

		case JaeConstants.ALL:
			students = studentRepository.findAll(spec);

		}
		return students;
	}
	
	@Override
	public List<Student> searchStudents(String keyword) {
		List<Student> students = null;
		Specification<Student> spec = Specification.where(null);
		
		if(StringUtils.isNumericSpace(keyword)) {
			spec = spec.and(StudentSpecification.idEquals(keyword));
		}else {
			// firstName or lastName search
			spec = spec.and(StudentSpecification.nameContains(keyword));
		}
//		spec = spec.and(StudentSpecification.hasNullVaule("endDate")); // among current students
		students = studentRepository.findAll(spec);
		return students;
	}

	@Override
	public Student getStudent(Long id) {
		Student std = studentRepository.findById(id).get();	
		return std;
	}

	@Override
	public Student addStudent(Student std) {
		Student add = studentRepository.save(std);
		return add;
	}

	@Override
	public long checkCount() {
		long count = studentRepository.countByEndDateIsNull();
		return count;
	}

	@Override
	//@Transactional
	public Student updateStudent(Student newStudent, Long id) {
		// search by getId
		Student existing = studentRepository.findById(id).orElseThrow(() -> new EntityNotFoundException("Student not found"));
		// Update info
		String newFirstName = StringUtils.defaultString(newStudent.getFirstName());
		existing.setFirstName(newFirstName);
		String newLastName = StringUtils.defaultString(newStudent.getLastName());
		existing.setLastName(newLastName);
		String newGrade = StringUtils.defaultString(newStudent.getGrade());
		existing.setGrade(newGrade);
		String newContactNo1 = StringUtils.defaultString(newStudent.getContactNo1());
		existing.setContactNo1(newContactNo1);
		String newContactNo2 = StringUtils.defaultString(newStudent.getContactNo2());
		existing.setContactNo2(newContactNo2);
		String newEmail1 = StringUtils.defaultString(newStudent.getEmail1());
		existing.setEmail1(newEmail1);
		String newEmail2 = StringUtils.defaultString(newStudent.getEmail2());
		existing.setEmail2(newEmail2);
		String newRelation1 = StringUtils.defaultString(newStudent.getRelation1());
		existing.setRelation1(newRelation1);
		String newRelation2 = StringUtils.defaultString(newStudent.getRelation2());
		existing.setRelation2(newRelation2);
		String newAddress = StringUtils.defaultString(newStudent.getAddress());
		existing.setAddress(newAddress);
		String newState = StringUtils.defaultString(newStudent.getState());
		existing.setState(newState);
		String newBranch = StringUtils.defaultString(newStudent.getBranch());
		existing.setBranch(newBranch);
		LocalDate newRegisterDate = newStudent.getRegisterDate();
		existing.setRegisterDate(newRegisterDate);
		String newMemo = StringUtils.defaultString(newStudent.getMemo());
		existing.setMemo(newMemo);
		// update the existing record
		Student updated = studentRepository.save(existing);
		return updated;
	}

	@Override
	@Transactional
	public Student activateStudent(Long id) {
		Student student = null;
		try {
			// studentRepository.deleteById(id);
			Optional<Student> end = studentRepository.findById(id);
			if(end.isPresent()){
				Student std = end.get();
				std.setEndDate(null);
				student = studentRepository.save(std);
			}
			return student;
		} catch (org.springframework.dao.EmptyResultDataAccessException e) {
			System.out.println("Nothing to activate");
		}
		return student;
	}
	
	@Override
	public void deactivateStudent(Long id) {
		try {
			// studentRepository.deleteById(id);
			Optional<Student> end = studentRepository.findById(id);
			if(!end.isPresent()) return; // if not found, terminate.
			Student std = end.get();
			std.setEndDate(LocalDate.now());
			studentRepository.save(std);
		} catch (org.springframework.dao.EmptyResultDataAccessException e) {
			System.out.println("Nothing to discharge");
		}
	}

	@Override
	public void deleteStudent(Long id) {
		try {
			studentRepository.deleteById(id);
		} catch (org.springframework.dao.EmptyResultDataAccessException e) {
			System.out.println("Nothing to delete");
		}

	}

	

}
