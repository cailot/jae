package hyung.jin.seo.jae.dto;

import java.io.Serializable;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import hyung.jin.seo.jae.model.Course;
import hyung.jin.seo.jae.model.Cycle;
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
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class CourseDTO implements Serializable{
    
	private String id;
    
    private String name;
    
    private String description;
    
    private String registerDate;
    
    private String grade;

    private String day;
	

	public CourseDTO(Course course) {
    	this.id = (course.getId()!=null) ? course.getId().toString() : "";
    	this.name = (course.getName()!=null) ? course.getName() : "";
    	this.description = (course.getDescription()!=null) ? course.getDescription() : "";
    	this.registerDate = (course.getRegisterDate()!=null) ? course.getRegisterDate().toString() : "";
    	this.grade = (course.getGrade()!=null) ? course.getGrade() : "";
    	// this.day = (course.getDay()!=null) ? course.getDay() : "";
		
    }
    
    public Course convertToCourse() {
    	Course course = new Course();
    	if(StringUtils.isNotBlank(id)) course.setId(Long.parseLong(this.id));
    	if(StringUtils.isNotBlank(name)) course.setName(this.name);
    	if(StringUtils.isNotBlank(description)) course.setDescription(this.description);
    	if(StringUtils.isNotBlank(registerDate)) course.setRegisterDate(LocalDate.parse(registerDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));
    	if(StringUtils.isNotBlank(grade)) course.setGrade(this.grade);
    	// if(StringUtils.isNotBlank(day)) course.setDay(this.day);
    	return course;
    }
}
