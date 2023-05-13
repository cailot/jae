package hyung.jin.seo.jae.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hyung.jin.seo.jae.dto.ClassDTO;
import hyung.jin.seo.jae.service.ClassService;
import hyung.jin.seo.jae.service.CycleService;
import hyung.jin.seo.jae.utils.JaeConstants;

@Controller
@RequestMapping("class")
public class JaeClassController {

	@Autowired
	private ClassService classService;

	@Autowired
	private CycleService cycleService;

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
				String append = next.getDescription() + JaeConstants.ACADEMIC_NEXT_YEAR_COURSE_SUFFIX;
				next.setDescription(append);
				dtos.add(next);
			}
		}
		return dtos;
	}

	// count records number in database
	@GetMapping("/count")
	@ResponseBody
	long coutEtc() {
		long count = classService.checkCount();
		return count;
	}
}
