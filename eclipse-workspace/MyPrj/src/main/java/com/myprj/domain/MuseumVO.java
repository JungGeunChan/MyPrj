package com.myprj.domain;

import java.util.List;

import lombok.Data;

@Data
public class MuseumVO {
	private int museumNo;
	private String museumName;
	private String museumAddress;
	private String museumTel;
	private String museumHomepage;
    private List<AttachImgVO> attachList;
}
