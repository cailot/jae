package hyung.jin.seo.jae.model;

import org.hibernate.annotations.CreationTimestamp;

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
@Table(name="Course")
public class Course{
    
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // auto increment
    private Long id;
    
    @Column(length = 100, nullable = false)
    private String name;
    
    @Column(length = 10, nullable = false)
    private String grade;
    
    @Column(length = 400, nullable = false)
    private String description;
    
    @Column(length = 10, nullable = false)
    private String day;

    @CreationTimestamp
    private LocalDate registerDate;
    
    @OneToMany(mappedBy = "course")
    private Set<CourseCycle> courseCycles = new LinkedHashSet<>();

    public void addCourseCycle(CourseCycle cc) {
        courseCycles.add(cc);
    }    
    
	public Set<CourseCycle> getCourseCycles() {
		return courseCycles;
	}

	public void setCourseCycles(Set<CourseCycle> cycles) {
		this.courseCycles = cycles;
	}

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
		return "Course [id=" + id + ", name=" + name + ", grade=" + grade + ", description=" + description + ", day="
				+ day + ", registerDate=" + registerDate + ", courseCycles=" + courseCycles + "]";
	}

 }
