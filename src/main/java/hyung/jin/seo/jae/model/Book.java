package hyung.jin.seo.jae.model;

import org.hibernate.annotations.CreationTimestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Column;
import java.time.LocalDate;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="Book")
public class Book {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // auto increment
    private Long id;
    
    @Column(length = 30, nullable = false)
    private String name;
    
    @Column(length = 10, nullable = false)
    private String grade;
    
    @Column(columnDefinition = "DECIMAL(10,2)")
    private double price;
    
    @Column(length = 10, nullable = true)
    private String year;
    
    @CreationTimestamp
    private LocalDate registerDate;

	
}
