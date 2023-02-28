package hyung.jin.seo.jae.service;

import java.time.LocalDate;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hyung.jin.seo.jae.model.Course;
import hyung.jin.seo.jae.repository.CourseRepository;

@Service
public class CourseServiceImpl implements CourseService {
	@Autowired
	private CourseRepository courseRepository;

	@Override
	public long checkCount() {
		long count = courseRepository.count();
		return count;
	}

	@Override
	public List<Course> allCourses() {
		List<Course> courses = courseRepository.findAll();
		return courses;
	}

	@Override
	public Course getCourse(Long id) {
		Course crs = courseRepository.findById(id).get();
		return crs;
	}

	@Override
	public void addCourse(Course crs) {
		courseRepository.save(crs);
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
        String newDescription = StringUtils.defaultString(newCourse.getDescription());
        if(StringUtils.isNotBlank(newDescription)){
        	existing.setDescription(newDescription);
        }
        String newAbr = StringUtils.defaultString(newCourse.getAbr());
        if(StringUtils.isNotBlank(newAbr)){
        	existing.setAbr(newAbr);
        }
        LocalDate newStartDate = newCourse.getStartDate();
        if(newStartDate!=null){
        	existing.setStartDate(newStartDate);
        }
        LocalDate newEndDate = newCourse.getEndDate();
        if(newEndDate!=null){
        	existing.setEndDate(newEndDate);
        }
        // update the existing record
        Course updated = courseRepository.save(existing);
        return updated;
	}

	@Override
	public void deleteCourse(Long id) {
		try{
		    courseRepository.deleteById(id);
        }catch(org.springframework.dao.EmptyResultDataAccessException e){
            System.out.println("Nothing to delete");
        }
	}
}
