package hyung.jin.seo.jae.model;

import java.io.Serializable;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;


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


public class CourseFeeDTO implements Serializable{
    
	private String id;
    
    private String grade;
    
    private String name;
    
    private String year;
    
    private String subjects;
    
    private String price;
    
    private String registerDate;
    
	public CourseFeeDTO() {}

	@Override
	public String toString() {
		return "CourseFeeDTO [id=" + id + ", grade=" + grade + ", name=" + name + ", year=" + year + ", subjects="
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

	public CourseFeeDTO(CourseFee cf) {
    	this.id = (cf.getId()!=null) ? cf.getId().toString() : "";
    	this.grade = (cf.getGrade()!=null) ? cf.getGrade() : "";
    	this.name = (cf.getName()!=null) ? cf.getName() : "";
    	this.year = (cf.getYear()!=null) ? cf.getYear(): "";
    	this.subjects = (cf.getSubjects()!=null) ? cf.getSubjects() : "";
    	this.price = (cf.getPrice()!=0.0) ? Double.toString(cf.getPrice()): "0.0";
    	this.registerDate = (cf.getRegisterDate()!=null) ? cf.getRegisterDate().toString() : "";
    }
    
    public CourseFee convertToCourse() {
    	CourseFee cf = new CourseFee();
    	if(StringUtils.isNotBlank(id)) cf.setId(Long.parseLong(this.id));
    	if(StringUtils.isNotBlank(grade)) cf.setGrade(this.grade);
    	if(StringUtils.isNotBlank(name)) cf.setName(this.name);
    	if(StringUtils.isNotBlank(year)) cf.setYear(this.year);
    	if(StringUtils.isNotBlank(subjects)) cf.setSubjects(this.subjects);
    	if(StringUtils.isNotBlank(price)) cf.setPrice(Double.parseDouble(this.price));
    	if(StringUtils.isNotBlank(registerDate)) cf.setRegisterDate(LocalDate.parse(registerDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));
    	return cf;
    }
}
