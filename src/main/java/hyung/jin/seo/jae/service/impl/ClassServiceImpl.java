package hyung.jin.seo.jae.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hyung.jin.seo.jae.dto.ClassDTO;
import hyung.jin.seo.jae.model.Class;
import hyung.jin.seo.jae.repository.ClassRepository;
import hyung.jin.seo.jae.repository.SubjectRepository;
import hyung.jin.seo.jae.service.ClassService;

@Service
public class ClassServiceImpl implements ClassService {
	
	@Autowired
	private ClassRepository classRepository;

	@Autowired
	private SubjectRepository subjectRepository;
	
	@Override
	public long checkCount() {
		long count = classRepository.count();
		return count;
	}

	@Override
	public List<ClassDTO> allClasses() {
		List<Class> crs = classRepository.findAll();
		List<ClassDTO> dtos = new ArrayList<>();
		for(Class claz : crs){
			ClassDTO dto = new ClassDTO(claz);
			dtos.add(dto);
		}
		return dtos;
	}

	@Override
	public List<ClassDTO> findClassesForGradeNCycle(String grade, int year) {
		// 1. get classes
		List<ClassDTO> dtos = classRepository.findClassForGradeNCycle(grade, year);
		// 2. get subjects
		List<String> subjects = subjectRepository.findSubjectNamesForGrade(grade);
		// 3. assign subjects to classes
		for(ClassDTO clazz : dtos){
			for(String subject : subjects){
				clazz.addSubject(subject);
			}
		}
		// 4. return DTOs
		return dtos;	
	}
	
}