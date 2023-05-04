package hyung.jin.seo.jae.dto;

import java.io.Serializable;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

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


public class CycleDTO implements Serializable{
    
	private String id;
    
    private String year;
    
    private String description;
    
    private String registerDate;
    
    private String startDate;

    private String endDate;
    
    private String vacationStartDate;

    private String vacationEndDate;
    
    
	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getYear() {
		return year;
	}


	public void setYear(String year) {
		this.year = year;
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


	public String getStartDate() {
		return startDate;
	}


	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}


	public String getEndDate() {
		return endDate;
	}


	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}


	public String getVacationStartDate() {
		return vacationStartDate;
	}


	public void setVacationStartDate(String vacationStartDate) {
		this.vacationStartDate = vacationStartDate;
	}


	public String getVacationEndDate() {
		return vacationEndDate;
	}


	public void setVacationEndDate(String vacationEndDate) {
		this.vacationEndDate = vacationEndDate;
	}


	@Override
	public String toString() {
		return "CycleDTO [id=" + id + ", year=" + year + ", description=" + description + ", registerDate="
				+ registerDate + ", startDate=" + startDate + ", endDate=" + endDate + ", vacationStartDate="
				+ vacationStartDate + ", vacationEndDate=" + vacationEndDate + "]";
	}


	public CycleDTO() {}


	public CycleDTO(Cycle cycle) {
    	this.id = (cycle.getId()!=null) ? cycle.getId().toString() : "";
    	this.year = (cycle.getYear()!=null) ? cycle.getYear().toString() : "";
    	this.description = (cycle.getDescription()!=null) ? cycle.getDescription() : "";
    	this.startDate = (cycle.getStartDate()!=null) ? cycle.getStartDate().toString() : "";
    	this.endDate = (cycle.getEndDate()!=null) ? cycle.getEndDate().toString() : "";
    	this.vacationStartDate = (cycle.getVacationStartDate()!=null) ? cycle.getVacationStartDate().toString() : "";
    	this.vacationEndDate = (cycle.getVacationEndDate()!=null) ? cycle.getVacationEndDate().toString() : "";
    	this.registerDate = (cycle.getRegisterDate()!=null) ? cycle.getRegisterDate().toString() : "";
    }
    
    public Cycle convertToCycle() {
    	Cycle cycle = new Cycle();
    	if(StringUtils.isNotBlank(id)) cycle.setId(Long.parseLong(this.id));
    	if(StringUtils.isNotBlank(year)) cycle.setYear(Integer.parseInt(this.year));
    	if(StringUtils.isNotBlank(description)) cycle.setDescription(this.description);
    	if(StringUtils.isNotBlank(startDate)) cycle.setStartDate(LocalDate.parse(startDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));
    	if(StringUtils.isNotBlank(endDate)) cycle.setEndDate(LocalDate.parse(endDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));
    	if(StringUtils.isNotBlank(vacationStartDate)) cycle.setVacationStartDate(LocalDate.parse(vacationStartDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));
    	if(StringUtils.isNotBlank(vacationEndDate)) cycle.setVacationEndDate(LocalDate.parse(vacationEndDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));
    	if(StringUtils.isNotBlank(registerDate)) cycle.setRegisterDate(LocalDate.parse(registerDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));
    	return cycle;
    }
}
