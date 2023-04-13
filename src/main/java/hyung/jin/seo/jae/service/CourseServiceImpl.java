package hyung.jin.seo.jae.service;

import java.time.LocalDate;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import hyung.jin.seo.jae.model.Course;
import hyung.jin.seo.jae.repository.CourseRepository;
import hyung.jin.seo.jae.specification.CourseSpecification;

@Service
public class CourseServiceImpl implements CourseService {
	
	@Autowired
	private CourseRepository courseRepository;

	@Override
	public long checkCount() {
		long count = courseRepository.countByEndDateIsNull();
		return count;
	}

	@Override
	public List<Course> allCourses() {
		List<Course> courses = courseRepository.findAll();
		return courses;
	}
	
	@Override
	public List<Course> availableCourses() {
		List<Course> courses = courseRepository.findAllByEndDateIsNull();
		return courses;
	}

	@Override
	public Course getCourse(Long id) {
		Course crs = courseRepository.findByIdAndEndDateIsNull(id);
		return crs;
	}

	@Override
	public Course addCourse(Course crs) {
		Course course = courseRepository.save(crs);
		return course;
	}

	@Override
	public Course updateCourse(Course newCourse, Long id) {
		// search by getId
		Course existing = courseRepository.findById(id).get();
        // Update info
        String newName = StringUtils.defaultString(newCourse.getName());
        if(StringUtils.isNotBlank(newName)){
        	existing.setName(newName);
        }
        String newGrade = StringUtils.defaultString(newCourse.getGrade());
        if(StringUtils.isNotBlank(newGrade)){
        	existing.setGrade(newGrade);
        }
        LocalDate newRegisterDate = newCourse.getRegisterDate();
        if(newRegisterDate!=null){
        	existing.setRegisterDate(newRegisterDate);
        }
        // update the existing record
        Course updated = courseRepository.save(existing);
        return updated;
	}

	
	@Override
	public void dischargeCourse(Long id) {
		try {
			Course end = courseRepository.findByIdAndEndDateIsNull(id);
			end.setEndDate(LocalDate.now());
			courseRepository.save(end);	
		} catch (org.springframework.dao.EmptyResultDataAccessException e) {
			System.out.println("Nothing to discharge");
		}
	}

	
	@Override
	public void deleteCourse(Long id) {
		try{
		    courseRepository.deleteById(id);
        }catch(org.springframework.dao.EmptyResultDataAccessException e){
            System.out.println("Nothing to delete");
        }
	}

	@Override
	public List<Course> gradeCourses(String grade) {
		List<Course> courses = null;
		Specification<Course> spec = Specification.where(null);
		spec = spec.and(CourseSpecification.gradeEquals(grade));
		spec = spec.and(CourseSpecification.hasNullVaule("endDate")); // among current courses
		courses = courseRepository.findAll(spec);
		return courses;
	}

	@Override
	public List<Course> notGradeCourses(String grade) {
		List<Course> courses = null;
		Specification<Course> spec = Specification.where(null);
		spec = spec.and(CourseSpecification.gradeNotEquals(grade));
		spec = spec.and(CourseSpecification.hasNullVaule("endDate")); // among current courses
		courses = courseRepository.findAll(spec);
		return courses;
	}


}
