package com.myprj.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.myprj.domain.AttachImgVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@AllArgsConstructor
@RequestMapping("/admin/*")
@Log4j
public class UploadController {
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator); // OS에 상관없이 파일경로 설정 (맥,윈도우,리눅스)
	}
	
	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//ResponseEntity : 데이터와 함꼐 Http헤더의 상태메세지를 같이 전달
	@PostMapping(value = "/uploadImgAjax", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachImgVO>> uploadAjax_post(MultipartFile[] uploadFile) {
		log.info("updata ajax post....");
		
		List<AttachImgVO> list = new ArrayList<>();
		String uploadFolder = "C:\\upload";
		
		String uploadFolderPath = getFolder();
		
		// 폴더 생성-----------------------------------------------------
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("upload path : " + uploadPath);
		
		if(uploadPath.exists() == false) { // 폴더가 존재하는지 확인
			uploadPath.mkdirs(); 
		} // 없으면 폴더 생성----------------------------------------------
		
		// 파일 업로드----------------------------------------------------
		for(MultipartFile multipartFile : uploadFile) {
			AttachImgVO attachImgVO = new AttachImgVO();
			
			log.info("----------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			
			// IE 파일 이름-------------------------------------
			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name : " + uploadFileName);
			attachImgVO.setMuseumImgFileName(uploadFileName);
			//------------------------------------------------
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				attachImgVO.setMuseumImgUuid(uuid.toString());
				attachImgVO.setMuseumImgUploadPath(uploadFolderPath);
				
				// 이미지 파일 체크
				if(checkImageType(saveFile)) {
					attachImgVO.setMuseumImgFileType(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 300, 150);
					thumbnail.close();
				}
				//list.add(attachDTO);
				list.add(attachImgVO);
			} catch(Exception e) {
				log.error(e.getMessage());
			}
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	// 파일 미리보기----------------------------------------------
	@GetMapping("/display")
	@ResponseBody // http요청 body를 java객체로 받을수 있다.
	// fileName를 파라미터로 받고 byte[]를 전송.
	// byte[]로 이미지 파일의 데이터를 전송할 때 신경쓰이는 것은 브라우저에 보내주는 MIME타입이 파일의 종류에 따라 달라지는 점이다.
	// 이 부분을 해결하기 위해서 probeContentType()을 이용해서 적절한 MIME 타입 데이터를 Http의 헤더 메시지에 포함할 수 있도록 처리함.
	// Test : http://localhost:8081/admin/display?fileName=2022/03/23/hamburger.jpg
	public ResponseEntity<byte[]> getFile(String museumImgFileName) {
		log.info("uploadController -> display");
		log.info("파일이름 : " + museumImgFileName);
		File file = new File("c:\\upload\\" + museumImgFileName);
		log.info("file : " + file);
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 파일 삭제-------------------------------------------------
	//delete()메서드를 사용하기 위해선 File 클래스를 인스턴스해서 사용.
	//File객체를 사용하기 위해선 삭제대상 파일의 경로를 파라미터로 넣아야함.
	@PostMapping("/deleteFile")
	@ResponseBody // http요청 body를 java객체로 받을수 있다.
	public ResponseEntity<String> deleteFile(String museumImgFileName, String museumImgFileType) {
		log.info("삭제할 파일 : " + museumImgFileName);
		File file;
		
		try {
			// (/)슬래시 혹은 (\)역슬래시로 경로를 구분하는데,
			// UTF-8로 인코딩 되어 있으면 파일명 한글이 %5와같은 이름으로 되어버리기 때문에 삭제대상 파일을 지정할 수 없다.
			// 따라서, 파일이름을 decode 해 주어야 한다.
			file = new File("c:\\upload\\" + URLDecoder.decode(museumImgFileName, "UTF-8"));
			file.delete(); // 원본 파일 삭제
			
			if(museumImgFileType.equals("image")) { // 이미지일 경우 섬네일 파일 삭제
				String thumbnailFileName = file.getAbsolutePath().replace("s_", "");
				log.info("삭제할 섬네일 파일 : " + thumbnailFileName);
				file = new File(thumbnailFileName);
				file.delete(); // 섬네일 파일 삭제
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
}
