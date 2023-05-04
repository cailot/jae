package hyung.jin.seo.jae.dto;

import java.io.Serializable;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import hyung.jin.seo.jae.model.CourseEtc;
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


public class CourseEtcDTO implements Serializable{
    
	private String id;
    
    private String name;
    
    private String price;
    
    private String registerDate;
    
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

	@Override
	public String toString() {
		return "CourseEtcDTO [id=" + id + ", name=" + name + ", price=" + price + ", registerDate=" + registerDate
				+ "]";
	}


	public CourseEtcDTO() {}


	public CourseEtcDTO(CourseEtc cf) {
    	this.id = (cf.getId()!=null) ? cf.getId().toString() : "";
    	this.name = (cf.getName()!=null) ? cf.getName() : "";
    	this.price = (cf.getPrice()!=0.0) ? Double.toString(cf.getPrice()): "0.0";
    	this.registerDate = (cf.getRegisterDate()!=null) ? cf.getRegisterDate().toString() : "";
    }
    
    public CourseEtc convertToCourseEtc() {
    	CourseEtc ce = new CourseEtc();
    	if(StringUtils.isNotBlank(id)) ce.setId(Long.parseLong(this.id));
    	if(StringUtils.isNotBlank(name)) ce.setName(this.name);
    	if(StringUtils.isNotBlank(price)) ce.setPrice(Double.parseDouble(this.price));
    	if(StringUtils.isNotBlank(registerDate)) ce.setRegisterDate(LocalDate.parse(registerDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));
    	return ce;
    }
}
