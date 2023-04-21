package hyung.jin.seo.jae.service;

import java.util.List;

import hyung.jin.seo.jae.model.CourseBook;

public interface CourseBookService {
	// list all Course Books
	List<CourseBook> allBooks();
	
	// list available books based on year
	List<CourseBook> availbeBooks(String year);

	// list available books based on grade & year
	List<CourseBook> availableGradeBooks(String grade, String year);
	
	// return total count
	long checkCount();
}
