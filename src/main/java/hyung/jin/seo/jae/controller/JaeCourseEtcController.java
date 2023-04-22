package hyung.jin.seo.jae.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hyung.jin.seo.jae.model.CourseEtc;
import hyung.jin.seo.jae.model.CourseEtcDTO;
import hyung.jin.seo.jae.service.CourseEtcService;
import hyung.jin.seo.jae.utils.JaeConstants;

@Controller
@RequestMapping("courseEtc")
public class JaeCourseEtcController {

	private static final Logger LOG = LoggerFactory.getLogger(JaeCourseEtcController.class);

	@Autowired
	private CourseEtcService courseEtcService;

	// search etc with grade
	// if grade == 'tt8' then get them all
	@GetMapping("/list")
	@ResponseBody
	List<CourseEtcDTO> gradeEtc(@RequestParam("grade") String keyword) {
		List<CourseEtcDTO> dtos = new ArrayList<CourseEtcDTO>();
		
		if(StringUtils.equalsIgnoreCase(keyword, JaeConstants.TT8)){
			List<CourseEtc> ces = courseEtcService.allEtc();
			for (CourseEtc ce : ces) {
				CourseEtcDTO dto = new CourseEtcDTO(ce);
				if (StringUtils.isNotBlank(dto.getName())) // replace escape character single quote
				{
					String newName = dto.getName().replaceAll("\'", "&#39;");
					dto.setName(newName);
				}
				dtos.add(dto);
			}
		}else { // exclude VSSEs
			List<CourseEtc> ces = courseEtcService.notNameEtc();
			for (CourseEtc ce : ces) {
				CourseEtcDTO dto = new CourseEtcDTO(ce);
				if (StringUtils.isNotBlank(dto.getName())) // replace escape character single quote
				{
					String newName = dto.getName().replaceAll("\'", "&#39;");
					dto.setName(newName);
				}
				dtos.add(dto);
			}
		}
		return dtos;
	}

		
		
	// count records number in database
	@GetMapping("/count")
	@ResponseBody
	long coutEtc() {
		long count = courseEtcService.checkCount();
		return count;
	}
}
