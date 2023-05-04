package hyung.jin.seo.jae.model;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.persistence.CascadeType;


@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="Course_Cycle")
public class CourseCycle{
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // auto increment
    private Long id;
    
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "courseId")
	private Course course;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "cycleId")
	private Cycle cycle;
	
	@Column(name="fee")
	private BigDecimal fee;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	
	public BigDecimal getFee() {
		return fee;
	}

	public void setFee(BigDecimal fee) {
		this.fee = fee;
	}

	public Course getCourse() {
		return course;
	}

	public void setCourse(Course course) {
		this.course = course;
	}

	public Cycle getCycle() {
		return cycle;
	}

	public void setCycle(Cycle cycle) {
		this.cycle = cycle;
	}

	@Override
	public String toString() {
		return "CourseCycle [id=" + id + ", course=" + course + ", cycle=" + cycle + ", fee=" + fee + "]";
	}

	
 }
