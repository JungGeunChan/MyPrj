package com.myprj.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myprj.domain.AttachImgVO;
import com.myprj.domain.Criteria;
import com.myprj.domain.MuseumCategoryVO;
import com.myprj.domain.MuseumVO;
import com.myprj.domain.PageDTO;
import com.myprj.service.MuseumService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@RequestMapping("/admin/*")
@Log4j
public class AdminController {
	@Autowired
	private MuseumService museum_service;
	
	@GetMapping("/adminCreate")
	public void adminCreate_get() {
		log.info("박물관 등록 페이지");
	}
	
	@PostMapping("/adminCreate")
	public String adminCreate_post(MuseumVO museum, MuseumCategoryVO museumCategory, RedirectAttributes rttr, @RequestParam(value="themeCode") int themeCode, @RequestParam(value="areaCode") int areaCode) {
		if(!museum.getMuseumHomepage().contains("https://")) {
			museum.setMuseumHomepage("https://" + museum.getMuseumHomepage());
		}
		
		museum_service.insertMuseum(museum);
		museum_service.insertMuseumCategory(museum, museumCategory);

		if(museum.getAttachList() != null) {
			museum.getAttachList().forEach(attach -> log.info(attach));
		}
		
		return "redirect:/admin/adminRead";
	}
	
	@GetMapping("/adminRead")
	public void adminRead_get(Criteria cri, Model model) {
		log.info("박물관 조회 페이지.");
		try {
			List<MuseumVO> list = museum_service.museumGetList(cri);
			int total = museum_service.museumGetTotal(cri);
			
			if(total > 0) { // 검색결과 존재
				model.addAttribute("result", 1);
				model.addAttribute("list", list);
			} else { // 검색결과 없음
				model.addAttribute("result", 0);
			}
			model.addAttribute("pageMaker", new PageDTO(cri, total));
			log.info(cri);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@GetMapping({"/adminDetail", "/adminUpdate"})
	public void adminDetail_get(@RequestParam("museumNo") int museumNo, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("상세페이지 or 수정페이지");	
		model.addAttribute("museum", museum_service.adminMuseumDetail(museumNo));
		model.addAttribute("museumCategory", museum_service.getMuseumCategoryList(museumNo));
	}
	
	@PostMapping("/adminUpdate")
	public String adminUpdate_post(@ModelAttribute("cri") Criteria cri, MuseumVO museum, MuseumCategoryVO museumCategory, @RequestParam(value="themeCode") int themeCode, @RequestParam(value="areaCode") int areaCode, RedirectAttributes rttr) {
		if(!museum.getMuseumHomepage().contains("https://")) {
			museum.setMuseumHomepage("https://" + museum.getMuseumHomepage());
		}
		
		if(museum_service.museumUpdate(museum)) {
			museum_service.insertMuseumCategory(museum, museumCategory);
			rttr.addFlashAttribute("updateResult", "success");
		} else {
			rttr.addFlashAttribute("updateResult", "false");
		}		
		return "redirect:/admin/adminRead" + cri.getListLink();
	}
	
	private void deleteFiles(List<AttachImgVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("c:\\upload\\" + attach.getMuseumImgUploadPath() + "\\" + attach.getMuseumImgUuid() + "_" + attach.getMuseumImgFileName());			
				Files.deleteIfExists(file);		
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("c:\\upload\\" + attach.getMuseumImgUploadPath() + "\\s_" + attach.getMuseumImgUuid() + "_" + attach.getMuseumImgFileName());
					Files.delete(thumbNail);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
	}
	
	@PostMapping("/adminDelete")
	public String adminDelete_post(@RequestParam("museumNo") int museumNo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		List<AttachImgVO> attachList = museum_service.getAttachList(museumNo);
		
		if(museum_service.museumDelete(museumNo)) {			
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/admin/adminRead" + cri.getListLink();
	}
	
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachImgVO>> getAttachList(int museumNo) {
		return new ResponseEntity<>(museum_service.getAttachList(museumNo), HttpStatus.OK);
	}
}
