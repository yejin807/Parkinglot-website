package com.example.parking.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


import com.example.parking.model.EnterCar;

public interface EntercarRepository extends JpaRepository<EnterCar, String>{
	
	@Query(value = "select * from enter_car where parkinglot_id like CONCAT('%',:parkid,'%') AND car_num like CONCAT('%',:field,'%')",nativeQuery = true)
	Page<EnterCar> findByCarNum(@Param("parkid") Long parkid,@Param("field") String field,Pageable pageable);
	
	@Query(value = "select * from `enter_car` where parkinglot_id like CONCAT('%',:parkid,'%') AND parking_type like CONCAT('%',:word,'%')",nativeQuery = true)
	Page<EnterCar> findByParkingType(@Param("parkid") Long parkid,@Param("word") String word,Pageable pageable);
	
	@Query(value = "select * from enter_car where parkinglot_id like CONCAT('%',:parkid,'%') AND parking_type like CONCAT('%',:word,'%') AND car_num like CONCAT('%',:field,'%')",nativeQuery = true)
	public Page<EnterCar> bothSearch (@Param("parkid") Long parkid,@Param("word") String word,@Param("field") String field,Pageable pageable);
	
	@Query(value = "select count(*) from enter_car where parkinglot_id like CONCAT('%',:parkid,'%') AND parking_type like CONCAT('%',:word,'%') AND car_num like CONCAT('%',:field,'%')",nativeQuery = true)
	public Long cntbothSearch (@Param("parkid") Long parkid,@Param("word") String word,@Param("field") String field);
	
	@Query(value = "select count(*) from enter_car where parkinglot_id like CONCAT('%',:parkid,'%') AND car_num like CONCAT('%',:word,'%')",nativeQuery = true)
	public Long cntCarNumSearch (@Param("parkid") Long parkid,@Param("word") String field);
	
	@Query(value = "select count(*) from enter_car where parking_type like CONCAT('%',:word,'%')",nativeQuery = true)
	public Long cntParkingTypeSearch(@Param("word") String word);

	//주차장별 주차차량수
	@Query(value = "select count(*) from enter_car where parkinglot_id=?1 and parking_type like '자유주차'",nativeQuery = true)
	public int countByParkinglotId(Long parkinglotId);

	@Query(value = "select count(*) from enter_car where parkinglot_id like CONCAT('%',:parkid,'%') AND parking_type like CONCAT('%',:word,'%')",nativeQuery = true)
	public Long cntParkingTypeSearch(@Param("parkid") Long parkid,@Param("word") String word);

	@Query(value = "select count(*) from enter_car where parkinglot_id = :parkid and car_num = :carNum",nativeQuery = true)
	public Long carNumcheck(@Param("parkid") Long parkid,@Param("carNum") String carNum);

	Page<EnterCar> findByParkinglotId(Long parkid,Pageable pageable);

	@Query(value = "select count(*) from enter_car where parkinglot_id like CONCAT('%',:parkid,'%')",nativeQuery = true)
	public Long allcount(@Param("parkid") Long parkid);



}
