package com.example.parking.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.parking.model.Car;

public interface CarRepository extends JpaRepository<Car, String>{
	
	Page<Car> findByCarNumContaining(String word,Pageable pageable);

	Page<Car> findByParkingTypeContaining(String word,Pageable pageable);
	
	@Query(value = "select * from car where parking_type like CONCAT('%',:field,'%') AND car_num like CONCAT('%',:word,'%')",nativeQuery = true)
	public Page<Car> bothSearch (@Param("field") String field,@Param("word") String word,Pageable pageable);
	
	@Query(value = "select count(*) from car where parking_type like CONCAT('%',:field,'%') AND car_num like CONCAT('%',:word,'%')",nativeQuery = true)
	public Long cntbothSearch (@Param("word") String word,@Param("field") String field);
	
	@Query(value = "select count(*) from car where car_num like CONCAT('%',:word,'%')",nativeQuery = true)
	public Long cntCarNumSearch (@Param("word") String field);
	
	@Query(value = "select count(*) from car where parking_type like CONCAT('%',:word,'%')",nativeQuery = true)
	public Long cntParkingTypeSearch(@Param("word") String word);
}
