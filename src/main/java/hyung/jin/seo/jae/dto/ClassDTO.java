package hyung.jin.seo.jae.dto;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class ClassDTO implements Serializable{
    
	private String id;
    
    private String fee;
    
    private String description;
    
	private String courseId;

	private String cycleId;

	private String grade; // Course.grade

	private String day; // Course.day

	private String year; // Cycle.year

	//ClassDTO(c.id, c.fee, c.description, c.course.id, c.cycle.id, c.course.grade, c.course.day, c.cycle.year) 
	//long, double, java.lang.String, long, long, java.lang.String, java.lang.String, int
	public ClassDTO(long id, double fee, String description, long courseId, long cycleId, String grade, String day, int year) {
		this.id = Long.toString(id);
		this.fee = Double.toString(fee);
		this.description = description;
		this.courseId = Long.toString(courseId);
		this.cycleId = Long.toString(cycleId);
		this.grade = grade;
		this.day = day;
		this.year = Integer.toString(year);
	}

}
