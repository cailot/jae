package hyung.jin.seo.jae.dto;

import java.io.Serializable;
import org.apache.commons.lang3.StringUtils;

import com.fasterxml.jackson.annotation.JsonIgnore;

import hyung.jin.seo.jae.model.CourseEtc;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class CourseEtcDTO implements Serializable{
    
	private String id;
    
    private String name;
    
    private String price;

	@JsonIgnore
    private String registerDate; // no need to be parsed. just for the sake of completeness

	public CourseEtcDTO(CourseEtc cf) {
    	this.id = (cf.getId()!=null) ? cf.getId().toString() : "";
    	this.name = (cf.getName()!=null) ? cf.getName() : "";
    	this.price = (cf.getPrice()!=0.0) ? Double.toString(cf.getPrice()): "0.0";
    	// this.registerDate = (cf.getRegisterDate()!=null) ? cf.getRegisterDate().toString() : "";
    }
    
    public CourseEtc convertToCourseEtc() {
    	CourseEtc ce = new CourseEtc();
    	if(StringUtils.isNotBlank(id)) ce.setId(Long.parseLong(this.id));
    	if(StringUtils.isNotBlank(name)) ce.setName(this.name);
    	if(StringUtils.isNotBlank(price)) ce.setPrice(Double.parseDouble(this.price));
    	// if(StringUtils.isNotBlank(registerDate)) ce.setRegisterDate(LocalDate.parse(registerDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));
    	return ce;
    }
}
