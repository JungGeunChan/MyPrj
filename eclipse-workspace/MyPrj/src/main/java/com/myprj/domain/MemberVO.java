package com.myprj.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
    private String memberName;
    private String memberId;
    private String memberPassword;
    private int memberBornyear;
    private String memberPhone;
    private String memberEmail;
    private String memberGender;
    private Date memberRegDate;
}
