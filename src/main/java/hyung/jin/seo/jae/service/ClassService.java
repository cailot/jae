package hyung.jin.seo.jae.service;

import java.util.List;

import hyung.jin.seo.jae.dto.ClassDTO;

public interface ClassService {
	// list all class
	List<ClassDTO> allClasses();

	// list all class for grade & year
	List<ClassDTO> findClassesForGradeNCycle(String grade, int year);
	
	// return total count
	long checkCount();
}