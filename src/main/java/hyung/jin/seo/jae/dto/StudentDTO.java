package hyung.jin.seo.jae.dto;

import java.io.Serializable;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.format.annotation.DateTimeFormat;

import hyung.jin.seo.jae.model.Elearning;
import hyung.jin.seo.jae.model.Student;
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
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
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
    
    private Set<ElearningDTO> elearnings = new LinkedHashSet<>();
	 
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
    	if((elearnings!=null) && (elearnings.size() > 0)) {
    		
    		for(ElearningDTO dto : elearnings) {
    			std.getElearnings().add(dto.convertToElearning());
    		}
    	}
    	return std;
    }

	public Student convertToOnlyStudent() {
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
    	// if((elearnings!=null) && (elearnings.size() > 0)) {
    		
    	// 	for(ElearningDTO dto : elearnings) {
    	// 		std.getElearnings().add(dto.convertToCourse());
    	// 	}
    	// }
    	return std;
    }


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
        if((std.getElearnings()!=null) && (std.getElearnings().size()>0)){
        	for(Elearning crs : std.getElearnings()) {
        		elearnings.add(new ElearningDTO(crs));
        	}
        }
    }
        
}
