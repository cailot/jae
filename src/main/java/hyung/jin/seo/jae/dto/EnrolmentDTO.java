package hyung.jin.seo.jae.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import org.apache.commons.lang3.StringUtils;

import hyung.jin.seo.jae.model.Enrolment;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class EnrolmentDTO implements Serializable{
    
	private String id;

	private String enrolmentDate;

	private boolean cancelled;

	private String cancellationReason;

	private int startWeek;

	private int endWeek;

	private double credit;

	private double discount;

	private double amount;

	private double paid;

	private String payCompleteDate;

	private String studentId;

	private String clazzId;

	private String invoiceId;

	private String name;

	private double price;

	private String grade;

	private String year;

	private String day;

	public EnrolmentDTO(Enrolment enrol){
		this.id = String.valueOf(enrol.getId());
		this.enrolmentDate = enrol.getEnrolmentDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
		this.cancelled = enrol.isCancelled();
		this.cancellationReason = enrol.getCancellationReason();
		this.startWeek = enrol.getStartWeek();
		this.endWeek = enrol.getEndWeek();
		// this.credit = enrol.getCredit();
		// this.discount = enrol.getDiscount();
		// this.amount = enrol.getAmount();
		this.studentId = (enrol.getStudent()!=null) ? String.valueOf(enrol.getStudent().getId()) : "";
		this.clazzId = (enrol.getClazz()!=null) ? String.valueOf(enrol.getClazz().getId()) : "";
		this.invoiceId = (enrol.getInvoice()!=null) ? String.valueOf(enrol.getInvoice().getId()) : "";
	}

	public Enrolment convertToEnrolment() {
    	Enrolment enrolement = new Enrolment();
		if(StringUtils.isNotBlank(id)) enrolement.setId(Long.parseLong(id));
    	if(StringUtils.isNotBlank(enrolmentDate)) enrolement.setEnrolmentDate(LocalDate.parse(enrolmentDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));	
		enrolement.setCancelled(cancelled);
		enrolement.setStartWeek(startWeek);
		enrolement.setEndWeek(endWeek);
		// enrolement.setCredit(credit);
		// enrolement.setDiscount(discount);
		// enrolement.setAmount(amount);
		if(StringUtils.isNotBlank(payCompleteDate)) enrolement.setEnrolmentDate(LocalDate.parse(payCompleteDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));	
		if(StringUtils.isNotBlank(cancellationReason)) enrolement.setCancellationReason(cancellationReason);		
    	return enrolement;
    }

	public EnrolmentDTO(long id, LocalDate enrolmentDate, boolean cancelled, String cancellationReason, int startWeek, 
	int endWeek, double credit, double discount, double amount, double paid, LocalDate payDate, long studentId, 
	long clazzId, String name, double price, int year, String grade, String day){
		this.id = String.valueOf(id);
		this.enrolmentDate = enrolmentDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
		this.cancelled = cancelled;
		this.cancellationReason = cancellationReason;
		this.startWeek = startWeek;
		this.endWeek = endWeek;
		this.credit = credit;
		this.amount	= amount;
		this.paid = paid;
		this.discount = discount;
		this.payCompleteDate = (payDate != null) ? payDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : null;
		this.studentId = String.valueOf(studentId);
		this.clazzId = String.valueOf(clazzId);
		this.name = name;
		this.price = price;
		this.year = String.valueOf(year);
		this.grade = grade;
		this.day = day;
	}

	public EnrolmentDTO(long id, LocalDate enrolmentDate, boolean cancelled, String cancellationReason, int startWeek, int endWeek, long studentId, long clazzId, String name, double price, int year, String grade, String day){
		this.id = String.valueOf(id);
		this.enrolmentDate = enrolmentDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
		this.cancelled = cancelled;
		this.cancellationReason = cancellationReason;
		this.startWeek = startWeek;
		this.endWeek = endWeek;
		// this.credit = credit;
		// this.amount	= amount;
		// this.paid = paid;
		// this.discount = discount;
		this.studentId = String.valueOf(studentId);
		this.clazzId = String.valueOf(clazzId);
		this.name = name;
		this.price = price;
		this.year = String.valueOf(year);
		this.grade = grade;
		this.day = day;
	}



	public EnrolmentDTO(Object[] obj){
		this.id = (obj[0]!=null) ? String.valueOf(obj[0]) : null;
		this.enrolmentDate = (obj[1]!=null) ? String.valueOf(obj[1]) : null;
		this.cancelled = (obj[2]!=null) ? (boolean)obj[2] : false;
		this.cancellationReason = (obj[3]!=null) ? (String)obj[3] : null;
		this.startWeek = (obj[4]!=null) ? (int)obj[4] : 0;
		this.endWeek = (obj[5]!=null) ? (int)obj[5] : 0;		
		this.credit = (obj[6]!=null) ? Double.parseDouble(String.valueOf(obj[6])) : 0;
		this.amount = (obj[7]!=null) ? Double.parseDouble(String.valueOf(obj[7])) : 0;
		this.paid = (obj[8]!=null) ? Double.parseDouble(String.valueOf(obj[8])) : 0;
		this.discount = (obj[9]!=null) ? Double.parseDouble(String.valueOf(obj[9])) : 0;
		this.payCompleteDate =  (obj[10]!=null) ? String.valueOf(obj[10]) : null;
		this.studentId = (obj[11]!=null) ? String.valueOf(obj[11]) : null;
		this.clazzId = (obj[12]!=null) ? String.valueOf(obj[12]) : null;
		this.name = (obj[13]!=null) ? (String)obj[13] : null;
		this.price = (obj[14]!=null) ? Double.parseDouble(String.valueOf(obj[14])) : 0;
		this.year = (obj[15]!=null) ? String.valueOf(obj[15]) : null;
		this.grade = (obj[16]!=null) ? (String)obj[16] : null;
		this.day = (obj[17]!=null) ? (String)obj[17] : null;
	}

}
