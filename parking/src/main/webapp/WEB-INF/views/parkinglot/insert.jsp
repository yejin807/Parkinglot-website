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
<form>
<label>주차장명</label> <input type="text" name="parkingName" id="parkingName"/><br/>
<label>주소</label> <input type="text" name="addr" id="addr"/><button>찾기</button><br/>
<label>연락처</label> <input type="text" name="parkinglotTel" id="parkinglotTel"/><br/>
<label>운영방식</label>
<select name="operatingType" id="operatingType">
<option value="공영">공영</option>
<option value="민간">민간</option>
</select>

<label>운영시간</label> 
시작시간
<select name="openTime" id="openTime">
<option value="06:00">06:00</option>
<option value="07:00">07:00</option>
<option value="08:00">08:00</option>
<option value="09:00">09:00</option>
<option value="10:00">10:00</option>
<option value="11:00">11:00</option>
<option value="12:00">12:00</option>
</select> / 
종료시간
<select name="closeTime" id="closeTime">
<option value="20:00">20:00</option>
<option value="21:00">21:00</option>
<option value="22:00">22:00</option>
<option value="23:00">23:00</option>
<option value="24:00">24:00</option>
</select>
<br/>
<label>전체주차면수</label><input type="text" name="maxCnt" id="maxCnt"/><br/>
<label>기본요금(10분당)</label><input type="text" name="basicFee" id="basicFee"/><br/>
<label>일주차요금</label><input type="text" name="dayFee" id="dayFee"/><br/>
<label>월주차요금</label><input type="text" name="monthFee" id="monthFee"/><br/>
<label>사진등록</label><input type="file" name="files" id="files"/><br/>
</form>
</body>
</html>