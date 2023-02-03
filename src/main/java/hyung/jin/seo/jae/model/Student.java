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
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Column;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.time.LocalDateTime;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;


@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="Student")
public class Student implements Serializable{
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // auto increment
    public Long id;
    
    @Column(length = 200, nullable = false)
    public String firstName;
    
    @Column(length = 200, nullable = false)
    public String lastName;
    
    @Column(length = 10, nullable = false)
    public String grade;
    
    @Column(length = 200, nullable = false)
    public String contactNo1;
    
    @Column(length = 200, nullable = false)
    public String contactNo2;
    
    @Column(length = 300, nullable = false)
    public String email;
    
    @Column(length = 500, nullable = false)
    public String address;
    
    @Column(length = 3, nullable = false)
    public String state;
    
    @Column(length = 50, nullable = false)
    public String branch;
    
    @Column(length = 1000, nullable = false)
    public String memo;
    
    @CreationTimestamp
    public LocalDate registerDate;
    
    @UpdateTimestamp
    public LocalDate enrolmentDate;
    
    @CreatedDate
    public LocalDate endDate;
    
}
