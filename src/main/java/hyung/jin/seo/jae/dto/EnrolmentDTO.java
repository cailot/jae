package hyung.jin.seo.jae.dto;

import java.io.Serializable;
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

	private String studentId;

	private String clazzId;

	private String name;

	private double fee;

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
		this.studentId = (enrol.getStudent()!=null) ? String.valueOf(enrol.getStudent().getId()) : "";
		this.clazzId = (enrol.getClazz()!=null) ? String.valueOf(enrol.getClazz().getId()) : "";
	}

	public Enrolment convertToEnrolment() {
    	Enrolment enrolement = new Enrolment();
		if(StringUtils.isNotBlank(id)) enrolement.setId(Long.parseLong(id));
    	if(StringUtils.isNotBlank(enrolmentDate)) enrolement.setEnrolmentDate(LocalDate.parse(enrolmentDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));	
		enrolement.setCancelled(cancelled);
		enrolement.setStartWeek(startWeek);
		enrolement.setEndWeek(endWeek);
		if(StringUtils.isNotBlank(cancellationReason)) enrolement.setCancellationReason(cancellationReason);		
    	return enrolement;
    }

	public EnrolmentDTO(long id, LocalDate enrolmentDate, boolean cancelled, String cancellationReason, int startWeek, int endWeek, long studentId, long clazzId, String name, double fee, int year, String grade, String day){
		this.id = String.valueOf(id);
		this.clazzId = String.valueOf(clazzId);
		this.enrolmentDate = enrolmentDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
		this.cancelled = cancelled;
		this.cancellationReason = cancellationReason;
		this.startWeek = startWeek;
		this.endWeek = endWeek;
		this.studentId = String.valueOf(studentId);
		this.name = name;
		this.fee = fee;
		this.year = String.valueOf(year);
		this.grade = grade;
		this.day = day;
	}

}
