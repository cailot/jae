package hyung.jin.seo.jae.dto;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import org.apache.commons.lang3.StringUtils;

import hyung.jin.seo.jae.model.Invoice;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class InvoiceDTO implements Serializable{
    
	private String id;

	private String registerDate;

	private double credit;

	private double discount;

	private double amount;

	private String enrolmentId;


	public InvoiceDTO(Invoice invoice){
		this.id = String.valueOf(invoice.getId());
		this.registerDate = invoice.getRegisterDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
		this.credit = invoice.getCredit();
		this.discount = invoice.getDiscount();
		this.amount = invoice.getAmount();
	}

	public Invoice convertToOnlyInvoice() {
    	Invoice invoice = new Invoice();
		if(StringUtils.isNotBlank(id)) invoice.setId(Long.parseLong(id));
    	if(StringUtils.isNotBlank(registerDate)) invoice.setRegisterDate(LocalDate.parse(registerDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));	
		invoice.setCredit(credit);
		invoice.setDiscount(discount);
		invoice.setAmount(amount);
		return invoice;
    }

	// public InvoiceDTO(long id, LocalDate enrolmentDate, boolean cancelled, String cancellationReason, int startWeek, int endWeek, long studentId, long clazzId, String name, double price, int year, String grade, String day){
	// 	this.id = String.valueOf(id);
	// 	this.clazzId = String.valueOf(clazzId);
	// 	this.enrolmentDate = enrolmentDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
	// 	this.cancelled = cancelled;
	// 	this.cancellationReason = cancellationReason;
	// 	this.startWeek = startWeek;
	// 	this.endWeek = endWeek;
	// 	this.studentId = String.valueOf(studentId);
	// 	this.name = name;
	// 	this.price = price;
	// 	this.year = String.valueOf(year);
	// 	this.grade = grade;
	// 	this.day = day;
	// }

}
