package hyung.jin.seo.jae.model;

import java.io.Serializable;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
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
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

//@Getter
//@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="Teacher")
public class Teacher implements Serializable{
    
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // auto increment
    private Long id;
    
    @Column(length = 200, nullable = false)
    private String firstName;
    
    @Column(length = 200, nullable = false)
    private String lastName;
    
    @Column(length = 5, nullable = true)
    private String title;
    
    @Column(length = 200, nullable = true)
    private String phone;
    
    @Column(length = 300, nullable = true)
    private String email;
    
    @Column(length = 500, nullable = true)
    private String address;
    
    @Column(length = 30, nullable = true)
    private String state;
    
    @Column(length = 50, nullable = true)
    private String branch;
    
    @Column(length = 1000, nullable = true)
    private String memo;
    
    @Column(length = 50, nullable = true)
    private String bank;
        
    @Column(length = 10, nullable = true)
    private String bsb;

    @Column(length = 15, nullable = true)
    private Long accountNumber;
    
    @Column(length = 50, nullable = true)
    private String superannuation;
    
    @Column(length = 20, nullable = true)
    private String superMember;
    
    @Column(length = 15, nullable = true)
    private Long tfn;
    
    @Override
	public String toString() {
		return "Teacher [id=" + id + ", firstName=" + firstName + ", lastName=" + lastName + ", title=" + title
				+ ", phone=" + phone + ", email=" + email + ", address=" + address + ", state=" + state + ", branch="
				+ branch + ", memo=" + memo + ", bank=" + bank + ", bsb=" + bsb + ", accountNumber=" + accountNumber
				+ ", superannuation=" + superannuation + ", superMember=" + superMember + ", tfn=" + tfn
				+ ", startDate=" + startDate + ", endDate=" + endDate + "]";
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getBranch() {
		return branch;
	}

	public void setBranch(String branch) {
		this.branch = branch;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getBsb() {
		return bsb;
	}

	public void setBsb(String bsb) {
		this.bsb = bsb;
	}

	public Long getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(Long account) {
		this.accountNumber = account;
	}

	public String getSuperannuation() {
		return superannuation;
	}

	public void setSuperannuation(String superannuation) {
		this.superannuation = superannuation;
	}

	public String getSuperMember() {
		return superMember;
	}

	public void setSuperMember(String superMember) {
		this.superMember = superMember;
	}

	public Long getTfn() {
		return tfn;
	}

	public void setTfn(Long tfn) {
		this.tfn = tfn;
	}

	public LocalDate getStartDate() {
		return startDate;
	}

	public void setStartDate(LocalDate startDate) {
		this.startDate = startDate;
	}

	public LocalDate getEndDate() {
		return endDate;
	}

	public void setEndDate(LocalDate endDate) {
		this.endDate = endDate;
	}

	@CreationTimestamp
    private LocalDate startDate;
    
    @CreatedDate
    private LocalDate endDate;
    
   }
