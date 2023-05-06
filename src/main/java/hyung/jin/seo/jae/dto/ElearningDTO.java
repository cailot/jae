package hyung.jin.seo.jae.dto;

import java.io.Serializable;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import hyung.jin.seo.jae.model.Elearning;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

@Getter
@Setter
@ToString
public class ElearningDTO implements Serializable{
    
	private String id;
    
    private String grade;
    
    private String name;
    
    private String year;
    
 

	private String registerDate;
    
    private String endDate;
    
    private Set<StudentDTO> students = new LinkedHashSet<>();

	/*
	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(String registerDate) {
		this.registerDate = registerDate;
	}


	public Set<StudentDTO> getStudents() {
		return students;
	}

	public void setStudents(Set<StudentDTO> students) {
		this.students = students;
	}

	@Override
	public String toString() {
		return "CourseDTO [id=" + id + ", grade=" + grade + ", name=" + name + ", year=" + year + ", registerDate="
				+ registerDate + ", endDate=" + endDate + ", students=" + students + "]";
	}
*/

	public ElearningDTO() {}

	

	public ElearningDTO(Elearning crs) {
    	this.id = (crs.getId()!=null) ? crs.getId().toString() : "";
    	this.grade = (crs.getGrade()!=null) ? crs.getGrade() : "";
    	this.name = (crs.getName()!=null) ? crs.getName() : "";
    	this.year = (crs.getYear()!=null) ? crs.getYear(): "";
        this.registerDate = (crs.getRegisterDate()!=null) ? crs.getRegisterDate().toString() : "";
        this.endDate = (crs.getEndDate()!=null) ? crs.getEndDate().toString() : ""; 
//        if((crs.getStudents()!=null) && (crs.getStudents().size()>0)) {
//        	for(Student std : crs.getStudents()) {
//        		students.add(new StudentDTO(std));
//        	}
//        }
    }
    
    public Elearning convertToCourse() {
    	Elearning crs = new Elearning();
    	if(StringUtils.isNotBlank(id)) crs.setId(Long.parseLong(this.id));
    	if(StringUtils.isNotBlank(grade)) crs.setGrade(this.grade);
    	if(StringUtils.isNotBlank(name)) crs.setName(this.name);
    	if(StringUtils.isNotBlank(year)) crs.setYear(this.year);
    	if(StringUtils.isNotBlank(registerDate)) crs.setRegisterDate(LocalDate.parse(registerDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));
    	if(StringUtils.isNotBlank(endDate)) crs.setEndDate(LocalDate.parse(endDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));
//    	if((students!=null)&&(students.size()>0)) {
//    		for(StudentDTO dto : students) {
//    			crs.getStudents().add(dto.convertToStudent());
//    		}
//    	}
    	return crs;
    }

        
}
