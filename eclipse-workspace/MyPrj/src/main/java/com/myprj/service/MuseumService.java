package com.myprj.service;

import java.util.List;

import com.myprj.domain.AttachImgVO;
import com.myprj.domain.Criteria;
import com.myprj.domain.MuseumCategoryVO;
import com.myprj.domain.MuseumVO;

public interface MuseumService {
	public void insertMuseum(MuseumVO museum);
	
	public List<MuseumVO> museumGetList(Criteria cri) throws Exception;
	
	public int museumGetTotal(Criteria cri);
	
	public int userMuseumGetTotal(Criteria cri);
	
	public MuseumVO adminMuseumDetail(int museumNo);
	
	public List<MuseumVO> userMuseumDetail(Criteria cri);
	
	public boolean museumUpdate(MuseumVO museum);
	
	public boolean museumDelete(int museumNo);
	
	public List<AttachImgVO> getAttachList(int museumNo);
	
	public List<AttachImgVO> userGetAttachList(Criteria cri);
	
	public MuseumCategoryVO getMuseumCategoryList(int museumNo);
	
	public void insertMuseumCategory(MuseumVO museum, MuseumCategoryVO museumCategory);
	
	public List<MuseumVO> getRandomMuseum();
}
