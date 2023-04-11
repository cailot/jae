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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.time.LocalDateTime;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

//@Getter
//@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="Subject")
public class Subject implements Serializable{
    
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getAbr() {
		return abr;
	}

	public void setAbr(String abr) {
		this.abr = abr;
	}

	public LocalDate getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(LocalDate registerDate) {
		this.registerDate = registerDate;
	}

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

	@Override
	public String toString() {
		return "Subject [id=" + id + ", name=" + name + ", description=" + description + ", abr=" + abr
				+ ", registerDate=" + registerDate + "]";
	}
    
 }
