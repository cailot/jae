package hyung.jin.seo.jae.dto;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.fasterxml.jackson.annotation.JsonIgnore;
import hyung.jin.seo.jae.model.Clazz;
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

	private String studentId;

	private String clazzId;

	//private String year;

	public EnrolmentDTO(Enrolment enrol){
		this.id = String.valueOf(enrol.getId());
		this.enrolmentDate = enrol.getEnrolmentDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
		this.cancelled = enrol.isCancelled();
		this.cancellationReason = enrol.getCancellationReason();
		this.studentId = (enrol.getStudent()!=null) ? String.valueOf(enrol.getStudent().getId()) : "";
		this.clazzId = (enrol.getClazz()!=null) ? String.valueOf(enrol.getClazz().getId()) : "";
	}

	public Enrolment convertToEnrolment() {
    	Enrolment enrolement = new Enrolment();
		if(StringUtils.isNotBlank(id)) enrolement.setId(Long.parseLong(id));
    	if(StringUtils.isNotBlank(enrolmentDate)) enrolement.setEnrolmentDate(LocalDate.parse(enrolmentDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));	
		enrolement.setCancelled(cancelled);
		if(StringUtils.isNotBlank(cancellationReason)) enrolement.setCancellationReason(cancellationReason);		
    	return enrolement;
    }

}
