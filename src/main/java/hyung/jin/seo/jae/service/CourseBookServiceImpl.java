package hyung.jin.seo.jae.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hyung.jin.seo.jae.model.CourseBook;
import hyung.jin.seo.jae.repository.CourseBookRepository;

@Service
public class CourseBookServiceImpl implements CourseBookService {
	
	@Autowired
	private CourseBookRepository courseBookRepository;
	
	@Override
	public List<CourseBook> allBooks() {
		List<CourseBook> books = courseBookRepository.findAll();
		return books;
	}

	@Override
	public List<CourseBook> availbeBooks(String year) {
		List<CourseBook> books = courseBookRepository.findByYear(year);
		return books;	
	}

	@Override
	public List<CourseBook> availableGradeBooks(String grade, String year) {
		List<CourseBook> books = courseBookRepository.findByGradeAndYear(grade, year);
		return books;	
	}

	@Override
	public long checkCount() {
		long count = courseBookRepository.count();
		return count;
	}
	
}
