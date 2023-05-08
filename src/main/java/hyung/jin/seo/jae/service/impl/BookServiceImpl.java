package hyung.jin.seo.jae.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hyung.jin.seo.jae.dto.BookDTO;
import hyung.jin.seo.jae.model.Book;
import hyung.jin.seo.jae.repository.BookRepository;
import hyung.jin.seo.jae.repository.SubjectRepository;
import hyung.jin.seo.jae.service.BookService;

@Service
public class BookServiceImpl implements BookService {
	
	@Autowired
	private BookRepository courseBookRepository;
	
	@Autowired
	private SubjectRepository subjectRepository;

	@Override
	public List<BookDTO> allBooks() {
		List<Book> books = courseBookRepository.findAll();
		List<BookDTO> dtos = new ArrayList<>();
		for(Book book: books){
			BookDTO dto = new BookDTO(book);
			dtos.add(dto);
		}
		return dtos;
	}

	// @Override
	// public List<Book> availbeBooks(String year) {
	// 	List<Book> books = courseBookRepository.findByYear(year);
	// 	return books;	
	// }

	// @Override
	// public List<Book> availableGradeBooks(String grade, String year) {
	// 	List<Book> books = courseBookRepository.findByGradeAndYear(grade, year);
	// 	return books;	
	// }

	@Override
	public List<BookDTO> booksByGrade(String grade) {
		// 1. get books
		List<Book> books = courseBookRepository.findByGrade(grade);
		// 2. get subjects
		List<String> subjects = subjectRepository.findSubjectNamesForGrade(grade);
		// 3. assign subjects to books
		List<BookDTO> dtos = new ArrayList<BookDTO>();
		for(Book book : books){
			BookDTO dto = new BookDTO(book);
			for(String subject : subjects){
				dto.addSubject(subject);
			}
			dtos.add(dto);
		}
		// 4. return DTOs
		return dtos;	
	}

	@Override
	public long checkCount() {
		long count = courseBookRepository.count();
		return count;
	}
	
}
