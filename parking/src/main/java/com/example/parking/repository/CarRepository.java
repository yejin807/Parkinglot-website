
package com.example.parking.repository;

import com.example.parking.model.Car;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface CarRepository extends JpaRepository<Car, String> {

    // 사용자별 차량등록대수
    @Query(value = "select * from car where username = ?1", nativeQuery = true)
    public List<Car> findByUsername(String username);

}