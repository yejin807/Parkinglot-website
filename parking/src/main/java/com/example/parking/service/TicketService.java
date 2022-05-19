package com.example.parking.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.parking.model.ParkingLot;
import com.example.parking.model.Ticket;
import com.example.parking.repository.TicketRepository;

@Service
@Transactional(readOnly = true)
public class TicketService {
	
	@Autowired
	private TicketRepository tPepository;
	
	@Transactional
	public void insert(Ticket ticket) {
		
		if(ticket.getTicketId()==null) {
			tPepository.save(ticket);
			return;
		} else {
			Ticket t = tPepository.findById(ticket.getTicketId()).get();
			t.setDayFee(ticket.getDayFee());
			t.setDayStock(ticket.getDayStock());
			t.setWeekFee(ticket.getWeekFee());
			t.setWeekStock(ticket.getWeekStock());
			t.setMonthFee(ticket.getMonthFee());
			t.setMonthStock(ticket.getMonthStock());
		}
		
		
	}
	
	//주차장별 정규권재고
	public List<Ticket> findByParkinglotId(Long parkinglotId) {
		return tPepository.findByParkinglotId(parkinglotId);
	}
	
	//정규권 판매리스트
	public List<Ticket> list(){
		return tPepository.findAll();
	}
	

}
