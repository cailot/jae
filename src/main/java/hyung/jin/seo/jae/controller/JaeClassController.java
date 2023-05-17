package hyung.jin.seo.jae.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hyung.jin.seo.jae.dto.ClassDTO;
import hyung.jin.seo.jae.dto.CourseDTO;
import hyung.jin.seo.jae.model.Class;
import hyung.jin.seo.jae.model.Course;
import hyung.jin.seo.jae.model.Cycle;
import hyung.jin.seo.jae.service.ClassService;
import hyung.jin.seo.jae.service.CycleService;
import hyung.jin.seo.jae.service.CourseService;
import hyung.jin.seo.jae.utils.JaeConstants;

@Controller
@RequestMapping("class")
public class JaeClassController {

	@Autowired
	private ClassService classService;

	@Autowired
	private CycleService cycleService;

	@Autowired
	private CourseService courseService;

	// search classes by grade & year
	@GetMapping("/search")
	@ResponseBody
	List<ClassDTO> searchClasses(@RequestParam("grade") String grade) {
		int year = cycleService.academicYear();
		int week = cycleService.academicWeeks();
		List<ClassDTO> dtos = classService.findClassesForGradeNCycle(grade, year);
		// if new academic year is going to start, display next year classes
		if(week > JaeConstants.ACADEMIC_START_COMMING_WEEKS) {
			// display next year classes
			List<ClassDTO> nexts = classService.findClassesForGradeNCycle(grade, year+1);
			for(ClassDTO next : nexts) {
				String append = next.getName() + JaeConstants.ACADEMIC_NEXT_YEAR_COURSE_SUFFIX;
				next.setName(append);
				dtos.add(next);
			}
		}
		return dtos;
	}

	// check current academic year and week
	@GetMapping("/academy")
	@ResponseBody
	String[] getAcademicInfo() {
		int year = cycleService.academicYear();
		int week = cycleService.academicWeeks();
		return new String[] {String.valueOf(year), String.valueOf(week)};
	}

	// count records number in database
	@GetMapping("/count")
	@ResponseBody
	long coutEtc() {
		long count = classService.checkCount();
		return count;
	}

	// bring all classes in database
	@GetMapping("/list")
	public String listClasses(@RequestParam(value="listState", required=false) String state, @RequestParam(value="listBranch", required=false) String branch, @RequestParam(value="listGrade", required=false) String grade, @RequestParam(value="listYear", required=false) String year, @RequestParam(value="listActive", required=false) String active, Model model) {
        System.out.println(state+"\t"+branch+"\t"+grade+"\t"+year+"\t"+active+"\t");
		List<ClassDTO> dtos = classService.allClasses();
		model.addAttribute(JaeConstants.CLASS_LIST, dtos);
		return "classListPage";
	}

	// bring all courses based on grade
	@GetMapping("/coursesByGrade")
	@ResponseBody
	public List<CourseDTO> getCoursesByGrade(@RequestParam(value="grade", required=true) String grade) {
		List<CourseDTO> dtos = courseService.findByGrade(grade);
		return dtos;
	}

		
	// register new student
	@PostMapping("/register")
	@ResponseBody
	public ClassDTO registerClass(@RequestBody ClassDTO formData) {
		System.out.println(formData);
		// 1. create bare Class
		Class clazz = formData.convertToOnlyClass();
		// 2. get Course
		Course course = courseService.findById(formData.getCourseId());
		// 3. get Cycle
		Cycle cycle = cycleService.findCycleByDate(formData.getStartDate());
		// 4. assign Course & Cycle
		clazz.setCourse(course);
		clazz.setCycle(cycle);
		// 5. save Class
		ClassDTO dto = classService.addClass(clazz);
		// 6. return dto;
		return dto;
	}


}
