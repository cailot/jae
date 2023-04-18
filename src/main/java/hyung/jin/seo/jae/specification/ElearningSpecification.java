package hyung.jin.seo.jae.specification;

import org.springframework.data.jpa.domain.Specification;

import hyung.jin.seo.jae.model.Elearning;

public interface ElearningSpecification {
	
	
	// Id
	static Specification<Elearning> idEquals(String keyword){
		return (root, query, cb) -> cb.equal(root.get("id"), Integer.parseInt(keyword));
	}
		
	// grade equal
	static Specification<Elearning> gradeEquals(String keyword){
		return (root, query, cb) -> cb.equal(root.get("grade"), keyword);
	}
		

	// grade not equal
	static Specification<Elearning> gradeNotEquals(String keyword){
		return (root, query, cb) -> cb.notEqual(root.get("grade"), keyword);
	}

	
	// name
	static Specification<Elearning> nameContains(String keyword){
		return (root, query, cb) -> cb.like(root.get("firstName"), "%" + keyword + "%");
	}
	
	
	
	// is not null 
	static Specification<Elearning> hasNotNullVaule(String column){
		return (root, query, cb) -> cb.isNotNull(root.get(column));
	}
	
	// is null
	static Specification<Elearning> hasNullVaule(String column){
		return (root, query, cb) -> cb.isNull(root.get(column));
	}
	
	
}
