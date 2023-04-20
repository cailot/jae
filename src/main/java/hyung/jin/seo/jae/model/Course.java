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
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

//@Getter
//@Setter
//@ToString
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="Course")
public class Course implements Serializable{
    
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // auto increment
    private Long id;
    
    @Column(length = 100, nullable = false)
    private String name;
    
    @Column(length = 10, nullable = false)
    private String grade;

    @Column(length = 30, nullable = true)
    private String state;
    
    @Column(length = 50, nullable = true)
    private String branch;
    
    @Column(length = 400, nullable = false)
    private String description;
    
    @Column(length = 10, nullable = false)
    private String day;

    @CreationTimestamp
    private LocalDate registerDate;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public LocalDate getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(LocalDate registerDate) {
		this.registerDate = registerDate;
	}

	@Override
	public String toString() {
		return "Course [id=" + id + ", name=" + name + ", grade=" + grade + ", state=" + state + ", branch=" + branch
				+ ", description=" + description + ", day=" + day + ", registerDate=" + registerDate + "]";
	}

 }
