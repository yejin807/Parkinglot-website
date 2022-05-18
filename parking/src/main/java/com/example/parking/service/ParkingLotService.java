package com.example.parking.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import com.example.parking.model.ParkingLot;
import com.example.parking.repository.ParkingLotRepository;

@Service
public class ParkingLotService {
	
	@Autowired
	private ParkingLotRepository pRepository;
	
	
	//주차장등록
	public void insert(ParkingLot parkinglot, String uploadFolder) {
		UUID uuid = UUID.randomUUID();
		MultipartFile f= parkinglot.getUpload();
		String uploadFileName="";
		
		if(!f.isEmpty()) { //파일 선택됨
			uploadFileName = uuid.toString() + "_" + f.getOriginalFilename(); //파일이름 생성(중복방지)
			File saveFile = new File(uploadFolder, uploadFileName); 			
			try {
				f.transferTo(saveFile); //파일 업로드
				parkinglot.setFiles(uploadFileName); //테이블에 저장될 파일 이름 
				pRepository.save(parkinglot);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		
		pRepository.save(parkinglot);
	}
	
	//주차장리스트
	public List<ParkingLot> list(){
		return pRepository.findAll();
	}

}
