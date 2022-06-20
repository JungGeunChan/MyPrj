package com.myprj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myprj.domain.AttachImgVO;
import com.myprj.domain.Criteria;
import com.myprj.domain.MuseumCategoryVO;
import com.myprj.domain.MuseumVO;
import com.myprj.mapper.AttachImgMapper;
import com.myprj.mapper.MuseumCategoryMapper;
import com.myprj.mapper.MuseumMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class MuseumServiceImpl implements MuseumService {
	@Setter(onMethod_ = @Autowired)
	private MuseumMapper museum_mapper;
	
	@Setter(onMethod_ = @Autowired)
	private AttachImgMapper attachImg_mapper;
	
	@Setter(onMethod_ = @Autowired)
	private MuseumCategoryMapper museum_category_mapper;
	
	@Transactional
	@Override
	public void insertMuseum(MuseumVO museum) {
		museum_mapper.insertSelectKey(museum);
		int museumNo = museum.getMuseumNo();
		
		if(museum.getAttachList() == null || museum.getAttachList().size() <= 0) {
			return;
		} else {
			museum.getAttachList().forEach(attach -> {
				attach.setMuseumNo(museumNo);
				attachImg_mapper.attachImgInsert(attach);
			});
		}
	}
	
	@Override
	public void insertMuseumCategory(MuseumVO museum, MuseumCategoryVO museumCategory) {
		int museumNo = museum.getMuseumNo();
		museumCategory.setMuseumNo(museumNo);
		
		museum_category_mapper.museumCategoryInsert(museumCategory);
	}

	@Override
	public List<MuseumVO> museumGetList(Criteria cri) throws Exception {
		return museum_mapper.museumGetList(cri);
	}

	@Override
	public int museumGetTotal(Criteria cri) {
		return museum_mapper.museumGetTotal(cri);
	}

	@Override
	public MuseumVO adminMuseumDetail(int museumNo) {
		return museum_mapper.adminMuseumDetail(museumNo);
	}
	
	@Override
	public List<MuseumVO> userMuseumDetail(Criteria cri) {
		List<MuseumVO> list = museum_mapper.userMuseumDetail(cri);
		return list;
	}
	
	@Transactional
	@Override
	public boolean museumUpdate(MuseumVO museum) {
		attachImg_mapper.attachImgDeleteAll(museum.getMuseumNo());
		museum_category_mapper.museumCategoryDeleteAll(museum.getMuseumNo());
		
		boolean updateResult = museum_mapper.museumUpdate(museum) == 1;
		
		if(updateResult && museum.getAttachList() != null && museum.getAttachList().size() > 0) {
			museum.getAttachList().forEach(attach -> {
				attach.setMuseumNo(museum.getMuseumNo());
				attachImg_mapper.attachImgInsert(attach);
			});
		}
		return updateResult;
	}
	
	@Transactional
	@Override
	public boolean museumDelete(int museumNo) {
		attachImg_mapper.attachImgDeleteAll(museumNo);
		museum_category_mapper.museumCategoryDeleteAll(museumNo);
		
		boolean deleteResult = museum_mapper.museumDelete(museumNo) == 1;
		return deleteResult;
	}

	@Override
	public List<AttachImgVO> getAttachList(int museumNo) {
		return attachImg_mapper.findByMuseumNo(museumNo);
	}
	
	@Override
	public MuseumCategoryVO getMuseumCategoryList(int museumNo) {
		return museum_category_mapper.findMuseumCategoryByMuseumNo(museumNo);
	}

	@Override
	public List<AttachImgVO> userGetAttachList(Criteria cri) {
		return attachImg_mapper.userFindByMuseumNo(cri);
	}

	@Override
	public int userMuseumGetTotal(Criteria cri) {
		return museum_mapper.userMuseumGetTotal(cri);
	}
	
	@Override
	public List<MuseumVO> getRandomMuseum() {
		return museum_mapper.getRandomMuseum();
	}
}
