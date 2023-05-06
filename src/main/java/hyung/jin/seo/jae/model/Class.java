package hyung.jin.seo.jae.model;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.persistence.CascadeType;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="Class")
public class Class{
	
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

	@Column(length = 400)
    private String description;

}
