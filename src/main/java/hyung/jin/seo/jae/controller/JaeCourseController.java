package hyung.jin.seo.jae.controller;

import java.io.IOException;
import java.util.ArrayList;
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
import hyung.jin.seo.jae.model.CourseDTO;
import hyung.jin.seo.jae.model.Student;
import hyung.jin.seo.jae.model.StudentDTO;
import hyung.jin.seo.jae.service.CourseService;
import hyung.jin.seo.jae.service.StudentService;
import hyung.jin.seo.utils.JaeConstants;

@Controller
@RequestMapping("course")
public class JaeCourseController {

	private static final Logger LOG = LoggerFactory.getLogger(JaeCourseController.class);

	@Autowired
	private CourseService courseService;

	
	// register new student
	@PostMapping("/register")
	@ResponseBody
	public CourseDTO registerStudent(@RequestBody CourseDTO formData) {
		Course crs = formData.convertToCourse();
		crs = courseService.addCourse(crs);
		CourseDTO dto = new CourseDTO(crs);
		return dto;
	}

	// search course with grade
	@GetMapping("/gradeCourse")
	@ResponseBody
	List<CourseDTO> listCourses(@RequestParam("grade") String keyword) {
		List<Course> crss = courseService.gradeCourses(keyword);
		List<CourseDTO> dtos = new ArrayList<CourseDTO>();
		for (Course crs : crss) {
			CourseDTO dto = new CourseDTO(crs);
			if (StringUtils.isNotBlank(dto.getName())) // replace escape character single quote
			{
				String newName = dto.getName().replaceAll("\'", "&#39;");
				dto.setName(newName);
			}
			dtos.add(dto);
		}
		return dtos;
	}

	// search course with grade
	@GetMapping("/grade")
	@ResponseBody
	List<CourseDTO> gradeCourses(@RequestParam("grade") String keyword) {
		List<Course> crss = courseService.gradeCourses(keyword);
		List<CourseDTO> dtos = new ArrayList<CourseDTO>();
		for (Course crs : crss) {
			CourseDTO dto = new CourseDTO(crs);
			if (StringUtils.isNotBlank(dto.getName())) // replace escape character single quote
			{
				String newName = dto.getName().replaceAll("\'", "&#39;");
				dto.setName(newName);
			}
			dtos.add(dto);
		}
		return dtos;
	}

	
	// search course with grade
	@GetMapping("/no_grade")
	@ResponseBody
	List<CourseDTO> noGradeCourses(@RequestParam("grade") String keyword) {
		List<Course> crss = courseService.notGradeCourses(keyword);
		List<CourseDTO> dtos = new ArrayList<CourseDTO>();
		for (Course crs : crss) {
			CourseDTO dto = new CourseDTO(crs);
			if (StringUtils.isNotBlank(dto.getName())) // replace escape character single quote
			{
				String newName = dto.getName().replaceAll("\'", "&#39;");
				dto.setName(newName);
			}
			dtos.add(dto);
		}
		return dtos;
	}

	
	// update existing course
	@PutMapping("/update")
	@ResponseBody
	public CourseDTO updateStudent(@RequestBody CourseDTO formData) {
		Course crs = formData.convertToCourse();
		crs = courseService.updateCourse(crs, crs.getId());
		CourseDTO dto = new CourseDTO(crs);
		return dto;
	}

	// de-activate course by Id
	@PutMapping("/inactivate/{id}")
	@ResponseBody
	public void inactivateCourse(@PathVariable Long id) {
		courseService.dischargeCourse(id);
	}
	
	
	// list all courses
	@GetMapping("/list")
	@ResponseBody
	List<CourseDTO> allCourses() {
		List<Course> crss = courseService.availableCourses();
		List<CourseDTO> dtos = new ArrayList<CourseDTO>();
		for(Course crs : crss) {
			CourseDTO dto = new CourseDTO(crs);
			if (StringUtils.isNotBlank(dto.getName())) // replace escape character single quote
			{
				String newName = dto.getName().replaceAll("\'", "&#39;");
				dto.setName(newName);
			}
			dtos.add(dto);
		}
        return dtos;
	}
	
	// list available courses
	@GetMapping("/available")
	@ResponseBody
	List<CourseDTO> availableCourses() {
		List<Course> crss = courseService.availableCourses();
		List<CourseDTO> dtos = new ArrayList<CourseDTO>();
		for(Course crs : crss) {
			CourseDTO dto = new CourseDTO(crs);
			if (StringUtils.isNotBlank(dto.getName())) // replace escape character single quote
			{
				String newName = dto.getName().replaceAll("\'", "&#39;");
				dto.setName(newName);
			}
			dtos.add(dto);
		}
        return dtos;
	}
}
