package com.myprj.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.myprj.domain.MuseumVO;
import com.myprj.service.MuseumService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@RequestMapping("/main/*")
@Log4j
public class MainController {
	private MuseumService museum_service;
	
	@GetMapping("/main")
	public void main_get(Model model) {
		log.info("메인 페이지.");
		List<MuseumVO> randomMuseum = museum_service.getRandomMuseum();
		model.addAttribute("list", randomMuseum);
	}
	
	@GetMapping("/intro")
	public void intro_get() {
		log.info("홈페이지 소개 페이지.");
	}
}
