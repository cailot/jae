package hyung.jin.seo.jae.model;

import java.time.LocalDate;

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
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import javax.persistence.Column;
import javax.persistence.CascadeType;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="Invoice")
public class Invoice{ 
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // auto increment
    private Long id;
    
	// @ManyToOne(cascade = CascadeType.ALL)
	@OneToMany
	@JoinColumn(name = "bookId")
	private Student student;
	
	// @ManyToOne(cascade = CascadeType.ALL)
	@ManyToOne
	@JoinColumn(name = "clazzId")
	private Clazz clazz;
	
	// @CreatedDate
	// auto update to current date
	@CreationTimestamp
    private LocalDate enrolmentDate;

	@Column
	private boolean cancelled;

	@Column(length = 100)
    private String cancellationReason;

	@Column
	private int startWeek;

	@Column
	private int endWeek;

}
