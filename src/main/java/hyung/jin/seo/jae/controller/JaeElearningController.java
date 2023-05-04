package hyung.jin.seo.jae.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hyung.jin.seo.jae.dto.ElearningDTO;
import hyung.jin.seo.jae.model.Elearning;
import hyung.jin.seo.jae.service.ElearningService;

@Controller
@RequestMapping("elearning")
public class JaeElearningController {

	private static final Logger LOG = LoggerFactory.getLogger(JaeElearningController.class);

	@Autowired
	private ElearningService elearningService;

	
	// register new student
	@PostMapping("/register")
	@ResponseBody
	public ElearningDTO registerStudent(@RequestBody ElearningDTO formData) {
		Elearning crs = formData.convertToCourse();
		crs = elearningService.addElearning(crs);
		ElearningDTO dto = new ElearningDTO(crs);
		return dto;
	}

	// search course with grade
	@GetMapping("/gradeCourse")
	@ResponseBody
	List<ElearningDTO> listCourses(@RequestParam("grade") String keyword) {
		List<Elearning> crss = elearningService.gradeElearnings(keyword);
		List<ElearningDTO> dtos = new ArrayList<ElearningDTO>();
		for (Elearning crs : crss) {
			ElearningDTO dto = new ElearningDTO(crs);
			if (StringUtils.isNotBlank(dto.getName())) // replace escape character single quote
			{
				String newName = dto.getName().replaceAll("\'", "&#39;");
				dto.setName(newName);
			}
			dtos.add(dto);
		}
		return dtos;
	}

	// search course with grade
	@GetMapping("/grade")
	@ResponseBody
	List<ElearningDTO> gradeCourses(@RequestParam("grade") String keyword) {
		List<Elearning> crss = elearningService.gradeElearnings(keyword);
		List<ElearningDTO> dtos = new ArrayList<ElearningDTO>();
		for (Elearning crs : crss) {
			ElearningDTO dto = new ElearningDTO(crs);
			if (StringUtils.isNotBlank(dto.getName())) // replace escape character single quote
			{
				String newName = dto.getName().replaceAll("\'", "&#39;");
				dto.setName(newName);
			}
			dtos.add(dto);
		}
		return dtos;
	}

	
	// search course with grade
	@GetMapping("/no_grade")
	@ResponseBody
	List<ElearningDTO> noGradeCourses(@RequestParam("grade") String keyword) {
		List<Elearning> crss = elearningService.notGradeElearnings(keyword);
		List<ElearningDTO> dtos = new ArrayList<ElearningDTO>();
		for (Elearning crs : crss) {
			ElearningDTO dto = new ElearningDTO(crs);
			if (StringUtils.isNotBlank(dto.getName())) // replace escape character single quote
			{
				String newName = dto.getName().replaceAll("\'", "&#39;");
				dto.setName(newName);
			}
			dtos.add(dto);
		}
		return dtos;
	}

	
	// update existing course
	@PutMapping("/update")
	@ResponseBody
	public ElearningDTO updateStudent(@RequestBody ElearningDTO formData) {
		Elearning crs = formData.convertToCourse();
		crs = elearningService.updateElearning(crs, crs.getId());
		ElearningDTO dto = new ElearningDTO(crs);
		return dto;
	}

	// de-activate course by Id
	@PutMapping("/inactivate/{id}")
	@ResponseBody
	public void inactivateCourse(@PathVariable Long id) {
		elearningService.dischargeElearning(id);
	}
	
	
	// list all courses
	@GetMapping("/list")
	@ResponseBody
	List<ElearningDTO> allCourses() {
		List<Elearning> crss = elearningService.availableElearnings();
		List<ElearningDTO> dtos = new ArrayList<ElearningDTO>();
		for(Elearning crs : crss) {
			ElearningDTO dto = new ElearningDTO(crs);
			if (StringUtils.isNotBlank(dto.getName())) // replace escape character single quote
			{
				String newName = dto.getName().replaceAll("\'", "&#39;");
				dto.setName(newName);
			}
			dtos.add(dto);
		}
        return dtos;
	}
	
	// list available courses
	@GetMapping("/available")
	@ResponseBody
	List<ElearningDTO> availableCourses() {
		List<Elearning> crss = elearningService.availableElearnings();
		List<ElearningDTO> dtos = new ArrayList<ElearningDTO>();
		for(Elearning crs : crss) {
			ElearningDTO dto = new ElearningDTO(crs);
			if (StringUtils.isNotBlank(dto.getName())) // replace escape character single quote
			{
				String newName = dto.getName().replaceAll("\'", "&#39;");
				dto.setName(newName);
			}
			dtos.add(dto);
		}
        return dtos;
	}
}
