package hyung.jin.seo.jae.model;

import org.hibernate.annotations.CreationTimestamp;

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
import java.time.LocalDate;
import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="Subject")
public class Subject {
    
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // auto increment
    private Long id;
    
    @Column(length = 200, nullable = false)
    private String name;
    
    @Column(length = 400, nullable = false)
    private String description;
    
    @Column(length = 10, nullable = false)
    private String abr;
    
    @CreationTimestamp
    private LocalDate registerDate;

	@ManyToMany(fetch=FetchType.LAZY, cascade=CascadeType.DETACH, mappedBy="subjects")
    private Set<Course> courses = new LinkedHashSet<>();

	
 }
