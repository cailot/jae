package hyung.jin.seo.jae.service;

import java.util.List;

import hyung.jin.seo.jae.model.Course;
import hyung.jin.seo.jae.model.Student;

public interface CourseService {
	// list all courses
	List<Course> allCourses();
	
	// list all available courses
	List<Course> availableCourses();
		
	// list courses belong to grade
	List<Course> gradeCourses(String grade);
	
	// list course not belong to grade
	List<Course> notGradeCourses(String grade);
	
	// retrieve course by Id
	public Course getCourse(Long id);
	
	// register course
    Course addCourse(Course crs);
    
    // get total number of courses
 	long checkCount();
    
 	// update course info by Id
	Course updateCourse(Course newCourse, Long id);
	
	// discharge course
	void dischargeCourse(Long id);
	
	// delete course
	void deleteCourse(Long id);
}
