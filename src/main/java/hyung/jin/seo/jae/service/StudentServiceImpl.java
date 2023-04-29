package hyung.jin.seo.jae.service;

import java.text.ParseException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.persistence.EntityNotFoundException;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import hyung.jin.seo.jae.model.Student;
import hyung.jin.seo.jae.repository.StudentRepository;
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
			LocalDate lastDate = JaeUtils.lastAcademicDate(year);
			spec = spec.and(StudentSpecification.startDateLessThanOrEqualTo(lastDate) );
		}
//		if(StringUtils.isNotBlank(start) && JaeUtils.isValidDateFormat(start)) {
//			
//			Date date = null;
//			try {
//				date = JaeUtils.dateFormat.parse(start);
//				LocalDate startDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
//				spec = spec.and(StudentSpecification.startDateAfter(startDate));
//			} catch (ParseException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		}

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
		//Student std = studentRepository.findByIdAndEndDateIsNull(id);// .get();
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
		if (StringUtils.isNotBlank(newFirstName)) {
			existing.setFirstName(newFirstName);
		}
		String newLastName = StringUtils.defaultString(newStudent.getLastName());
		if (StringUtils.isNotBlank(newLastName)) {
			existing.setLastName(newLastName);
		}
		String newGrade = StringUtils.defaultString(newStudent.getGrade());
		if (StringUtils.isNotBlank(newGrade)) {
			existing.setGrade(newGrade);
		}
		String newContactNo1 = StringUtils.defaultString(newStudent.getContactNo1());
		if (StringUtils.isNotBlank(newContactNo1)) {
			existing.setContactNo1(newContactNo1);
		}
		String newContactNo2 = StringUtils.defaultString(newStudent.getContactNo2());
		if (StringUtils.isNotBlank(newContactNo2)) {
			existing.setContactNo2(newContactNo2);
		}
		String newEmail = StringUtils.defaultString(newStudent.getEmail());
		if (StringUtils.isNotBlank(newEmail)) {
			existing.setEmail(newEmail);
		}
		String newAddress = StringUtils.defaultString(newStudent.getAddress());
		if (StringUtils.isNotBlank(newAddress)) {
			existing.setAddress(newAddress);
		}
		String newState = StringUtils.defaultString(newStudent.getState());
		if (StringUtils.isNotBlank(newState)) {
			existing.setState(newState);
		}
		String newBranch = StringUtils.defaultString(newStudent.getBranch());
		if (StringUtils.isNotBlank(newBranch)) {
			existing.setBranch(newBranch);
		}
		String newMemo = StringUtils.defaultString(newStudent.getMemo());
		if (StringUtils.isNotBlank(newMemo)) {
			existing.setMemo(newMemo);
		}
		if (newStudent.getEnrolmentDate() != null) {
			LocalDate newEnrolDate = newStudent.getEnrolmentDate();
			existing.setEnrolmentDate(newEnrolDate);
		}
		
		// update course
		if((newStudent.getElearnings()!=null) && (newStudent.getElearnings().size() > 0)) {
			existing.setElearnings(newStudent.getElearnings());
		}

		// update the existing record
		Student updated = studentRepository.save(existing);
		return updated;
	}

	@Override
	public void dischargeStudent(Long id) {
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
