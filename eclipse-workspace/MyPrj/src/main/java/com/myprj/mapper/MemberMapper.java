package com.myprj.mapper;

import com.myprj.domain.MemberVO;

public interface MemberMapper {
	public void insert(MemberVO member);
	
	public int checkEmail(String memberEmail);
	
	public int checkId(String memberId);
	
	public int checkPhone(String memberPhone);
	
	public MemberVO readMember(String memberId);
	
	public MemberVO memberLogin(MemberVO member);
	
	public int memberPhoneUpdate(MemberVO member);
	
	public int memberPasswordUpdate(MemberVO member);
	
	public int memberDelete(MemberVO member);
}
