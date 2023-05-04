package hyung.jin.seo.jae.dto;

import java.io.Serializable;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import hyung.jin.seo.jae.model.CourseBook;
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


public class CourseBookDTO implements Serializable{
    
	private String id;
    
    private String grade;
    
    private String name;
    
    private String year;
    
    private String subjects;
    
    private String price;
    
    private String registerDate;
    
	public CourseBookDTO() {}

	@Override
	public String toString() {
		return "CourseBookDTO [id=" + id + ", grade=" + grade + ", name=" + name + ", year=" + year + ", subjects="
				+ subjects + ", price=" + price + ", registerDate=" + registerDate + "]";
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

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getSubjects() {
		return subjects;
	}

	public void setSubjects(String subjects) {
		this.subjects = subjects;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(String registerDate) {
		this.registerDate = registerDate;
	}

	public CourseBookDTO(CourseBook cb) {
    	this.id = (cb.getId()!=null) ? cb.getId().toString() : "";
    	this.grade = (cb.getGrade()!=null) ? cb.getGrade() : "";
    	this.name = (cb.getName()!=null) ? cb.getName() : "";
    	this.year = (cb.getYear()!=null) ? cb.getYear(): "";
    	this.subjects = (cb.getSubjects()!=null) ? cb.getSubjects() : "";
    	this.price = (cb.getPrice()!=0.0) ? Double.toString(cb.getPrice()): "0.0";
    	this.registerDate = (cb.getRegisterDate()!=null) ? cb.getRegisterDate().toString() : "";
    }
    
    public CourseBook convertToCourseBook() {
    	CourseBook cb = new CourseBook();
    	if(StringUtils.isNotBlank(id)) cb.setId(Long.parseLong(this.id));
    	if(StringUtils.isNotBlank(grade)) cb.setGrade(this.grade);
    	if(StringUtils.isNotBlank(name)) cb.setName(this.name);
    	if(StringUtils.isNotBlank(year)) cb.setYear(this.year);
    	if(StringUtils.isNotBlank(subjects)) cb.setSubjects(this.subjects);
    	if(StringUtils.isNotBlank(price)) cb.setPrice(Double.parseDouble(this.price));
    	if(StringUtils.isNotBlank(registerDate)) cb.setRegisterDate(LocalDate.parse(registerDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));
    	return cb;
    }
}
