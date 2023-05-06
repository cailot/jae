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

import hyung.jin.seo.jae.dto.BookDTO;
import hyung.jin.seo.jae.model.Book;
import hyung.jin.seo.jae.service.BookService;
import hyung.jin.seo.jae.utils.JaeUtils;

@Controller
@RequestMapping("courseBook")
public class JaeBookController {

	private static final Logger LOG = LoggerFactory.getLogger(JaeBookController.class);

	@Autowired
	private BookService bookService;

	// search all course books
	@GetMapping("/list")
	@ResponseBody
	List<BookDTO> listBooks() {
		List<Book> cbs = bookService.allBooks();
		List<BookDTO> dtos = new ArrayList<BookDTO>();
		for (Book cb : cbs) {
			BookDTO dto = new BookDTO(cb);
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
	List<BookDTO> listYearBook(@RequestParam("year") String keyword) {
		List<Book> cbs = bookService.availbeBooks(keyword);
		List<BookDTO> dtos = new ArrayList<BookDTO>();
		for (Book cb : cbs) {
			BookDTO dto = new BookDTO(cb);
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
	List<BookDTO> listGradeBook(@RequestParam("grade") String grade) {
		int year = JaeUtils.academicYear();
		List<Book> cbs = bookService.availableGradeBooks(grade, Integer.toString(year));
		List<BookDTO> dtos = new ArrayList<BookDTO>();
		for (Book cb : cbs) {
			BookDTO dto = new BookDTO(cb);
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
		long count = bookService.checkCount();
		return count;
	}
}
