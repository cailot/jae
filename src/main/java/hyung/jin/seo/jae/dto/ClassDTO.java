package hyung.jin.seo.jae.dto;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import hyung.jin.seo.jae.model.Class;

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

	private String name;
   
   private String description; // Course.description

	private String day;

	private String startDate;

	private boolean active;

    @JsonIgnore
	private String courseId;

	@JsonIgnore
	private String cycleId;

	@JsonIgnore
	private String grade; // Course.grade

	private String year; // Cycle.year

	private List<String> subjects = new ArrayList<>();

	public void addSubject(String subject){
		subjects.add(subject);
	}

	public ClassDTO(long id, double fee, String name, String day, LocalDate startDate, boolean active, long courseId, long cycleId, String grade, String description, int year) {
		this.id = Long.toString(id);
		this.fee = Double.toString(fee);
		this.name = name;
		this.day = day;
		this.startDate = DateTimeFormatter.ofPattern("dd/MM/yyyy").format(startDate);
		this.active = active;
		this.courseId = Long.toString(courseId);
		this.cycleId = Long.toString(cycleId);
		this.grade = grade;
		this.description = description;	
		this.year = Integer.toString(year);
	}

	public ClassDTO(Class clazz){
		this.id = Long.toString(clazz.getId());
		this.fee = Double.toString(clazz.getFee());
		this.name = clazz.getName();
		this.day = clazz.getDay();
		this.startDate = DateTimeFormatter.ofPattern("dd/MM/yyyy").format(clazz.getStartDate());
		this.active = clazz.isActive();
		this.courseId = Long.toString(clazz.getCourse().getId());
		this.cycleId = Long.toString(clazz.getCycle().getId());
		this.grade = clazz.getCourse().getGrade();
		this.description = clazz.getCourse().getDescription();
		this.year = Integer.toString(clazz.getCycle().getYear());
	}
}
