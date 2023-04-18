package hyung.jin.seo.jae.service;

import java.time.LocalDate;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import hyung.jin.seo.jae.model.Elearning;
import hyung.jin.seo.jae.repository.ElearningRepository;
import hyung.jin.seo.jae.specification.ElearningSpecification;

@Service
public class ElearningServiceImpl implements ElearningService {
	
	@Autowired
	private ElearningRepository elearningRepository;

	@Override
	public long checkCount() {
		long count = elearningRepository.countByEndDateIsNull();
		return count;
	}

	@Override
	public List<Elearning> allElearnings() {
		List<Elearning> courses = elearningRepository.findAll();
		return courses;
	}
	
	@Override
	public List<Elearning> availableElearnings() {
		List<Elearning> courses = elearningRepository.findAllByEndDateIsNull();
		return courses;
	}

	@Override
	public Elearning getElearning(Long id) {
		Elearning crs = elearningRepository.findByIdAndEndDateIsNull(id);
		return crs;
	}

	@Override
	public Elearning addElearning(Elearning crs) {
		Elearning course = elearningRepository.save(crs);
		return course;
	}

	@Override
	public Elearning updateElearning(Elearning newCourse, Long id) {
		// search by getId
		Elearning existing = elearningRepository.findById(id).get();
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
        Elearning updated = elearningRepository.save(existing);
        return updated;
	}

	
	@Override
	public void dischargeElearning(Long id) {
		try {
			Elearning end = elearningRepository.findByIdAndEndDateIsNull(id);
			end.setEndDate(LocalDate.now());
			elearningRepository.save(end);	
		} catch (org.springframework.dao.EmptyResultDataAccessException e) {
			System.out.println("Nothing to discharge");
		}
	}

	
	@Override
	public void deleteElearning(Long id) {
		try{
		    elearningRepository.deleteById(id);
        }catch(org.springframework.dao.EmptyResultDataAccessException e){
            System.out.println("Nothing to delete");
        }
	}

	@Override
	public List<Elearning> gradeElearnings(String grade) {
		List<Elearning> courses = null;
		Specification<Elearning> spec = Specification.where(null);
		spec = spec.and(ElearningSpecification.gradeEquals(grade));
		spec = spec.and(ElearningSpecification.hasNullVaule("endDate")); // among current Elearning
		courses = elearningRepository.findAll(spec);
		return courses;
	}

	@Override
	public List<Elearning> notGradeElearnings(String grade) {
		List<Elearning> courses = null;
		Specification<Elearning> spec = Specification.where(null);
		spec = spec.and(ElearningSpecification.gradeNotEquals(grade));
		spec = spec.and(ElearningSpecification.hasNullVaule("endDate")); // among current Elearning
		courses = elearningRepository.findAll(spec);
		return courses;
	}


}
