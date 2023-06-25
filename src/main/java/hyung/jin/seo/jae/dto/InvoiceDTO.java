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

	private String payCompleteDate;

	private double credit;

	private double discount;

	private double totalAmount;

	private double paidAmount;

	private String enrolmentId;


	public InvoiceDTO(Invoice invoice){
		this.id = String.valueOf(invoice.getId());
		this.registerDate = invoice.getRegisterDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
		if(invoice.getPayCompleteDate() != null) {
			this.payCompleteDate = invoice.getPayCompleteDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
		}
		this.credit = invoice.getCredit();
		this.discount = invoice.getDiscount();
		this.totalAmount = invoice.getTotalAmount();
		this.paidAmount = invoice.getPaidAmount();
	}

	public Invoice convertToOnlyInvoice() {
    	Invoice invoice = new Invoice();
		if(StringUtils.isNotBlank(id)) invoice.setId(Long.parseLong(id));
    	if(StringUtils.isNotBlank(registerDate)) invoice.setRegisterDate(LocalDate.parse(registerDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));	
		if(StringUtils.isNotBlank(payCompleteDate)) invoice.setPayCompleteDate(LocalDate.parse(payCompleteDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));	
		invoice.setCredit(credit);
		invoice.setDiscount(discount);
		invoice.setTotalAmount(totalAmount);
		invoice.setPaidAmount(paidAmount);
		return invoice;
    }

	public InvoiceDTO(long id, double credit, double discount, double paidAmount, double totalAmount, LocalDate registerDate, LocalDate payCompleteDate){
		this.id = String.valueOf(id);
		this.credit = credit;
		this.discount = discount;
		this.paidAmount = paidAmount;
		this.totalAmount = totalAmount;
		this.registerDate = (registerDate!=null) ? registerDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : null;
		this.payCompleteDate = (payCompleteDate!=null) ? payCompleteDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : null;
	}

}
