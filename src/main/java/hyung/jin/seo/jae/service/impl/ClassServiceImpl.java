package hyung.jin.seo.jae.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hyung.jin.seo.jae.dto.ClassDTO;
import hyung.jin.seo.jae.model.Course;
import hyung.jin.seo.jae.model.Class;
import hyung.jin.seo.jae.repository.ClassRepository;
import hyung.jin.seo.jae.repository.CourseRepository;
import hyung.jin.seo.jae.service.ClassService;
import hyung.jin.seo.jae.service.CourseService;

@Service
public class ClassServiceImpl implements ClassService {
	
	@Autowired
	private ClassRepository classRepository;

	@Override
	public long checkCount() {
		long count = classRepository.count();
		return count;
	}

	@Override
	public List<ClassDTO> allClasses() {
		List<Class> crs = null;//classRepository.findAll();
		return null;
	}

	@Override
	public List<ClassDTO> findClassesForGradeNCycle(String grade, String year) {
		List<ClassDTO> dtos = classRepository.findClassForGradeNCycle(grade, Integer.parseInt(year));
		return dtos;
	}
	
}