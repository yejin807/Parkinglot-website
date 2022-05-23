package com.example.parking.exception;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

// Controller에서 발생한 예외 처리 클래스
@ControllerAdvice
public class ControllerExceptionHandler {

    /* 유효성 검사 예외처리 핸들러 */
    // validated 에서 요류가 발생하면 MethodArgumentNotValidException이 발생한다
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Object> handleMethodArgumentNotValidException(MethodArgumentNotValidException ex) {
        BindingResult bindingResult = ex.getBindingResult();

        Map<String, String> errorMap = new HashMap<>();

        for (FieldError error : bindingResult.getFieldErrors()) {
            errorMap.put(error.getField(), error.getDefaultMessage());
        }
        return new ResponseEntity<>(errorMap, HttpStatus.BAD_REQUEST);

    }

    @ExceptionHandler(IllegalStateException.class)
    public ResponseEntity<Object> handleIllegalStateException(Exception e) {
        Map<String, String> errorMap = new HashMap<>();
        errorMap.put("username", "중복된 아이디입니다.");
        return new ResponseEntity<>(errorMap, HttpStatus.BAD_REQUEST);
    }
}