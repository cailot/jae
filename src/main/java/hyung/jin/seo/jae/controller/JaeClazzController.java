package hyung.jin.seo.jae.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hyung.jin.seo.jae.dto.ClazzDTO;
import hyung.jin.seo.jae.dto.CourseDTO;
import hyung.jin.seo.jae.model.Clazz;
import hyung.jin.seo.jae.model.Course;
import hyung.jin.seo.jae.model.Cycle;
import hyung.jin.seo.jae.service.ClazzService;
import hyung.jin.seo.jae.service.CycleService;
import hyung.jin.seo.jae.service.CourseService;
import hyung.jin.seo.jae.utils.JaeConstants;

@Controller
@RequestMapping("class")
public class JaeClazzController {

	@Autowired
	private ClazzService clazzService;

	@Autowired
	private CycleService cycleService;

	@Autowired
	private CourseService courseService;

	// search classes by grade & year
	@GetMapping("/search")
	@ResponseBody
	List<ClazzDTO> searchClasses(@RequestParam("grade") String grade) {
		int year = cycleService.academicYear();
		int week = cycleService.academicWeeks();
		List<ClazzDTO> dtos = clazzService.findClassesForGradeNCycle(grade, year);
		// if new academic year is going to start, display next year classes
		if(week > JaeConstants.ACADEMIC_START_COMMING_WEEKS) {
			// display next year classes
			List<ClazzDTO> nexts = clazzService.findClassesForGradeNCycle(grade, year+1);
			for(ClazzDTO next : nexts) {
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
		long count = clazzService.checkCount();
		return count;
	}

	// bring all classes in database
	@GetMapping("/list")
	public String listClasses(@RequestParam(value="listState", required=false) String state, @RequestParam(value="listBranch", required=false) String branch, @RequestParam(value="listGrade", required=false) String grade, @RequestParam(value="listYear", required=false) String year, @RequestParam(value="listActive", required=false) String active, Model model) {
        System.out.println(state+"\t"+branch+"\t"+grade+"\t"+year+"\t"+active+"\t");
		List<ClazzDTO> dtos = clazzService.listClasses(state, branch, grade, year, active);//clazzService.allClasses();
		model.addAttribute(JaeConstants.CLASS_LIST, dtos);
		return "classListPage";
	}

	// bring all courses based on grade
	@GetMapping("/coursesByGrade")
	@ResponseBody
	public List<CourseDTO> getCoursesByGrade(@RequestParam(value="grade", required=true) String grade) {
		int year = cycleService.academicYear();
		int week = cycleService.academicWeeks();
		List<CourseDTO> dtos = courseService.findByGrade(grade);
		// if new academic year is going to start, display next year classes
		if(week > JaeConstants.ACADEMIC_START_COMMING_WEEKS) {
			// display next year courses by increasing price
			//List<CourseDTO> nexts = dtos.stream().collect(Collectors.toList());
			for(CourseDTO next : nexts) {
				//CourseDTO next = dto;
				next.setPrice(next.getPrice() + JaeConstants.ACADEMIC_NEXT_YEAR_COURSE_PRICE_INCREASE);
				next.setDescription(next.getDescription() + JaeConstants.ACADEMIC_NEXT_YEAR_COURSE_SUFFIX);
				dtos.add(next);
			}
		}
		return dtos;
	}



	// get class by Id
	@GetMapping("/get/{id}")
	@ResponseBody
	public ClazzDTO getClass(@PathVariable("id") Long id) {
		Clazz clazz = clazzService.getClazz(id);
		ClazzDTO dto = new ClazzDTO(clazz);
		return dto;
	}
		
	// register new student
	@PostMapping("/register")
	@ResponseBody
	public ClazzDTO registerClass(@RequestBody ClazzDTO formData) {
		System.out.println(formData);
		// 1. create bare Class
		Clazz clazz = formData.convertToOnlyClass();
		// 2. get Course
		Course course = courseService.findById(formData.getCourseId());
		// 3. get Cycle
		Cycle cycle = cycleService.findCycleByDate(formData.getStartDate());
		// 4. assign Course & Cycle
		clazz.setCourse(course);
		clazz.setCycle(cycle);
		// 5. save Class
		ClazzDTO dto = clazzService.addClass(clazz);
		// 6. return dto;
		return dto;
	}


	// update existing student
	@PutMapping("/update")
	@ResponseBody
	public ClazzDTO updateClazz(@RequestBody ClazzDTO formData) {
		// 1. create bare Class
		Clazz clazz = formData.convertToOnlyClass();
		// 1. get Course
		Course course = courseService.findById(formData.getCourseId());		
		// 2. get Cycle
		Cycle cycle = cycleService.findCycleByDate(formData.getStartDate());
		// 3. assign Course & Cycle
		clazz.setCourse(course);
		clazz.setCycle(cycle);
		// 4. save Class
		ClazzDTO dto = clazzService.updateClazz(clazz);
		return dto;
	}
	


}
