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
// test...from sts 1

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
    private Long id;
    
    @Column(length = 200, nullable = false)
    private String firstName;
    
    @Column(length = 200, nullable = false)
    private String lastName;
    
    @Column(length = 10, nullable = false)
    private String grade;
    
    @Column(length = 200, nullable = false)
    private String contactNo1;
    
    @Column(length = 200, nullable = false)
    private String contactNo2;
    
    @Column(length = 300, nullable = false)
    private String email;
    
    @Column(length = 500, nullable = false)
    private String address;
    
    @Column(length = 3, nullable = false)
    private String state;
    
    @Column(length = 50, nullable = false)
    private String branch;
    
    @Column(length = 1000, nullable = false)
    private String memo;
    
    @CreationTimestamp
    private LocalDate registerDate;
    
    @UpdateTimestamp
    private LocalDate enrolmentDate;
    
    @CreatedDate
    private LocalDate endDate;
    
}
