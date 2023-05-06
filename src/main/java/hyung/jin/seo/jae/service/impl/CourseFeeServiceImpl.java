package hyung.jin.seo.jae.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hyung.jin.seo.jae.model.CourseFee;
import hyung.jin.seo.jae.repository.CourseFeeRepository;
import hyung.jin.seo.jae.service.CourseFeeService;

@Service
public class CourseFeeServiceImpl implements CourseFeeService {
	
	@Autowired
	private CourseFeeRepository courseFeeRepository;
	
	@Override
	public List<CourseFee> allFees() {
		List<CourseFee> fees = courseFeeRepository.findAll();
		return fees;
	}

	@Override
	public List<CourseFee> availbeFees(String year) {
		List<CourseFee> fees = courseFeeRepository.findByYear(year);
		return fees;	
	}

	@Override
	public List<CourseFee> availableGradeFees(String grade, String year) {
		List<CourseFee> fees = courseFeeRepository.findByGradeAndYear(grade, year);
		return fees;	
	}

	@Override
	public long checkCount() {
		long count = courseFeeRepository.count();
		return count;
	}
	
}
