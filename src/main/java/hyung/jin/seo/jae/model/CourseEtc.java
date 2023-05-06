package hyung.jin.seo.jae.model;

import java.io.Serializable;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;


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
@Table(name="CourseEtc")
public class CourseEtc {
    
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // auto increment
    private Long id;
    
    @Column(length = 200, nullable = false)
    private String name;
    
    @Column(columnDefinition = "DECIMAL(10,2)")
    private double price;
    
    @CreationTimestamp
    private LocalDate registerDate;

    @ManyToMany(fetch=FetchType.LAZY, cascade=CascadeType.DETACH, mappedBy="etcs")
    private Set<Course> courses = new LinkedHashSet<>();

    
}
