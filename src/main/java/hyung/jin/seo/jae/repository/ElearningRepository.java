package hyung.jin.seo.jae.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import hyung.jin.seo.jae.dto.ElearningDTO;
import hyung.jin.seo.jae.model.Elearning;

public interface ElearningRepository extends JpaRepository<Elearning, Long>{  
	
	List<Elearning> findAll();
	
	List<Elearning> findAllByGrade(String grade);

	// list elearnings by student id
	// @Query("SELECT new hyung.jin.seo.jae.dto.ElearningDTO(e.id, e.grade, e.name) FROM Elearning e WHERE c. = ?1")
	// List<ElearningDTO> findElearningByStudent(Long id);
	
	// //@Query("FROM Elearning e WHERE e.id IN (SELECT se.elearningId FROM Student_Elearning se WHERE se.studentId = :studentId)")
	// //@Query("SELECT e FROM Elearning e WHERE e.id IN (SELECT se.elearningId FROM Student_Elearning se WHERE se.studentId = ?1)")
	// @Query("SELECT new com.example.ElearningDTO(e.id, e.name) FROM Elearning e WHERE e.id IN (SELECT se.elearningId FROM Student_Elearning se WHERE se.studentId = ?1)")
	// List<ElearningDTO> findByStudentId(Long id);

    // List<Elearning> findByStudentId(Long id);

// @Query("SELECT e FROM Elearning e WHERE e.id IN (SELECT se.elearningId FROM Student_Elearning se WHERE se.studentId = ?1)")
@Query(value = "SELECT * FROM Elearning WHERE id IN (SELECT elearningId FROM Student_Elearning WHERE studentId = ?1)", nativeQuery = true)   
List<Elearning> findByStudentId(Long id);




	Optional<Elearning> findById(Long id);
	
	long count();
}
