package hyung.jin.seo.jae.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import hyung.jin.seo.jae.model.Student;

public interface StudentRepository extends JpaRepository<Student, Long>{  
    
}
