package hyung.jin.seo.jae.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;


import hyung.jin.seo.jae.model.Course;
import hyung.jin.seo.jae.service.CourseService;

import java.util.List;


@RestController
public class CourseController {

	@Autowired
	private CourseService courseService;
	
	private static final Logger LOG = LoggerFactory.getLogger(CourseController.class);
	
	@GetMapping("/courses")
	List<Course> allCourses() {
        List<Course> courses = courseService.allCourses();
        return courses;
	}
	
    @GetMapping("/course/{id}")
	Course getCourse(@PathVariable Long id) {
		Course course = courseService.getCourse(id);
        return course;
	}
	
    @PostMapping("/course")
	void addCourse(@RequestBody Course course) {
    	courseService.addCourse(course);
	}
    
    @GetMapping("/course/count")
	long checkCount() {
        long count = courseService.checkCount();
        return count;
	}
    
    
    @PutMapping("/course/{id}")
	Course updateCourse(@RequestBody Course newCourse, @PathVariable Long id) {
    	Course updated = courseService.updateCourse(newCourse, id);
    	return updated;
    }
    
    @DeleteMapping("/course/{id}")
	void deleteCourse(@PathVariable Long id) {
    	courseService.deleteCourse(id);
	}
    
    
}
