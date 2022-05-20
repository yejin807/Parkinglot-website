package com.example.parking.repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.example.parking.model.Ticket;

public interface TicketRepository extends JpaRepository<Ticket, Long>{

	@Query(value = "select * from ticket where parkinglot_id = ?1", nativeQuery = true)
	public Ticket findByParkinglotId(Long parkinglotId);

}
