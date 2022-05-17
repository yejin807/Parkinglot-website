<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>주차장등록</h3>
<label>주차장명</label> <input type="text" /><br/>
<label>주소</label> <input type="text" /><button>찾기</button><br/>
<label>연락처</label> <input type="text" /><br/>
<label>운영시간</label> 
시작시간
<select>
<option>06:00</option>
<option>07:00</option>
<option>08:00</option>
<option>09:00</option>
<option>10:00</option>
<option>11:00</option>
<option>12:00</option>
</select> / 
종료시간
<select>
<option>20:00</option>
<option>21:00</option>
<option>22:00</option>
<option>23:00</option>
<option>24:00</option>
</select>
<br/>
<label>전체주차면수</label><input type="text" /><br/>
<label>기본요금(10분당)</label><input type="text" /><br/>
<label>일주차요금</label><input type="text" /><br/>
<label>월주차요금</label><input type="text" /><br/>
<label>사진등록</label><input type="file" /><br/>
</body>
</html>