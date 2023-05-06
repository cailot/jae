package hyung.jin.seo.jae.dto;

import java.io.Serializable;
import org.apache.commons.lang3.StringUtils;

import hyung.jin.seo.jae.model.Book;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import java.time.format.DateTimeFormatter;
import java.time.LocalDate;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class BookDTO implements Serializable{
    
	private String id;
    
    private String grade;
    
    private String name;
    
    private String year;
    
    private String subjects;
    
    private String price;
    
    private String registerDate;
    

	public BookDTO(Book cb) {
    	this.id = (cb.getId()!=null) ? cb.getId().toString() : "";
    	this.grade = (cb.getGrade()!=null) ? cb.getGrade() : "";
    	this.name = (cb.getName()!=null) ? cb.getName() : "";
    	this.year = (cb.getYear()!=null) ? cb.getYear(): "";
    	// this.subjects = (cb.getSubjects()!=null) ? cb.getSubjects() : "";
    	this.price = (cb.getPrice()!=0.0) ? Double.toString(cb.getPrice()): "0.0";
    	this.registerDate = (cb.getRegisterDate()!=null) ? cb.getRegisterDate().toString() : "";
    }
    
    public Book convertToBook() {
    	Book cb = new Book();
    	if(StringUtils.isNotBlank(id)) cb.setId(Long.parseLong(this.id));
    	if(StringUtils.isNotBlank(grade)) cb.setGrade(this.grade);
    	if(StringUtils.isNotBlank(name)) cb.setName(this.name);
    	if(StringUtils.isNotBlank(year)) cb.setYear(this.year);
    	// if(StringUtils.isNotBlank(subjects)) cb.setSubjects(this.subjects);
    	if(StringUtils.isNotBlank(price)) cb.setPrice(Double.parseDouble(this.price));
    	if(StringUtils.isNotBlank(registerDate)) cb.setRegisterDate(LocalDate.parse(registerDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));
    	return cb;
    }
}
