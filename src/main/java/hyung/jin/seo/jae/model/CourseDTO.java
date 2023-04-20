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


public class CourseDTO implements Serializable{
    
	private String id;
    
    private String name;
    
    private String description;
    
    private String registerDate;
    
    private String grade;

    private String state;
    
    private String branch;
    
    private String day;

    
	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public String getRegisterDate() {
		return registerDate;
	}


	public void setRegisterDate(String registerDate) {
		this.registerDate = registerDate;
	}


	public String getGrade() {
		return grade;
	}


	public void setGrade(String grade) {
		this.grade = grade;
	}


	public String getState() {
		return state;
	}


	public void setState(String state) {
		this.state = state;
	}


	public String getBranch() {
		return branch;
	}


	public void setBranch(String branch) {
		this.branch = branch;
	}


	public String getDay() {
		return day;
	}


	public void setDay(String day) {
		this.day = day;
	}


	@Override
	public String toString() {
		return "CourseDTO [id=" + id + ", name=" + name + ", description=" + description + ", registerDate="
				+ registerDate + ", grade=" + grade + ", state=" + state + ", branch=" + branch + ", day=" + day + "]";
	}


	public CourseDTO() {}


	public CourseDTO(Course course) {
    	this.id = (course.getId()!=null) ? course.getId().toString() : "";
    	this.name = (course.getName()!=null) ? course.getName() : "";
    	this.description = (course.getDescription()!=null) ? course.getDescription() : "";
    	this.registerDate = (course.getRegisterDate()!=null) ? course.getRegisterDate().toString() : "";
    	this.grade = (course.getGrade()!=null) ? course.getGrade() : "";
    	this.state = (course.getState()!=null) ? course.getState() : "";
    	this.branch = (course.getBranch()!=null) ? course.getBranch() : "";
    	this.day = (course.getDay()!=null) ? course.getDay() : "";
    }
    
    public Course convertToCourse() {
    	Course course = new Course();
    	if(StringUtils.isNotBlank(id)) course.setId(Long.parseLong(this.id));
    	if(StringUtils.isNotBlank(name)) course.setName(this.name);
    	if(StringUtils.isNotBlank(description)) course.setDescription(this.description);
    	if(StringUtils.isNotBlank(registerDate)) course.setRegisterDate(LocalDate.parse(registerDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));
    	if(StringUtils.isNotBlank(grade)) course.setGrade(this.grade);
    	if(StringUtils.isNotBlank(state)) course.setState(this.state);
    	if(StringUtils.isNotBlank(branch)) course.setBranch(this.branch);
    	if(StringUtils.isNotBlank(day)) course.setDay(this.day);
    	return course;
    }
}
