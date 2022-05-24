package com.example.parking.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.example.parking.model.ParkingLot;
import com.example.parking.repository.CarRepository;
import com.example.parking.repository.EntercarRepository;
import com.example.parking.repository.OrderTicketRepository;
import com.example.parking.repository.ParkingLotRepository;

@Service
@Transactional(readOnly = true)
public class ParkingLotService {
	
	@Autowired
	private ParkingLotRepository pRepository;
	
	@Autowired
	private OrderTicketRepository oRepository;
	
	@Autowired
	private EntercarRepository eRepository;
	
	//주차장 등록
	@Transactional
	public void insert(ParkingLot parkinglot, String uploadFolder) {
		UUID uuid = UUID.randomUUID();
		MultipartFile f= parkinglot.getUpload();
		String uploadFileName="";
		
		//현재주차면수 초기값 = 최대주차면수 
		parkinglot.setCurrentCnt(parkinglot.getMaxCnt());
		
		if(!f.isEmpty()) { //파일 선택됨
			uploadFileName = uuid.toString() + "_" + f.getOriginalFilename(); //파일이름 생성(중복방지)
			File saveFile = new File(uploadFolder, uploadFileName); 			
			try {
				f.transferTo(saveFile); //파일 업로드
				parkinglot.setFiles(uploadFileName); //테이블에 저장될 파일 이름 
				pRepository.save(parkinglot);
				return;
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		
		pRepository.save(parkinglot);
	}
	
	//주차장 리스트(사장님)
	public List<ParkingLot> list(String username){		
		return pRepository.findByUsername(username);
	}
	
	//주차장 리스트(전체)
	public List<ParkingLot> listAll(){		
		return pRepository.findAll();
	}

	//주차장 상세보기
	public ParkingLot view(Long id) {
		return pRepository.findById(id).get();
	}

	//주차장 수정하기
	@Transactional
	public void update(ParkingLot parkinglot, String uploadFolder) {
		
		ParkingLot p = pRepository.findById(parkinglot.getParkinglotId()).get();
	
		UUID uuid = UUID.randomUUID();
		String uploadFileName = p.getFiles();
		System.out.println(uploadFileName);
		MultipartFile f= parkinglot.getUpload();
		
		if(!f.isEmpty()) { //파일 선택됨
			uploadFileName= uuid.toString() + "_" + f.getOriginalFilename(); //파일이름 생성(중복방지)
			File saveFile = new File(uploadFolder, uploadFileName); 			
			try {
				f.transferTo(saveFile); //파일 업로드
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		System.out.println(uploadFileName);
		p.setParkinglotId(parkinglot.getParkinglotId());
		p.setParkingName(parkinglot.getParkingName());
		p.setAddr(parkinglot.getAddr());
		p.setWido(parkinglot.getWido());
		p.setGyeongdo(parkinglot.getGyeongdo());
		p.setParkinglotTel(parkinglot.getParkinglotTel());
		p.setMaxCnt(parkinglot.getMaxCnt());
		p.setCurrentCnt(parkinglot.getCurrentCnt());
		p.setBasicFee(parkinglot.getBasicFee());
		p.setDayFee(parkinglot.getDayFee());
		p.setMonthFee(parkinglot.getMonthFee());
		p.setOpenTime(parkinglot.getOpenTime());
		p.setCloseTime(parkinglot.getCloseTime());
		p.setOperatingType(parkinglot.getOperatingType());
		p.setFiles(uploadFileName);
	}

	//주차장 삭제
	@Transactional
	public void delete(Long id) {
		pRepository.deleteById(id);
	}

	//현재 주차가능면수 업데이트
	@Transactional
	public void currentCntUpdate() {
		List<ParkingLot> plist = pRepository.findAll();
		for(ParkingLot p : plist) {
			int orderCnt = oRepository.countByParkinglotId(p.getParkinglotId());
			int enterCnt = eRepository.countByParkinglotId(p.getParkinglotId());
			p.setCurrentCnt(p.getMaxCnt()-orderCnt-enterCnt);
		}		
	}

}
