package com.example.parking.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.parking.model.OrderTicket;

public interface OrderTicketRepository extends JpaRepository<OrderTicket, Long> {

	//고객별 구매리스트
    @Query(value = "select * from order_ticket where username=?1", nativeQuery = true)
    List<OrderTicket> findByUsername(String username);

    //티켓확인
    @Query(value = "select * from order_ticket where parkinglot_id like CONCAT('%',:parkid,'%') AND car_num like CONCAT('%',:carNum,'%')", nativeQuery = true)
    public OrderTicket findByParkinglotIdAndCarNum(@Param("parkid") Long parkid, @Param("carNum") String carNum);

    //주차장별 정규권 구매자수
    @Query(value = "select count(*) from order_ticket where parkinglot_id=?1", nativeQuery = true)
	public int countByParkinglotId(Long ParkinglotId);

}
