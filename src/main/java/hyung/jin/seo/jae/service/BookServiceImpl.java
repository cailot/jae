package hyung.jin.seo.jae.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hyung.jin.seo.jae.model.Book;
import hyung.jin.seo.jae.repository.BookRepository;

@Service
public class BookServiceImpl implements BookService {
	
	@Autowired
	private BookRepository courseBookRepository;
	
	@Override
	public List<Book> allBooks() {
		List<Book> books = courseBookRepository.findAll();
		return books;
	}

	@Override
	public List<Book> availbeBooks(String year) {
		List<Book> books = courseBookRepository.findByYear(year);
		return books;	
	}

	@Override
	public List<Book> availableGradeBooks(String grade, String year) {
		List<Book> books = courseBookRepository.findByGradeAndYear(grade, year);
		return books;	
	}

	@Override
	public long checkCount() {
		long count = courseBookRepository.count();
		return count;
	}
	
}
