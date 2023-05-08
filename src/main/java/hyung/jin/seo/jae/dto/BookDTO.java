package hyung.jin.seo.jae.dto;

import java.io.Serializable;
import hyung.jin.seo.jae.model.Book;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class BookDTO implements Serializable{
    
	private String id;
    
    private String grade;
    
    private String name;
         
    private String price;
    
    private String registerDate;
    
	private List<String> subjects = new ArrayList<>();

	public BookDTO(Book cb) {
    	this.id = (cb.getId()!=null) ? cb.getId().toString() : "";
    	this.grade = (cb.getGrade()!=null) ? cb.getGrade() : "";
    	this.name = (cb.getName()!=null) ? cb.getName() : "";
    	this.price = (cb.getPrice()!=0.0) ? Double.toString(cb.getPrice()): "0.0";
    	//this.registerDate = (cb.getRegisterDate()!=null) ? cb.getRegisterDate().toString() : "";
    }
    
    // public Book convertToBook() {
    // 	Book cb = new Book();
    // 	if(StringUtils.isNotBlank(id)) cb.setId(Long.parseLong(this.id));
    // 	if(StringUtils.isNotBlank(grade)) cb.setGrade(this.grade);
    // 	if(StringUtils.isNotBlank(name)) cb.setName(this.name);
    // 	if(StringUtils.isNotBlank(price)) cb.setPrice(Double.parseDouble(this.price));
    // 	if(StringUtils.isNotBlank(registerDate)) cb.setRegisterDate(LocalDate.parse(registerDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));
    // 	return cb;
    // }
}
