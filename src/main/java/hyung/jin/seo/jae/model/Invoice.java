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
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.springframework.data.annotation.CreatedDate;

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
    
	// @OneToOne
	// @JoinColumn(name = "enrolmentId")
	// private Enrolment enrolment;
	
	
	@OneToMany(fetch = FetchType.LAZY)
	@JoinColumn(name = "invoiceId")
	private Set<Enrolment> enrolments = new LinkedHashSet<>();

	public void addEnrolment(Enrolment enrolment){
		enrolments.add(enrolment);
	}

	@OneToOne(fetch = FetchType.LAZY, cascade = {
		CascadeType.PERSIST,
		CascadeType.MERGE,
		CascadeType.REFRESH,
		CascadeType.DETACH
	})
	private Payment payment;
	
	// @OneToMany(fetch = FetchType.LAZY, cascade = {
	// 	CascadeType.PERSIST,
	// 	CascadeType.MERGE,
	// 	CascadeType.REFRESH,
	// 	CascadeType.DETACH
	// })
	// @JoinColumn(name = "invoiceId")
	// private Set<Payment> payments = new LinkedHashSet<>();

	// public void addPayment(Payment payment){
	// 	payments.add(payment);
	// }

	// auto update to current date
	@CreationTimestamp
    private LocalDate registerDate;

	@CreatedDate
    private LocalDate payCompleteDate;

	@Column
    private double credit;

	@Column
    private double discount;

	@Column
    private double totalAmount;

	@Column
	private double paidAmount;

}
