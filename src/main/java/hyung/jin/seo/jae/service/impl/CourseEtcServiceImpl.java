package hyung.jin.seo.jae.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import hyung.jin.seo.jae.dto.CourseEtcDTO;
import hyung.jin.seo.jae.model.Course;
import hyung.jin.seo.jae.model.CourseEtc;
import hyung.jin.seo.jae.repository.CourseEtcRepository;
import hyung.jin.seo.jae.service.CourseEtcService;
import hyung.jin.seo.jae.specification.CourseEtcSpecification;
import hyung.jin.seo.jae.utils.JaeConstants;

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
	public List<CourseEtcDTO> forTT8() { // for TT8
		List<CourseEtc> courses = courseEtcRepository.findAll();
		List<CourseEtcDTO> dtos = new ArrayList<>();
		for(CourseEtc course: courses){
			CourseEtcDTO dto = new CourseEtcDTO(course);
			dtos.add(dto);
		}
		return dtos;
	}
	
	@Override
	public List<CourseEtcDTO> exceptTT8() { // not name starts with VSSE
		// use specification
		Specification<CourseEtc> spec = CourseEtcSpecification.nameNotStarts(JaeConstants.VSSE);
		List<CourseEtc> courses = courseEtcRepository.findAll(spec);
		List<CourseEtcDTO> dtos = new ArrayList<>();
		for(CourseEtc course: courses){
			CourseEtcDTO dto = new CourseEtcDTO(course);
			dtos.add(dto);
		}
		return dtos;
	}


}
