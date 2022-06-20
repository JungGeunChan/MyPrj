package com.myprj.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.myprj.domain.AttachImgVO;
import com.myprj.mapper.AttachImgMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {
	@Setter(onMethod_ = {@Autowired})
	private AttachImgMapper attach_mapper;
	
	private String getFolderYesterDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		String str = sdf.format(cal.getTime());
		log.info(str);
		return str.replace("-", File.separator);
	}
	
	@Scheduled(cron = "0 0 2 * * *") // cron : 매일 새벽2시에 삭제
	// ("seconds, minutes, hours, day, month, day of week, (*)year")
	public void checkFiles() throws Exception {
		log.warn("File Check Task Run...");
		log.warn(new Date());
		
		List<AttachImgVO> fileList = attach_mapper.getOldFiles();
		
		List<Path> fileListPaths = fileList.stream()
				.map(vo -> Paths.get("c:\\upload", vo.getMuseumImgUploadPath(), vo.getMuseumImgUuid() + "_" + vo.getMuseumImgFileName()))
				.collect(Collectors.toList());
		
		fileList.stream().filter(vo -> vo.isMuseumImgFileType() == true)
			.map(vo -> Paths.get("c:\\upload", vo.getMuseumImgUploadPath(), "s_" + vo.getMuseumImgUuid() + "_" + vo.getMuseumImgFileName()))
			.forEach(p -> fileListPaths.add(p));
		
		log.warn("=============================");
		
		fileListPaths.forEach(p -> log.warn(p));
		
		File targetDir = Paths.get("c:\\upload", getFolderYesterDay()).toFile();
		
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
		log.warn("-----------------------------");
		for(File file : removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
	}
}
