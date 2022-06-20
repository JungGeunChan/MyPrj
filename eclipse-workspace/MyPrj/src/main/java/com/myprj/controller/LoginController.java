package com.myprj.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myprj.domain.MemberVO;
import com.myprj.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@RequestMapping("/main/*")
@Log4j
public class LoginController {
	private MemberService member_service;
	
	@GetMapping("/login")
	public void LoginPage(HttpServletRequest request) {
		log.info("로그인 페이지.");
	}

	@PostMapping("/login")
	public String Login(HttpServletRequest request, MemberVO member, @RequestParam("memberId") String memberId, @RequestParam("memberPassword") String memberPassword, RedirectAttributes rttr, Model model) {
		HttpSession session = request.getSession();
		BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();
		MemberVO loginmember = member_service.memberLogin(member);
		int result = 0;
		
		if(session.getAttribute("member") != null) {
			return "redirect:/main/needLogin";
		} else {
			if(loginmember == null) {
				result = 0;
				rttr.addFlashAttribute("result", result); // 0 : false, 1 : true
				return "redirect:/main/login";
			} else {
				String encodepw = member_service.readMember(memberId).getMemberPassword();		
				boolean encodeRes = pwEncoder.matches(memberPassword, encodepw);
			
				if(encodeRes == false) {
					result = 0;
					rttr.addFlashAttribute("result", result); // 0 : false, 1 : true
					return "redirect:/main/login";
				} else {
					session.setAttribute("member", loginmember);
					session.setMaxInactiveInterval(1800);
				}
			}
		}
		return "redirect:/main/main";
	}
	
	@GetMapping("/logout")
	public String Logout(HttpServletRequest request) {
		request.getSession().invalidate();
		request.getSession(true);
		return "redirect:/main/main";
	}
}