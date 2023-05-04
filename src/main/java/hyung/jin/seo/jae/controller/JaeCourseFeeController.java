package hyung.jin.seo.jae.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hyung.jin.seo.jae.dto.CourseFeeDTO;
import hyung.jin.seo.jae.dto.ElearningDTO;
import hyung.jin.seo.jae.model.CourseFee;
import hyung.jin.seo.jae.model.Elearning;
import hyung.jin.seo.jae.service.CourseFeeService;
import hyung.jin.seo.jae.service.ElearningService;
import hyung.jin.seo.jae.utils.JaeConstants;
import hyung.jin.seo.jae.utils.JaeUtils;

@Controller
@RequestMapping("courseFee")
public class JaeCourseFeeController {

	private static final Logger LOG = LoggerFactory.getLogger(JaeCourseFeeController.class);

	@Autowired
	private CourseFeeService courseFeeService;

	// search all course fees
	@GetMapping("/list")
	@ResponseBody
	List<CourseFeeDTO> listFees() {
		List<CourseFee> cfs = courseFeeService.allFees();
		List<CourseFeeDTO> dtos = new ArrayList<CourseFeeDTO>();
		for (CourseFee cf : cfs) {
			CourseFeeDTO dto = new CourseFeeDTO(cf);
			if (StringUtils.isNotBlank(dto.getName())) // replace escape character single quote
			{
				String newName = dto.getName().replaceAll("\'", "&#39;");
				dto.setName(newName);
			}
			dtos.add(dto);
		}
		return dtos;
	}

	// search course fees by year
	@GetMapping("/listYear")
	@ResponseBody
	List<CourseFeeDTO> listYearFee(@RequestParam("year") String keyword) {
		List<CourseFee> cfs = courseFeeService.availbeFees(keyword);
		List<CourseFeeDTO> dtos = new ArrayList<CourseFeeDTO>();
		for (CourseFee cf : cfs) {
			CourseFeeDTO dto = new CourseFeeDTO(cf);
			if (StringUtils.isNotBlank(dto.getName())) // replace escape character single quote
			{
				String newName = dto.getName().replaceAll("\'", "&#39;");
				dto.setName(newName);
			}
			dtos.add(dto);
		}
		return dtos;
	}
	
	
	// search course fees by grade
	@GetMapping("/listGrade")
	@ResponseBody
	List<CourseFeeDTO> listGradeFee(@RequestParam("grade") String grade) {
		int year = JaeUtils.academicYear();
		int academicWeeks = 0;
		try {
			academicWeeks = JaeUtils.academicWeeks();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<CourseFee> cfs = courseFeeService.availableGradeFees(grade, Integer.toString(year));
		List<CourseFeeDTO> dtos = new ArrayList<CourseFeeDTO>();
		for (CourseFee cf : cfs) {
			CourseFeeDTO dto = new CourseFeeDTO(cf);
			if (StringUtils.isNotBlank(dto.getName())) // replace escape character single quote
			{
				String newName = dto.getName().replaceAll("\'", "&#39;");
				dto.setName(newName);
			}
			dtos.add(dto);
		}
		if(academicWeeks >= JaeConstants.ACADEMIC_START_COMMING_WEEKS) { // display more with next academic year courses
			List<CourseFee> cfNext = courseFeeService.availableGradeFees(grade, Integer.toString(year+1));
			//List<CourseFeeDTO> dtosNext = new ArrayList<CourseFeeDTO>();
			for (CourseFee next : cfNext) {
				CourseFeeDTO dtoNext = new CourseFeeDTO(next);
				if (StringUtils.isNotBlank(dtoNext.getName())) // replace escape character single quote
				{
					String newName = dtoNext.getName().replaceAll("\'", "&#39;");
					dtoNext.setName(newName + JaeConstants.ACADEMIC_NEXT_YEAR_COURSE_SUFFIX);
				}
				dtos.add(dtoNext);
			}	
		}
		return dtos;
	}

	// search course fees by grade & year
	@GetMapping("/listGradeYear")
	@ResponseBody
	List<CourseFeeDTO> listGradeYearFee(@RequestParam("grade") String grade, @RequestParam("year") String year) {
		List<CourseFee> cfs = courseFeeService.availableGradeFees(grade, year);
		List<CourseFeeDTO> dtos = new ArrayList<CourseFeeDTO>();
		for (CourseFee cf : cfs) {
			CourseFeeDTO dto = new CourseFeeDTO(cf);
			if (StringUtils.isNotBlank(dto.getName())) // replace escape character single quote
			{
				String newName = dto.getName().replaceAll("\'", "&#39;");
				dto.setName(newName);
			}
			dtos.add(dto);
		}
		return dtos;
	}

	// count records number in database
	@GetMapping("/count")
	@ResponseBody
	long coutFees() {
		long count = courseFeeService.checkCount();
		return count;
	}
}
