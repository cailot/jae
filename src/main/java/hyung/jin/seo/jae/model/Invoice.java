package hyung.jin.seo.jae.model;

import java.time.LocalDate;
import java.util.LinkedHashSet;
import java.util.Set;

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
import javax.persistence.OneToOne;
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
    

	// vice versa
	// @OneToMany
	// @JoinColumn(name = "clazzId")
	// private Set<Clazz> clazzs = new LinkedHashSet<>();

	// @OneToMany
	// @JoinColumn(name = "bookId")
	// private Set<Book> books = new LinkedHashSet<>();

	// @OneToMany
	// @JoinColumn(name = "etcId")
	// private Set<CourseEtc> etcs = new LinkedHashSet<>();

	// studentId
	@OneToOne
	@JoinColumn(name = "studentId")
	private Student student;
	
	// auto update to current date
	@CreationTimestamp
    private LocalDate registerDate;





	@Column
	private boolean cancelled;

	@Column(length = 100)
    private String cancellationReason;

	@Column
	private int startWeek;

	@Column
	private int endWeek;

}
