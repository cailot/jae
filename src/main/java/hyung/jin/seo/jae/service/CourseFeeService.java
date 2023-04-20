package hyung.jin.seo.jae.service;

import java.util.List;

import hyung.jin.seo.jae.model.CourseFee;
import hyung.jin.seo.jae.model.Elearning;

public interface CourseFeeService {
	// list all Course Fee
	List<CourseFee> allFees();
	
	// list available fees based on year
	List<CourseFee> availbeFees(String year);

	// list available fees based on grade & year
	List<CourseFee> availableGradeFees(String grade, String year);
	
	// return total count
	long checkCount();
}
