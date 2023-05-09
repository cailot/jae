package hyung.jin.seo.jae.service;

import java.util.List;

import hyung.jin.seo.jae.dto.CourseEtcDTO;

public interface CourseEtcService {
	// list all etc for TT8
	List<CourseEtcDTO> forTT8();
	
	// get total number of etc
 	long checkCount();

 	// list etc not belong to TT8 which is general purpose
	List<CourseEtcDTO> exceptTT8();    
}
