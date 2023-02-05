package hyung.jin.seo.jae.service;

import java.time.LocalDate;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hyung.jin.seo.jae.model.Student;
import hyung.jin.seo.jae.repository.StudentRepository;

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
	public Student getStudent(Long id) {
		Student std = studentRepository.findById(id).get();
		return std;
	}

	@Override
	public void addStudent(Student std) {
		studentRepository.save(std);
	}

	@Override
	public long checkCount() {
		long count = studentRepository.count();
		return count;
	}

	@Override
	public Student updateStudent(Student newStudent, Long id) {
		// search by getId
        Student existing = studentRepository.findById(id).get();
        // Update info
        String newFirstName = StringUtils.defaultString(newStudent.getFirstName());
        if(StringUtils.isNotBlank(newFirstName)){
        	existing.setFirstName(newFirstName);
        }
        String newLastName = StringUtils.defaultString(newStudent.getLastName());
        if(StringUtils.isNotBlank(newLastName)){
        	existing.setLastName(newLastName);
        }
        String newGrade = StringUtils.defaultString(newStudent.getGrade());
        if(StringUtils.isNotBlank(newGrade)){
        	existing.setGrade(newGrade);
        }
        String newContactNo1 = StringUtils.defaultString(newStudent.getContactNo1());
        if(StringUtils.isNotBlank(newContactNo1)){
        	existing.setContactNo1(newContactNo1);
        }
        String newContactNo2 = StringUtils.defaultString(newStudent.getContactNo2());
        if(StringUtils.isNotBlank(newContactNo2)){
        	existing.setContactNo2(newContactNo2);
        }
        String newEmail = StringUtils.defaultString(newStudent.getEmail());
        if(StringUtils.isNotBlank(newEmail)){
        	existing.setEmail(newEmail);
        }
        String newAddress = StringUtils.defaultString(newStudent.getAddress());
        if(StringUtils.isNotBlank(newAddress)){
        	existing.setAddress(newAddress);
        }
        String newState = StringUtils.defaultString(newStudent.getState());
        if(StringUtils.isNotBlank(newState)){
        	existing.setState(newState);
        }
        String newBranch = StringUtils.defaultString(newStudent.getBranch());
        if(StringUtils.isNotBlank(newBranch)){
        	existing.setBranch(newBranch);
        }
        String newMemo = StringUtils.defaultString(newStudent.getMemo());
        if(StringUtils.isNotBlank(newMemo)){
        	existing.setMemo(newMemo);
        }
        
        // update the existing record
        Student updated = studentRepository.save(existing);
        return updated;
	}

	@Override
	public void dischargeStudent(Long id) {
		try{
		    //studentRepository.deleteById(id);
        	Student end = studentRepository.findById(id).get();
        	end.setEndDate(LocalDate.now());
        	studentRepository.save(end);
        }catch(org.springframework.dao.EmptyResultDataAccessException e){
            System.out.println("Nothing to delete");
        }
	}

	@Override
	public void deleteStudent(Long id) {
		try{
		    studentRepository.deleteById(id);
        }catch(org.springframework.dao.EmptyResultDataAccessException e){
            System.out.println("Nothing to delete");
        }
		
	}

}
