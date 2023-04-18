package hyung.jin.seo.jae.service;

import java.util.List;

import hyung.jin.seo.jae.model.Elearning;

public interface ElearningService {
	// list all elearnings
	List<Elearning> allElearnings();
	
	// list all available elearnings
	List<Elearning> availableElearnings();
		
	// list elearnings belong to grade
	List<Elearning> gradeElearnings(String grade);
	
	// list elearning not belong to grade
	List<Elearning> notGradeElearnings(String grade);
	
	// retrieve elearning by Id
	public Elearning getElearning(Long id);
	
	// register elearning
	Elearning addElearning(Elearning crs);
    
    // get total number of elearnings
 	long checkCount();
    
 	// update elearning info by Id
 	Elearning updateElearning(Elearning newCourse, Long id);
	
	// discharge elearning
	void dischargeElearning(Long id);
	
	// delete elearning
	void deleteElearning(Long id);
}