package hyung.jin.seo.jae.service;

import java.util.List;

import hyung.jin.seo.jae.model.Course;

public interface CourseService {
	// list all Course
	List<Course> allCourses();
	
	// return total count
	long checkCount();
}
