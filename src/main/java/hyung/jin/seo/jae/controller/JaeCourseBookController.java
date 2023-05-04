package hyung.jin.seo.jae.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hyung.jin.seo.jae.dto.CourseBookDTO;
import hyung.jin.seo.jae.model.CourseBook;
import hyung.jin.seo.jae.service.CourseBookService;
import hyung.jin.seo.jae.utils.JaeUtils;

@Controller
@RequestMapping("courseBook")
public class JaeCourseBookController {

	private static final Logger LOG = LoggerFactory.getLogger(JaeCourseBookController.class);

	@Autowired
	private CourseBookService courseBookService;

	// search all course books
	@GetMapping("/list")
	@ResponseBody
	List<CourseBookDTO> listBooks() {
		List<CourseBook> cbs = courseBookService.allBooks();
		List<CourseBookDTO> dtos = new ArrayList<CourseBookDTO>();
		for (CourseBook cb : cbs) {
			CourseBookDTO dto = new CourseBookDTO(cb);
			if (StringUtils.isNotBlank(dto.getName())) // replace escape character single quote
			{
				String newName = dto.getName().replaceAll("\'", "&#39;");
				dto.setName(newName);
			}
			dtos.add(dto);
		}
		return dtos;
	}

	// search course books by year
	@GetMapping("/listYear")
	@ResponseBody
	List<CourseBookDTO> listYearBook(@RequestParam("year") String keyword) {
		List<CourseBook> cbs = courseBookService.availbeBooks(keyword);
		List<CourseBookDTO> dtos = new ArrayList<CourseBookDTO>();
		for (CourseBook cb : cbs) {
			CourseBookDTO dto = new CourseBookDTO(cb);
			if (StringUtils.isNotBlank(dto.getName())) // replace escape character single quote
			{
				String newName = dto.getName().replaceAll("\'", "&#39;");
				dto.setName(newName);
			}
			dtos.add(dto);
		}
		return dtos;
	}
	
	
	// search course books by grade
	@GetMapping("/listGrade")
	@ResponseBody
	List<CourseBookDTO> listGradeBook(@RequestParam("grade") String grade) {
		int year = JaeUtils.academicYear();
		List<CourseBook> cbs = courseBookService.availableGradeBooks(grade, Integer.toString(year));
		List<CourseBookDTO> dtos = new ArrayList<CourseBookDTO>();
		for (CourseBook cb : cbs) {
			CourseBookDTO dto = new CourseBookDTO(cb);
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
		long count = courseBookService.checkCount();
		return count;
	}
}
