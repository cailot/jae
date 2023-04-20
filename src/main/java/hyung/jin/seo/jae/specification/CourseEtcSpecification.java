package hyung.jin.seo.jae.specification;

import org.springframework.data.jpa.domain.Specification;

import hyung.jin.seo.jae.model.CourseEtc;

public interface CourseEtcSpecification {
	
	// grade not equal
	static Specification<CourseEtc> gradeNotEquals(String keyword){
		return (root, query, cb) -> cb.notEqual(root.get("grade"), keyword);
	}
}
