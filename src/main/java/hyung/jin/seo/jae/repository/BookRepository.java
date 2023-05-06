package hyung.jin.seo.jae.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import hyung.jin.seo.jae.model.Book;

public interface BookRepository extends JpaRepository<Book, Long>{  
	
	List<Book> findAll();
	
	List<Book> findByYear(String year);

	List<Book> findByGradeAndYear(String grade, String year);
	
	long count();
}
