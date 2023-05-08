package hyung.jin.seo.jae.service;

import java.util.List;

import hyung.jin.seo.jae.dto.BookDTO;

public interface BookService {
	// list all Course Books
	List<BookDTO> allBooks();
	
	// list available books based on grade
	List<BookDTO> booksByGrade(String grade);

	// return total count
	long checkCount();
}
