package hyung.jin.seo.jae.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import hyung.jin.seo.jae.model.CourseEtc;
import hyung.jin.seo.jae.repository.CourseEtcRepository;
import hyung.jin.seo.jae.specification.CourseEtcSpecification;
import hyung.jin.seo.utils.JaeConstants;

@Service
public class CourseEtcServiceImpl implements CourseEtcService {
	
	@Autowired
	private CourseEtcRepository courseEtcRepository;

	@Override
	public long checkCount() {
		long count = courseEtcRepository.count();
		return count;
	}

	@Override
	public List<CourseEtc> allEtc() {
		List<CourseEtc> courses = courseEtcRepository.findAll();
		return courses;
	}
	
	@Override
	public List<CourseEtc> notNameEtc() {
		List<CourseEtc> courses = null;
		Specification<CourseEtc> spec = Specification.where(null);
		spec = spec.and(CourseEtcSpecification.nameNotStarts(JaeConstants.VSSE));
		courses = courseEtcRepository.findAll(spec);
		return courses;
	}


}
