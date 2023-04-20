package hyung.jin.seo.jae.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hyung.jin.seo.jae.model.Course;
import hyung.jin.seo.jae.model.CourseFee;
import hyung.jin.seo.jae.repository.CourseFeeRepository;
import hyung.jin.seo.jae.repository.CourseRepository;

@Service
public class CourseServiceImpl implements CourseService {
	
	@Autowired
	private CourseRepository courseRepository;

	@Override
	public long checkCount() {
		long count = courseRepository.count();
		return count;
	}

	@Override
	public List<Course> allCourses() {
		List<Course> crs = courseRepository.findAll();
		return crs;
	}
	
}
