package com.myprj.mapper;

import java.util.List;

import com.myprj.domain.AttachImgVO;
import com.myprj.domain.Criteria;

public interface AttachImgMapper {
	public void attachImgInsert(AttachImgVO attachImg); // 이미지 삽입
	
	public List<AttachImgVO> findByMuseumNo(int museumNo); // 박물관 번호 이미지 찾기
	
	public void attachImgDelete(String museumImgUuid); // 특정 이미지 한개 삭제
	
	public void attachImgDeleteAll(int museumNo); // 이미지 전체 삭제
	
	public List<AttachImgVO> getOldFiles(); // 없는 박물관 이미지 삭제
	
	public List<AttachImgVO> userFindByMuseumNo(Criteria cri);
	
	public List<AttachImgVO> mainFindByMuseumNo(int[] arrMuseumNo);
}
