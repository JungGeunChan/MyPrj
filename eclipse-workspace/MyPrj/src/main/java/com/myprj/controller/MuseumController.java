package com.myprj.controller;

import java.util.List;

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

import com.myprj.domain.AttachImgVO;
import com.myprj.domain.Criteria;
import com.myprj.domain.MuseumVO;
import com.myprj.domain.PageDTO;
import com.myprj.service.MuseumService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@RequestMapping("/museum/*")
@Log4j
public class MuseumController {
	private MuseumService museum_service;
	
	@PostMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachImgVO>> getAttachList(@RequestParam("themeList") String[] themeList, @RequestParam("areaList") String[] areaList , Criteria cri) {
		cri.setThemeList(themeList);
		cri.setAreaList(areaList);
		
		return new ResponseEntity<>(museum_service.userGetAttachList(cri), HttpStatus.OK);
	}
	
	@GetMapping("/museumSearch")
	public void search_get(Criteria cri, Model model) {
		log.info("박물관 검색 페이지...");
		try {
			if(cri.getThemeList() == null && cri.getAreaList() == null) { // 체크 안됐을때
				int total = 0;
				model.addAttribute("result", 0);
				model.addAttribute("pageMaker", new PageDTO(cri, total));
			} else { // 체크 했을 때
				List<MuseumVO> list = museum_service.userMuseumDetail(cri);
				List<AttachImgVO> list2 = museum_service.userGetAttachList(cri);
				int total = museum_service.userMuseumGetTotal(cri);
				
				if(total > 0) { // 조회된 결과 있음
					model.addAttribute("result", 1);
					model.addAttribute("list", list);
					model.addAttribute("list2", list2);
				} else { // 조회된 결과 없음
					model.addAttribute("result", null);
				}
				model.addAttribute("pageMaker", new PageDTO(cri, total));
				model.addAttribute("themeList", cri.getThemeList());
				model.addAttribute("areaList", cri.getAreaList());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@GetMapping("/museumDetail")
	public void museumDetail_get(@RequestParam("museumNo") int museumNo, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("박물관 상세 페이지...");
		model.addAttribute("list", museum_service.adminMuseumDetail(museumNo));
		model.addAttribute("themeList", cri.getThemeList());
		model.addAttribute("areaList", cri.getAreaList());
	}
}