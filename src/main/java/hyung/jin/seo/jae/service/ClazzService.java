package hyung.jin.seo.jae.service;

import java.util.List;

import hyung.jin.seo.jae.dto.ClazzDTO;
import hyung.jin.seo.jae.model.Clazz;

public interface ClazzService {

	// bring clazz by id
	Clazz getClazz(Long id);

	// list all class
	List<ClazzDTO> allClasses();

	// list all class for grade & year
	List<ClazzDTO> findClassesForGradeNCycle(String grade, int year);
	
	// return total count
	long checkCount();

	// add class
	ClazzDTO addClass(Clazz clazz);
}