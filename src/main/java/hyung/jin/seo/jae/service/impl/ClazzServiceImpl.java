package hyung.jin.seo.jae.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hyung.jin.seo.jae.dto.ClazzDTO;
import hyung.jin.seo.jae.model.Clazz;
import hyung.jin.seo.jae.repository.ClazzRepository;
import hyung.jin.seo.jae.repository.SubjectRepository;
import hyung.jin.seo.jae.service.ClazzService;

@Service
public class ClazzServiceImpl implements ClazzService {
	
	@Autowired
	private ClazzRepository classRepository;

	@Autowired
	private SubjectRepository subjectRepository;
	
	@Override
	public long checkCount() {
		long count = classRepository.count();
		return count;
	}

	@Override
	public List<ClazzDTO> allClasses() {
		List<Clazz> crs = classRepository.findAll();
		List<ClazzDTO> dtos = new ArrayList<>();
		for(Clazz claz : crs){
			ClazzDTO dto = new ClazzDTO(claz);
			dtos.add(dto);
		}
		return dtos;
	}

	@Override
	public List<ClazzDTO> findClassesForGradeNCycle(String grade, int year) {
		// 1. get classes
		List<ClazzDTO> dtos = classRepository.findClassForGradeNCycle(grade, year);
		// 2. get subjects
		List<String> subjects = subjectRepository.findSubjectNamesForGrade(grade);
		// 3. assign subjects to classes
		for(ClazzDTO clazz : dtos){
			for(String subject : subjects){
				clazz.addSubject(subject);
			}
		}
		// 4. return DTOs
		return dtos;	
	}

	@Override
	public ClazzDTO addClass(Clazz clazz) {
		Clazz cla = classRepository.save(clazz);
		ClazzDTO dto = new ClazzDTO(cla);
		return dto;
	}

	@Override
	public Clazz getClazz(Long id) {
		Clazz clazz = classRepository.findById(id).get();
		return clazz;	
	}
	
}