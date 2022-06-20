package com.myprj.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.myprj.domain.MemberVO;
import com.myprj.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {
	@Setter(onMethod_ = @Autowired)
	private MemberMapper member_mapper;
	BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();
	
	@Override
	public void join(MemberVO member) {
		String encodePw = pwEncoder.encode(member.getMemberPassword());

		member.setMemberPassword(encodePw);

		member_mapper.insert(member);
	}

	@Override
	public int checkEmail(String memberEmail) {
		int result = member_mapper.checkEmail(memberEmail);
		return result;
	}

	@Override
	public int checkId(String memberId) {
		int result = member_mapper.checkId(memberId);
		return result;
	}
	
	@Override
	public int checkPhone(String memberPhone) {
		int result = member_mapper.checkPhone(memberPhone);
		return result;
	}
	
	@Override
	public MemberVO readMember(String memberId) {
		return member_mapper.readMember(memberId);
	}

	@Override
	public MemberVO memberLogin(MemberVO member) {
		return member_mapper.memberLogin(member);
	}

	@Override
	public int memberDelete(MemberVO member) {
		int deleteResult = member_mapper.memberDelete(member);
		return deleteResult;
	}
	
	@Override
	public int memberPhoneUpdate(MemberVO member) {
		int phoneUpdateResult = member_mapper.memberPhoneUpdate(member);
		return phoneUpdateResult;
	}

	@Override
	public int memberPasswordUpdate(MemberVO member) {
		String encodePw = pwEncoder.encode(member.getMemberPassword());
		member.setMemberPassword(encodePw);
		int passwordUpdateResult = member_mapper.memberPasswordUpdate(member);
		return passwordUpdateResult;
	}
}
