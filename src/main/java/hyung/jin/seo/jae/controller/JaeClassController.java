package hyung.jin.seo.jae.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hyung.jin.seo.jae.dto.ClassDTO;
import hyung.jin.seo.jae.service.ClassService;

@Controller
@RequestMapping("class")
public class JaeClassController {

	private static final Logger LOG = LoggerFactory.getLogger(JaeClassController.class);

	@Autowired
	private ClassService classService;

	// search classes by grade & year
	@GetMapping("/search")
	@ResponseBody
	List<ClassDTO> searchClasses(@RequestParam("grade") String grade, @RequestParam("year") String year) {
		List<ClassDTO> dtos = classService.findClassesForGradeNCycle(grade, year);
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
