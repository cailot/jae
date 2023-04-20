package hyung.jin.seo.jae.service;

import java.util.List;

import hyung.jin.seo.jae.model.CourseEtc;
import hyung.jin.seo.jae.model.Elearning;

public interface CourseEtcService {
	// list all etc
	List<CourseEtc> allEtc();
	
	// list etc not belong to grade
	List<CourseEtc> notGradeEtc(String grade);
	
	// get total number of etc
 	long checkCount();    
}
