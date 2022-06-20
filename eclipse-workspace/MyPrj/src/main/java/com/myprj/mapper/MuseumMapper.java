package com.myprj.mapper;

import java.util.List;

import com.myprj.domain.Criteria;
import com.myprj.domain.MuseumCategoryVO;
import com.myprj.domain.MuseumVO;

public interface MuseumMapper {
	public void insertSelectKey(MuseumVO museum);
	
	public MuseumVO adminMuseumDetail(int museumNo);
	
	public List<MuseumVO> userMuseumDetail(Criteria cri);
	
	public int museumUpdate(MuseumVO museum);
	
	public int museumDelete(int MuseumNo);
	
	public List<MuseumVO> museumGetList(Criteria cri);
	
	public int museumGetTotal(Criteria cri);
	
	public int userMuseumGetTotal(Criteria cri);
	
	public List<MuseumCategoryVO> searchMuseumNo(MuseumCategoryVO museumCategory);
	
	public List<MuseumVO> getRandomMuseum();
}
