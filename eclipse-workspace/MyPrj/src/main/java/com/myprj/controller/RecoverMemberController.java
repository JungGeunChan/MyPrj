package com.myprj.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myprj.domain.MemberVO;
import com.myprj.service.MemberService;
import com.myprj.service.RecoverMemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@RequestMapping("/main/recover/*")
@Log4j
public class RecoverMemberController {
	private MemberService memberService;
	private RecoverMemberService recoverMemberService;
	private BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();
	private JavaMailSender mailSender;
	//------  recoverMemberId  ------//
	@GetMapping("/recoverMemberId")
	public void recoverMemberId_get() {
		log.info("비밀번호 찾기 페이지...");
	}
		
	@PostMapping("/recoverMemberId_toPhone")
	public String recoverMemberId_toPhone_post(@RequestParam("memberName") String memberName, @RequestParam("memberPhone") String memberPhone, RedirectAttributes rttr) {
		List<MemberVO> memberId = recoverMemberService.recoverMemberIdToPhone(memberName, memberPhone);
		List<String> maskIdArr = new ArrayList<>();
		List<String> originIdArr = new ArrayList<>();
		if(memberId.isEmpty()) {
			log.info(memberId);
			rttr.addFlashAttribute("result", "false");
			return "redirect:/main/recover/recoverMemberId";
		} else {
			for(int i=0; i<memberId.size(); i++) {
				log.info("memberEmail : " + memberId.get(i).getMemberEmail());
				
				String maskId = "";
				String originId = "";
				maskId = memberId.get(i).getMemberId().replaceAll(".{3}$","***");
				originId = memberId.get(i).getMemberId();
				log.info("maskId : " + maskId);
				maskIdArr.add(maskId);
				originIdArr.add(originId);
			}
			
			String sendEmail = "jkchappy4581@gmail.com"; // 발신자 메일
			String receiveEmail = memberId.get(0).getMemberEmail(); // 회원 이메일
			String title = "전국 박물관 안내소 아이디 찾기 결과입니다."; // 메일 제목
			String content = "전국 박물관 안내소 전체 아이디는 " + originIdArr + "입니다.";
			
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
				
				messageHelper.setFrom(sendEmail);
				messageHelper.setTo(receiveEmail);
				messageHelper.setSubject(title);
				messageHelper.setText(content);
				
				mailSender.send(message);

				log.info("전송 성공");
			} catch (Exception e) {
				log.info("전송 실패");
				e.printStackTrace();
			}
			
			rttr.addAttribute("memberId", maskIdArr);
			rttr.addAttribute("receiveEmail", receiveEmail);
			rttr.addAttribute("memberName", memberName);
			return "redirect:/main/recover/recoverMemberIdSuccess";
		}
	}
	
	@PostMapping("/recoverMemberId_toEmail")
	public String recoverMemberId_toEmail_post(@RequestParam("memberName") String memberName, @RequestParam("memberEmail") String memberEmail, RedirectAttributes rttr) {
		List<MemberVO> memberId = recoverMemberService.recoverMemberIdToEmail(memberName, memberEmail);
		List<String> maskIdArr = new ArrayList<>();
		
		if(memberId.isEmpty()) { 
			log.info(memberId);
			rttr.addFlashAttribute("result", "false"); 
			return "redirect:/main/recover/recoverMemberId";
		}
		else {
			for(int i=0; i<memberId.size(); i++) {
				log.info("memberEmail : " + memberId.get(i).getMemberEmail());
				
				String maskId = "";
				maskId = memberId.get(i).getMemberId().replaceAll(".{3}$","***");
				log.info("maskId : " + maskId);
				maskIdArr.add(maskId);
			}
			
			String sendEmail = "jkchappy4581@gmail.com"; // 발신자 메일
			String receiveEmail = memberId.get(0).getMemberEmail(); // 회원 이메일
			String title = "전국 박물관 안내소 아이디 찾기 결과입니다."; // 메일 제목
			String content = "전국 박물관 안내소 전체 아이디는 " + memberId.get(0).getMemberId() + "입니다.";
			
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
				
				messageHelper.setFrom(sendEmail);
				messageHelper.setTo(receiveEmail);
				messageHelper.setSubject(title);
				messageHelper.setText(content);
				
				mailSender.send(message);

				log.info("전송 성공");
			} catch (Exception e) {
				log.info("전송 실패");
				e.printStackTrace();
			}
			log.info("receiveEmail : " + receiveEmail);
			rttr.addAttribute("memberId", maskIdArr);
			rttr.addAttribute("receiveEmail", receiveEmail);
			rttr.addAttribute("memberName", memberName);
			return "redirect:/main/recover/recoverMemberIdSuccess";
		}
	}
	
	@GetMapping("/recoverMemberIdSuccess")
	public void recoverMemberIdSuccess_get(@RequestParam("memberName") String memberName, @RequestParam("memberId") String memberId, @RequestParam("receiveEmail") String receiveEmail, Model model) {
		log.info("아이디 찾기 성공");
		model.addAttribute("memberName", memberName);
		model.addAttribute("memberId", memberId);
		model.addAttribute("receiveEmail", receiveEmail);
	}
	
	//------  recoverMemberPassword  ------//
	@GetMapping("/recoverMemberPassword")
	public void recoverMemberPassword_get() {
		log.info("비밀번호 찾기 페이지...");
	}
	
	@PostMapping("/recoverMemberPassword")
	public ModelAndView recoverMemberPassword_post(HttpSession session, @RequestParam("memberName") String memberName, @RequestParam("memberId") String memberId, @RequestParam("memberEmail") String memberEmail) {
		ModelAndView mv = new ModelAndView();
		MemberVO member = recoverMemberService.recoverMemberPasswordToEmail(memberName, memberId, memberEmail);
		
		log.info("member : " + member);
		
		if(member == null) {
			log.info("회원이 존재하지 않음..");
			mv.addObject("result", "false");
			mv.setViewName("/main/recover/recoverMemberPassword");
			return mv;
		} else {
			log.info("회원이 존재함.");
			log.info("memberEmail : " + memberEmail);
			
			session.setAttribute("memberId", memberId);
			session.setAttribute("memberEmail", memberEmail);
			
			Random random = new Random();
			String certNumber = Integer.toString(random.nextInt(888888)+111111); // 111111~999999까지 인증번호 난수 생성.
			log.info("certNumber : " + certNumber);
			String encodeCertNumber = pwEncoder.encode(certNumber);
			log.info("enCode certNumber : " + encodeCertNumber);
			
			String sendEmail = "jkchappy4581@gmail.com"; // 발신자 메일
			String receiveEmail = memberEmail; // 회원 이메일
			String title = "전국 박물관 안내소 비밀번호 찾기 인증메일입니다."; // 메일 제목
			String content = "전국 박물관 안내소 비밀번호 찾기 인증번호는 " + certNumber + "입니다.";
			
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
				
				messageHelper.setFrom(sendEmail);
				messageHelper.setTo(receiveEmail);
				messageHelper.setSubject(title);
				messageHelper.setText(content);
				
				mailSender.send(message);

				mv.addObject("encodeCertNumber", encodeCertNumber);
				mv.setViewName("/main/recover/recoverMemberPasswordResult");
				log.info("전송 성공");
				
				return mv;
			} catch (Exception e) {
				log.info("전송 실패");
				e.printStackTrace();
				session.invalidate();
			}
		}
		return mv;
	}
	
	@GetMapping("/recoverMemberPasswordResult")
	public void recoverMemberPasswordResult_get() {
		log.info("비밀번호 찾기 결과...");
	}
	
	@PostMapping("/recoverMemberPasswordResult")
	public String recoverMemberPasswordResult_post(@RequestParam("encodeCertNumber") String encodeCertNumber, @RequestParam("inputCertNumber") String inputCertNumber) {	
		log.info("encodeCertNumber : " + encodeCertNumber);
		boolean encodeRes = pwEncoder.matches(inputCertNumber, encodeCertNumber);
		log.info("encodeRes : " + encodeRes);
		if(encodeRes == true) {
			log.info("입력한 certNumber : " + inputCertNumber);
			log.info("인증번호 일치");
			
			return "/main/recover/recoverMemberPasswordChange";
		} else {
			log.info("입력한 certNumber : " + inputCertNumber);
			log.info("인증번호 불일치");
			return "/main/main";
		}
	}
	
	@GetMapping("/recoverMemberPasswordChange")
	public void recoverMemberPasswordChange_get() {
		log.info("비밀번호 찾기 -> 비밀번호 변경 페이지...");
	}
	
	@PostMapping("/recoverMemberPasswordChange")
	public String recoverMemberPasswordChange_post(MemberVO member, @RequestParam("memberEmail") String memberEmail, @RequestParam("changePassword") String changePassword, @RequestParam("changePasswordChk") String changePasswordChk, HttpSession session, RedirectAttributes rttr) {
		if(!(changePassword).equals(changePasswordChk)) {
			log.info("changePassword : " + changePassword + ", changePasswordChk : " + changePasswordChk);
			log.info("비밀번호 끼리 불일치.");
			return "redirect:/main/recover/recoverMemberPasswordChange";
		} else {
			log.info("비밀번호끼리 일치.");
			String memberId = (String) session.getAttribute("memberId");
			log.info(memberId);
			member.setMemberId(memberId);
			member.setMemberPassword(changePassword);
			memberService.memberPasswordUpdate(member);
			
			log.info("session : " + session.getAttribute("memberEmail"));
			rttr.addFlashAttribute("recoverPwResult", "true");
			session.invalidate();
			return "redirect:/main/main";
		}
	}
}
