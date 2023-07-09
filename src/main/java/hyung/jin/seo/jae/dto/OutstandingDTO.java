package hyung.jin.seo.jae.dto;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import org.apache.commons.lang3.StringUtils;

import hyung.jin.seo.jae.model.Outstanding;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class OutstandingDTO extends MoneyDTO{
    
	// private String id;

	// private String registerDate;

	private double paid;

	private double remaining;

	// private double amount;

	private String invoiceId;

	public OutstandingDTO(Outstanding stand){
		this.id = String.valueOf(stand.getId());
		this.registerDate = stand.getRegisterDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
		this.paid = stand.getPaid();
		this.remaining = stand.getRemaining();
		this.amount = stand.getAmount();
	}

	public OutstandingDTO(long id, double paid, double remaining, double amount, LocalDate registerDate, long invoiceId){
		this.id = String.valueOf(id);
		this.registerDate = registerDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
		this.paid = paid;
		this.remaining = remaining;
		this.amount = amount;
		this.invoiceId = String.valueOf(invoiceId);
	}

	public Outstanding convertToOutstanding() {
    	Outstanding stand = new Outstanding();
		if(StringUtils.isNotBlank(id)) stand.setId(Long.parseLong(id));
    	if(StringUtils.isNotBlank(registerDate)) stand.setRegisterDate(LocalDate.parse(registerDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));	
		stand.setPaid(paid);
		stand.setRemaining(remaining);
		stand.setAmount(amount);
		return stand;
    }


}
