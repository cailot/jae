package hyung.jin.seo.jae.model;

import org.hibernate.annotations.CreationTimestamp;
import org.springframework.data.annotation.CreatedDate;


import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import java.time.LocalDate;
import java.util.Set;
import java.util.LinkedHashSet;

//@Getter
//@Setter
//@ToString
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="Cycle")
public class Cycle {
    
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // auto increment
    private Long id;
    
	@Column(length = 4, nullable = false)
    private Integer year;
	
	@Column(length = 200, nullable = true)
    private String description;
    
    @CreatedDate
    private LocalDate startDate;
    
    @CreatedDate
    private LocalDate endDate;

    @CreatedDate
    private LocalDate vacationStartDate;
    
    @CreatedDate
    private LocalDate vacationEndDate;
    
    @CreationTimestamp
    private LocalDate registerDate;
    
	@OneToMany(mappedBy="cycle")
    private Set<CourseCycle> courseCycles = new LinkedHashSet<>();
	
	public void addCourseCycle(CourseCycle cc) {
		courseCycles.add(cc);
	}

	public Set<CourseCycle> getCourseCycles() {
		return courseCycles;
	}

	public void setCourseCycles(Set<CourseCycle> courseCycles) {
		this.courseCycles = courseCycles;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public LocalDate getStartDate() {
		return startDate;
	}

	public void setStartDate(LocalDate startDate) {
		this.startDate = startDate;
	}

	public LocalDate getEndDate() {
		return endDate;
	}

	public void setEndDate(LocalDate endDate) {
		this.endDate = endDate;
	}

	public LocalDate getVacationStartDate() {
		return vacationStartDate;
	}

	public void setVacationStartDate(LocalDate vacationStartDate) {
		this.vacationStartDate = vacationStartDate;
	}

	public LocalDate getVacationEndDate() {
		return vacationEndDate;
	}

	public void setVacationEndDate(LocalDate vacationEndDate) {
		this.vacationEndDate = vacationEndDate;
	}

	public LocalDate getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(LocalDate registerDate) {
		this.registerDate = registerDate;
	}

	@Override
	public String toString() {
		return "Cycle [id=" + id + ", year=" + year + ", description=" + description + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", vacationStartDate=" + vacationStartDate + ", vacationEndDate="
				+ vacationEndDate + ", registerDate=" + registerDate + ", courseCycles=" + courseCycles + "]";
	}

}
