package hyung.jin.seo.jae.service;

import java.util.List;

import hyung.jin.seo.jae.model.Course;
import hyung.jin.seo.jae.model.Student;

public interface CourseService {

	List<Course> allCourses();
	
	public Course getCourse(Long id);
	
    void addCourse(Course crs);
    
 	long checkCount();
    
	Course updateCourse(Course newCourse, Long id);
	
	void deleteCourse(Long id);
}
