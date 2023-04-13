package hyung.jin.seo.jae.model;

import java.io.Serializable;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
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
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


public class StudentDTO implements Serializable{
    
    private String id;
    
    private String firstName;
    
    private String lastName;
    
    private String grade;
    
    private String contactNo1;
    
    private String contactNo2;
    
    private String email;
    
    private String address;
    
    private String state;
    
    private String branch;
    
    private String memo;
    
    private String registerDate;
    
    private String enrolmentDate;
    
    private String endDate;
    
    private List<CourseDTO> courses;
    
    public List<CourseDTO> getCourses() {
		return courses;
	}

	public void setCourses(List<CourseDTO> courses) {
		this.courses = courses;
	}

	public StudentDTO() {}

    public StudentDTO(Student std) {
    	this.id = (std.getId()!=null) ? std.getId().toString() : "";
        this.firstName = (std.getFirstName()!=null) ? std.getFirstName() : "";
        this.lastName = (std.getLastName()!=null) ? std.getLastName() : "";
        this.grade = (std.getGrade()!=null) ? std.getGrade() : "";
        this.contactNo1 = (std.getContactNo1()!=null) ? std.getContactNo1() : "";
        this.contactNo2 = (std.getContactNo2()!=null) ? std.getContactNo2() : "";
        this.email = (std.getEmail()!=null) ? std.getEmail() : "";
        this.address = (std.getAddress()!=null) ? std.getAddress() : "";
        this.state = (std.getState()!=null) ? std.getState() : "";
        this.branch = (std.getBranch()!=null) ? std.getBranch() : "";
        this.memo = (std.getMemo()!=null) ? std.getMemo() : "";
        this.registerDate = (std.getRegisterDate()!=null) ? std.getRegisterDate().toString() : "";
        this.enrolmentDate = (std.getEnrolmentDate()!=null) ? std.getEnrolmentDate().toString() : "";
        this.endDate = (std.getEndDate()!=null) ? std.getEndDate().toString() : ""; 
        if((std.getCourses()!=null) && (std.getCourses().size()>0)){
        	courses = new ArrayList<CourseDTO>();
        	for(Course crs : std.getCourses()) {
        		courses.add(new CourseDTO(crs));
        	}
        }
    }
    
    public Student convertToStudent() {
    	Student std = new Student();
    	if(StringUtils.isNotBlank(id)) std.setId(Long.parseLong(this.id));
    	if(StringUtils.isNotBlank(firstName)) std.setFirstName(this.firstName);
    	if(StringUtils.isNotBlank(lastName)) std.setLastName(this.lastName);
    	if(StringUtils.isNotBlank(grade)) std.setGrade(this.grade);
    	if(StringUtils.isNotBlank(contactNo1)) std.setContactNo1(this.contactNo1);
    	if(StringUtils.isNotBlank(contactNo2)) std.setContactNo2(this.contactNo2);
    	if(StringUtils.isNotBlank(email)) std.setEmail(this.email);
    	if(StringUtils.isNotBlank(address)) std.setAddress(this.address);
    	if(StringUtils.isNotBlank(state)) std.setState(this.state);
    	if(StringUtils.isNotBlank(branch)) std.setBranch(this.branch);
    	if(StringUtils.isNotBlank(memo)) std.setMemo(this.memo);
    	if(StringUtils.isNotBlank(registerDate)) std.setRegisterDate(LocalDate.parse(registerDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));
    	if(StringUtils.isNotBlank(enrolmentDate)) std.setEnrolmentDate(LocalDate.parse(enrolmentDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));
    	if(StringUtils.isNotBlank(endDate)) std.setEndDate(LocalDate.parse(endDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));
    	if((courses!=null) && (courses.size() > 0)) {
    		for(CourseDTO dto : courses) {
    			std.getCourses().add(dto.convertToCourse());
    		}
    	}
    	return std;
    }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getContactNo1() {
		return contactNo1;
	}

	public void setContactNo1(String contactNo1) {
		this.contactNo1 = contactNo1;
	}

	public String getContactNo2() {
		return contactNo2;
	}

	public void setContactNo2(String contactNo2) {
		this.contactNo2 = contactNo2;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
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

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(String registerDate) {
		this.registerDate = registerDate;
	}

	public String getEnrolmentDate() {
		return enrolmentDate;
	}

	public void setEnrolmentDate(String enrolmentDate) {
		this.enrolmentDate = enrolmentDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	@Override
	public String toString() {
		return "StudentDTO [id=" + id + ", firstName=" + firstName + ", lastName=" + lastName + ", grade=" + grade
				+ ", contactNo1=" + contactNo1 + ", contactNo2=" + contactNo2 + ", email=" + email + ", address="
				+ address + ", state=" + state + ", branch=" + branch + ", memo=" + memo + ", registerDate="
				+ registerDate + ", enrolmentDate=" + enrolmentDate + ", endDate=" + endDate + ", courses=" + courses
				+ "]";
	}

	
        
}
