package hyung.jin.seo.jae.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import hyung.jin.seo.jae.model.Course;
import hyung.jin.seo.jae.model.Student;
import hyung.jin.seo.jae.model.StudentDTO;
import hyung.jin.seo.jae.service.CourseService;
import hyung.jin.seo.jae.service.StudentService;
import hyung.jin.seo.utils.JaeConstants;

@Controller
public class JaeController {

	private static final Logger LOG = LoggerFactory.getLogger(JaeController.class);

	@Autowired
	private StudentService studentService;

	@Autowired
	private CourseService courseService;

	@GetMapping("/test")
	public String student(HttpSession session) {
		return "testPage";
	}
	
	
	@GetMapping("/list")
	public String list(HttpSession session) {
		return "listPage";
	}

	@GetMapping("/setting")
	public String setting(HttpSession session) {
		return "settingPage";
	}
	
	
	@PostMapping("/associateCourse")
    @ResponseBody
    public StudentDTO updateCourses(@RequestParam long studentId, @RequestParam("courseId[]") long[] courseId) {
        System.out.println(studentId + Arrays.toString(courseId));
        // 1. get Student by Id
        Student std = studentService.getStudent((long)studentId);
        // 2. get Course Set in retrieved Student
        List courses = std.getCourses();
        // 3. make course info clear in Student
        courses.clear();
        if(courseId.length > 0) {
	        for(long cid : courseId) {
	        	// 4. get Course by Id
	        	Course crs = courseService.getCourse(cid);
	        	// 5. associate Student with Course
	        	crs.getStudents().add(std);
	        	// 6. associate Course into Student
	        	courses.add(crs);
	        }
        }
        // 6. update Student
        std = studentService.updateStudent(std, std.getId());
		StudentDTO dto = new StudentDTO(std);
		return dto;
    }
	
}
