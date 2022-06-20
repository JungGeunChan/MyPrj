package com.myprj.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myprj.domain.MemberVO;
import com.myprj.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@RequestMapping(value = {"/main/join/*", "/main/mypage/*"}) // 공통 url 분기
@Log4j
public class MemberController {
	private MemberService member_service;
	private BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();
	private HttpServletRequest request;

	//------  /main/join/*  ------//
	@GetMapping("/joinEmailCheck")
	public void joinEmailCheck_get() {
		log.info("회원 가입 여부 확인 페이지.");
	}
	
	@PostMapping("/joinEmailCheck")
	public String joinEmailCheck_post(MemberVO member, String memberEmail, RedirectAttributes rttr) throws Exception {
		HttpSession session = request.getSession();
		int chkEmailResult = member_service.checkEmail(memberEmail);
		
		try {
			if(chkEmailResult == 1) { // count(*) = 1 중복된 이메일 존재.
				rttr.addFlashAttribute("chkEmailResult", chkEmailResult);
				return "redirect:/main/join/joinEmailCheck";
			} else if(chkEmailResult == 0) { // count(*) = 0 이메일이 존재하지 않음.
				session.setAttribute("memberEmail", memberEmail); // joinMember로 이메일을 넘기기 위해서
				return "redirect:/main/join/joinMemberAgreement";
			}
		} catch(Exception e) {
			throw new RuntimeException();
		}
		
		return "redirect:/";
	}
	
	@GetMapping("/joinMemberAgreement")
	public void joinMemberAgreement_get() {
		log.info("이용 약관 확인 페이지.");
	}
	
	@GetMapping("/joinMember")
	public void joinMember_get() {
		log.info("회원가입 페이지.");
		HttpSession session = request.getSession();
		session.getAttribute("memberEmail"); // joinEmailCheck에서 이메일이 중복되지 않았을 경우 memberEmail이름으로 세션에 등록하는데, 가져온다.
	}	
	
	@PostMapping("/joinMember")
	public String joinMember_post(MemberVO member, @RequestParam("memberId") String memberId, @RequestParam("memberPhone") String memberPhone, RedirectAttributes rttr) throws Exception {
		try {
			int chkIdResult = member_service.checkId(memberId);
			int chkPhoneResult = member_service.checkPhone(memberPhone);
			
			if(chkIdResult == 0 && chkPhoneResult == 0) { // 중복된 Id와 핸드폰번호가 없음.
				member_service.join(member);
				rttr.addAttribute("memberId", member.getMemberId());
				return "redirect:/main/join/joinSuccess";
			} else {
				return "redirect:/main/join/joinMember";
			}
		} catch (Exception e) {
			throw new RuntimeException();
		}
	}
	
	// memberId 중복확인 (ajax)
	@PostMapping("/idCheck")
	@ResponseBody
	public int idCheck(@RequestParam("memberId") String memberId) throws Exception {
		String regIdExp = "[a-zA-z0-9]{4,12}";
		try {
			int idRes;
			
			if(!memberId.matches(regIdExp)) {
				idRes = 2;
			} else {
				idRes = member_service.checkId(memberId);
			}
			
			return idRes;
		} catch (Exception e) {
			throw new RuntimeException();
		}
	}
	
	// memberPassword, memberPasswordChk 일치여부 확인 (ajax)
	@PostMapping("/pwCheck")
	@ResponseBody
	public boolean pwCheck(@RequestParam("memberPassword") String memberPassword, @RequestParam("memberPasswordChk") String memberPasswordChk) throws Exception {
		try {
			if(!memberPassword.equals(memberPasswordChk)) {
				boolean passwordCheckResult = false;
				return passwordCheckResult;
			} else {
				boolean passwordCheckResult = true;
				return passwordCheckResult;
			}
		} catch (Exception e) {
			throw new RuntimeException();
		}
	}
	
	@PostMapping("/phoneCheck")
	@ResponseBody
	public int phoneCheck(@RequestParam("memberPhone") String memberPhone) {
		int res = member_service.checkPhone(memberPhone);

		if(res >= 1) {
			log.info("가입 불가능한 핸드폰번호");
		} else {
			log.info("가입 가능한 핸드폰번호");
		}
		
		return res;
	}
	
	@GetMapping("/joinSuccess")
	public void joinSuccess_get(@ModelAttribute("memberId") String memberId, RedirectAttributes rttr) {
		log.info("회원가입 성공 페이지.");
		
		request.getSession().removeAttribute("memberEmail"); // 세션에 있던 memberEmail을 없앤다.
	}
	
	//------  /main/mypage/*  ------//
	//------  update  ------//
	@GetMapping("/update")
	public String update_get(MemberVO member, HttpSession session, Model model, RedirectAttributes rttr) {
		log.info("Update 페이지...");
		// 현재 로그인한 사용자의 정보를 불러옴.
		MemberVO loginMember = (MemberVO) session.getAttribute("member");

		String[] phoneArr = loginMember.getMemberPhone().split("-");
		for(int i = 0; i < phoneArr.length; i++) {
			model.addAttribute("memberPhone" + i, phoneArr[i]);
		}
		return "/main/mypage/update";
	}
	
	@PostMapping("/update")
	public String update_post(MemberVO member, @RequestParam("memberPhone") String memberPhone, HttpSession session, RedirectAttributes rttr) {
		MemberVO loginMember = (MemberVO) session.getAttribute("member");
		String loginMemberId = (String) loginMember.getMemberId();

		loginMember.setMemberPhone(memberPhone);
		loginMember.setMemberId(loginMemberId);
		
		int updatePhoneResult = member_service.memberPhoneUpdate(loginMember);
		if(updatePhoneResult == 0) {
			rttr.addFlashAttribute("updatePhoneResult", updatePhoneResult);
		} else {
			rttr.addFlashAttribute("updatePhoneResult", updatePhoneResult);
		}
		return "redirect:/main/mypage/update";
	}
	
	//------  passwordUpdate  ------//
	// memberPassword, memberPasswordChk 일치여부 확인 (ajax)
	@PostMapping("/changePwCheck")
	@ResponseBody
	public boolean changePwCheck(@RequestParam("changePassword") String changePassword, @RequestParam("changePasswordCheck") String changePasswordCheck) throws Exception {
		try {
			if(!changePassword.equals(changePasswordCheck)) {
				boolean passwordCheckResult = false;
				return passwordCheckResult;
			} else {
				boolean passwordCheckResult = true;
				return passwordCheckResult;
			}
		} catch (Exception e) {
			throw new RuntimeException();
		}
	}
		
	@GetMapping("/passwordUpdate")
	public void passwordUpdate_get(HttpSession session) {
		log.info("passwordUpdate...");
	}
	
	@PostMapping("/passwordUpdate")
	public String passwordUpdate_post(MemberVO member, HttpSession session, @RequestParam("memberPassword") String memberPassword, @RequestParam("changePassword") String changePassword, @RequestParam("changePasswordCheck") String changePasswordCheck, RedirectAttributes rttr) {
		// 세션에 로그인한 아이디
		MemberVO loginMember = (MemberVO) session.getAttribute("member");
		String loginMemberId = loginMember.getMemberId();
		String encodepw = member_service.readMember(loginMemberId).getMemberPassword();
		boolean encodeResult = pwEncoder.matches(memberPassword, encodepw);
		
		if(encodeResult == false) { // 1. 기존비밀번호와 불일치
			rttr.addFlashAttribute("encodeResult", false);
			return "redirect:/main/mypage/passwordUpdate";
		} else { // 2. 기존비밀번호와 일치
			rttr.addFlashAttribute("encodeResult", true);
			
			String encodeChangePassword = pwEncoder.encode(changePassword);
			boolean encodeResult2 = pwEncoder.matches(changePasswordCheck, encodeChangePassword);

			if(encodeResult2 == false) { // 2-1. 변경하려는 비밀번호끼리 불일치
				rttr.addFlashAttribute("encodeResult2", false);
				return "redirect:/main/mypage/passwordUpdate";
			} else { // 2-2. 변경하려는 비밀번호끼리 일치
				member.setMemberPassword(changePassword);
				member.setMemberId(loginMemberId);
				int updatePasswordResult = member_service.memberPasswordUpdate(member);
				
				if(updatePasswordResult == 0) { // 2-2-1. 어떠한 이유로 업데이트 실패 (ex:회원정보가 없음 등등..)
					rttr.addFlashAttribute("updatePasswordResult", updatePasswordResult);
				} else {
					rttr.addFlashAttribute("updatePasswordResult", updatePasswordResult);
				}
				return "redirect:/main/mypage/passwordUpdate";
			}
		}
	}
	
	//------  delete  ------//
	@GetMapping("/delete")
	public void delete_get(HttpSession session) {
		log.info("delete...");
	}
	
	@PostMapping("/delete")
	public String delete_post(MemberVO member, HttpSession session, @RequestParam("memberPassword") String memberPassword, HttpServletResponse response, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		// 세션에 로그인한 아이디.
		MemberVO loginMember = (MemberVO) session.getAttribute("member");
		String loginMemberId = loginMember.getMemberId();	
		// 로그인한 아이디의 비밀번호.
		String encodepw = member_service.readMember(loginMemberId).getMemberPassword();	
		boolean encodeResult = pwEncoder.matches(memberPassword, encodepw);
		
		if(encodeResult == false) {
			log.info("비밀번호 불일치");
			rttr.addFlashAttribute("encodeResult", encodeResult);
			return "redirect:/main/mypage/delete";
		} else {
			rttr.addFlashAttribute("encodeResult", encodeResult);
			int memberDeleteResult = member_service.memberDelete(loginMember);
			if(memberDeleteResult == 0) {
				rttr.addFlashAttribute("memberDeleteResult", memberDeleteResult);
				return "redirect:/main/mypage/delete";
			} else {
				rttr.addFlashAttribute("memberDeleteResult", memberDeleteResult);
				request.getSession().invalidate();
				request.getSession(true);
				return "redirect:/main/main";
			}
		}
	}
}