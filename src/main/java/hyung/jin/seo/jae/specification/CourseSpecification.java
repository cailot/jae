package hyung.jin.seo.jae.specification;

import java.time.LocalDate;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Expression;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.data.jpa.domain.Specification;

import hyung.jin.seo.jae.model.Course;
import hyung.jin.seo.jae.model.Student;

public interface CourseSpecification {
	
	
	// Id
	static Specification<Course> idEquals(String keyword){
		return (root, query, cb) -> cb.equal(root.get("id"), Integer.parseInt(keyword));
	}
		
	// grade equal
	static Specification<Course> gradeEquals(String keyword){
		return (root, query, cb) -> cb.equal(root.get("grade"), keyword);
	}
		

	// grade not equal
	static Specification<Course> gradeNotEquals(String keyword){
		return (root, query, cb) -> cb.notEqual(root.get("grade"), keyword);
	}

	
	// name
	static Specification<Course> nameContains(String keyword){
		return (root, query, cb) -> cb.like(root.get("firstName"), "%" + keyword + "%");
	}
	
	
	
	// is not null 
	static Specification<Course> hasNotNullVaule(String column){
		return (root, query, cb) -> cb.isNotNull(root.get(column));
	}
	
	// is null
	static Specification<Course> hasNullVaule(String column){
		return (root, query, cb) -> cb.isNull(root.get(column));
	}
	
	
}
