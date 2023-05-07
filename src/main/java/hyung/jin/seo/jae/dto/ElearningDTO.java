package hyung.jin.seo.jae.dto;

import java.io.Serializable;
import org.apache.commons.lang3.StringUtils;
import hyung.jin.seo.jae.model.Elearning;
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
public class ElearningDTO implements Serializable {

	private String id;

	private String grade;

	private String name;

	private String year;

	private String registerDate;

	private String endDate;

	public ElearningDTO(Elearning crs) {
		this.id = (crs.getId() != null) ? crs.getId().toString() : "";
		this.grade = (crs.getGrade() != null) ? crs.getGrade() : "";
		this.name = (crs.getName() != null) ? crs.getName() : "";
		this.year = (crs.getYear() != null) ? crs.getYear() : "";
		this.registerDate = (crs.getRegisterDate() != null) ? crs.getRegisterDate().toString() : "";
		this.endDate = (crs.getEndDate() != null) ? crs.getEndDate().toString() : "";

	}

	public Elearning convertToCourse() {
		Elearning crs = new Elearning();
		if (StringUtils.isNotBlank(id))
			crs.setId(Long.parseLong(this.id));
		if (StringUtils.isNotBlank(grade))
			crs.setGrade(this.grade);
		if (StringUtils.isNotBlank(name))
			crs.setName(this.name);
		if (StringUtils.isNotBlank(year))
			crs.setYear(this.year);
		if (StringUtils.isNotBlank(registerDate))
			crs.setRegisterDate(LocalDate.parse(registerDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));
		if (StringUtils.isNotBlank(endDate))
			crs.setEndDate(LocalDate.parse(endDate, DateTimeFormatter.ofPattern("dd/MM/yyyy")));

		return crs;
	}

}
