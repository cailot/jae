package hyung.jin.seo.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;

import hyung.jin.seo.jae.model.StudentDTO;

public class JaeUtils {

	public static Map ACADEMIC_START_DAY;
	
	static {
		 ACADEMIC_START_DAY = new HashMap();
		 ACADEMIC_START_DAY.put("2020", "14/06");
		 ACADEMIC_START_DAY.put("2021", "13/06");
		 ACADEMIC_START_DAY.put("2022", "12/06");
		 ACADEMIC_START_DAY.put("2023", "11/06");
		 ACADEMIC_START_DAY.put("2024", "09/06");
		 ACADEMIC_START_DAY.put("2025", "08/06");
		 ACADEMIC_START_DAY.put("2026", "07/06");
		 ACADEMIC_START_DAY.put("2027", "06/06");
		 ACADEMIC_START_DAY.put("2028", "04/06");
		 ACADEMIC_START_DAY.put("2029", "03/06");
		 ACADEMIC_START_DAY.put("2030", "02/06");
		 ACADEMIC_START_DAY.put("2031", "01/06");
		 ACADEMIC_START_DAY.put("2032", "30/05");
		 ACADEMIC_START_DAY.put("2033", "29/05");
	}
	
	public static SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
	
	// return academic year.
	// for example, today is 17/04/2023 while academic year in 2023 is 11/06/2023 then it will return '2022'
	// however, if today is 17/09/2023, it will return '2023' as academic calendar date (11/06/2023) already passed.
	public static int academicYear() {
		Calendar today = Calendar.getInstance();
		int currentYear = today.get(Calendar.YEAR);
		int academicYear = currentYear;
		
		String academicDate = (String) ACADEMIC_START_DAY.get(Integer.toString(currentYear));
		String dateString = academicDate + "/" + currentYear;
		//SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
		try {
			Date specifiedDate = dateFormat.parse(dateString);
			Calendar speicifedAcademic = Calendar.getInstance();
			speicifedAcademic.setTime(specifiedDate);
			
			if(today.before(speicifedAcademic)) { // return 'currentYear - 1'
				academicYear = currentYear-1;
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return academicYear;
	}
	
	
	public static int academicWeeks() {
		Calendar today = Calendar.getInstance();
		int currentYear = today.get(Calendar.YEAR);
		int academicYear = academicYear();
		int weeks = 0;
		if(currentYear==academicYear) {
			
		}else {
			
		}
		return weeks;
	}
}
