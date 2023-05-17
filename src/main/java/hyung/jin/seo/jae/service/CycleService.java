package hyung.jin.seo.jae.service;

import java.util.List;

import hyung.jin.seo.jae.dto.CycleDTO;
import hyung.jin.seo.jae.model.Cycle;

public interface CycleService {
	
	// list all Cycles
	List<CycleDTO> allCycles();
	
	// get total number of cycle
 	long checkCount();

	// get current academic year
	int academicYear();

	// get academic year by date
	int academicYear(String date);

	// get current academic week
	int academicWeeks();

	// get academic week by date
	int academicWeeks(String date);

	// get Cycle by Id
    Cycle findById(String cycleId);

	// get Id by date
	Long findIdByDate(String date);

	// get Cycle by date
	Cycle findCycleByDate(String date);
}
