package hyung.jin.seo.jae.service;

import java.util.List;

import hyung.jin.seo.jae.model.Book;

public interface BookService {
	// list all Course Books
	List<Book> allBooks();
	
	// list available books based on year
	// List<Book> availbeBooks(String year);

	// list available books based on grade & year
	// List<Book> availableGradeBooks(String grade, String year);
	
	// list available books based on grade
	List<Book> booksByGrade(String grade);

	// return total count
	long checkCount();
}
