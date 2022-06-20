package com.myprj.domain;

import lombok.Data;

@Data
public class MuseumCategoryVO {
	private int museumNo;
	private String themeCode;
	private String areaCode;
	private String[] themeList;
	private String[] areaList;
}
