package com.myprj.domain;

import lombok.Data;

@Data
public class AttachImgVO {
	private int museumNo;
	private String museumImgFileName;
	private String museumImgUploadPath;
	private String museumImgUuid;
	private boolean museumImgFileType;
}
