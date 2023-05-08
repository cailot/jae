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
    }
    
    public void addSubject(String subject){
        subjects.add(subject);
    }
  }
