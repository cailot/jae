package hyung.jin.seo.jae.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import hyung.jin.seo.jae.model.Course;

public interface CourseRepository extends JpaRepository<Course, Long>{  
    
}
