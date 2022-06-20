package com.myprj.mapper;

import com.myprj.domain.MuseumCategoryVO;

public interface MuseumCategoryMapper {
	public void museumCategoryInsert(MuseumCategoryVO museumCategory);
	
	public MuseumCategoryVO findMuseumCategoryByMuseumNo(int museumNo);
	
	public void museumCategoryDeleteAll(int museumNo);
}
