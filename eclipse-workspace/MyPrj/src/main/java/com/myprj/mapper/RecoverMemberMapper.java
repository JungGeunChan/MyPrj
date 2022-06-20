package com.myprj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.myprj.domain.MemberVO;

public interface RecoverMemberMapper {
	public List<MemberVO> recoverMemberIdToPhone(@Param("memberName") String memberName, @Param("memberPhone") String memberPhone);
	
	public List<MemberVO> recoverMemberIdToEmail(@Param("memberName") String memberName, @Param("memberEmail") String memberEmail);
	
	public MemberVO recoverMemberPasswordToEmail(@Param("memberName") String memberName, @Param("memberId") String memberId, @Param("memberEmail") String memberEmail);
}
