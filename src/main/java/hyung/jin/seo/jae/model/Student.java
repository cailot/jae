package hyung.jin.seo.jae.model;

import org.hibernate.annotations.CreationTimestamp;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="Student")
public class Student {
    
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // auto increment
    private Long id;
    
    @Column(length = 100, nullable = false)
    private String firstName;
    
    @Column(length = 100, nullable = false)
    private String lastName;
    
    @Column(length = 10, nullable = false)
    private String grade;
    
    @Column(length = 50, nullable = true)
    private String contactNo1;
    
    @Column(length = 50, nullable = true)
    private String contactNo2;
    
    @Column(length = 100, nullable = true)
    private String email;
    
    @Column(length = 200, nullable = true)
    private String address;
    
    @Column(length = 30, nullable = true)
    private String state;
    
    @Column(length = 50, nullable = true)
    private String branch;
    
    @Column(length = 1000, nullable = true)
    private String memo;
    
    @CreationTimestamp
    private LocalDate registerDate;
    
    //@UpdateTimestamp
    // @DateTimeFormat
    // private LocalDate enrolmentDate;
    
    @CreatedDate
    private LocalDate endDate;

    // Unidirectional ManyToMany
    @ManyToMany(cascade=CascadeType.ALL)
    @JoinTable(name="Student_Elearning",
    	joinColumns = @JoinColumn(name="studentId"),
    	inverseJoinColumns = @JoinColumn(name="elearningId")
    )
    private Set<Elearning> elearnings = new HashSet<>();

}
