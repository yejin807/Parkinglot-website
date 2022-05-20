package com.example.parking.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.example.parking.model.OrderTicket;

public interface OrderTicketRepository extends JpaRepository<OrderTicket, Long>{

	@Query(value = "select * from order_ticket where member_id=?1", nativeQuery = true)
	List<OrderTicket> findByMemberId(String username);

}
