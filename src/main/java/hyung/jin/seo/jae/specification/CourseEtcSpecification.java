package hyung.jin.seo.jae.specification;

import org.springframework.data.jpa.domain.Specification;

import hyung.jin.seo.jae.model.CourseEtc;

public interface CourseEtcSpecification {
	
	
	// grade not equal
	static Specification<CourseEtc> nameNotStarts(String keyword){
		return (root, query, cb) -> cb.notLike(root.get("name"), keyword + "%");
	}
	
}
