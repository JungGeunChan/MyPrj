package com.myprj.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.myprj.domain.MemberVO;
import com.myprj.mapper.RecoverMemberMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class RecoverMemberServiceImpl implements RecoverMemberService {
	@Setter(onMethod_ = @Autowired)
	private RecoverMemberMapper recoverMemberMapper;
	BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();
	
	@Override
	public List<MemberVO> recoverMemberIdToPhone(@Param("memberName") String memberName, @Param("memberPhone") String memberPhone) {
		return recoverMemberMapper.recoverMemberIdToPhone(memberName, memberPhone);
	}
	 
	@Override
	public List<MemberVO> recoverMemberIdToEmail(@Param("memberName") String memberName, @Param("memberEmail") String memberEmail) {
		return recoverMemberMapper.recoverMemberIdToEmail(memberName, memberEmail);
	}
	 
	@Override
	public MemberVO recoverMemberPasswordToEmail(@Param("memberName") String memberName, @Param("memberId") String memberId, @Param("memberEmail") String memberEmail) {
		return recoverMemberMapper.recoverMemberPasswordToEmail(memberName, memberId, memberEmail);
	}
}
