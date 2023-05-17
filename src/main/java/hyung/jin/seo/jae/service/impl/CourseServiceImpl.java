package hyung.jin.seo.jae.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hyung.jin.seo.jae.dto.CourseDTO;
import hyung.jin.seo.jae.model.Course;
import hyung.jin.seo.jae.repository.CourseRepository;
import hyung.jin.seo.jae.service.CourseService;

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
	public List<CourseDTO> allCourses() {
		List<Course> crs = courseRepository.findAll();
		List<CourseDTO> dtos = new ArrayList<>();
		for(Course course: crs){
			CourseDTO dto = new CourseDTO(course);
			dtos.add(dto);
		}
		return dtos;
	}

	@Override
	public List<CourseDTO> findByGrade(String grade) {
		List<Course> crs = courseRepository.findByGrade(grade);
		List<CourseDTO> dtos = new ArrayList<>();
		for(Course course: crs){
			CourseDTO dto = new CourseDTO(course);
			dtos.add(dto);
		}
		return dtos;
	}

	@Override
	public Course findById(String courseId) {
		Optional<Course> course = courseRepository.findById(Long.parseLong(courseId));
		if(course.isPresent()) {
			return course.get();
		}else {
			return null;
		}
	}	
}