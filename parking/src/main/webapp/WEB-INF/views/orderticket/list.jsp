<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ include file="/WEB-INF/views/includes/header.jsp"%>


<div class="container mt-3">
<h3>주차장 등록(사장님)</h3>
<form action="/parkinglot/insert" method="post" enctype="multipart/form-data">
	<table border="1">
		<tr>
			<td>주차장명</td>
			<td colspan="2"><input type="text" name="parkingName" id="parkingName" /></td>
		</tr>
		<tr>
			<td>주소</td>
			<td><input type="text" name="addr" id="addr" placeholder="주소" readonly> <input
				type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"><br />
				위도<input type="text" name="wido" id="wido" readonly><br/>
				경도<input type="text" name="gyeongdo" id="gyeongdo" readonly></td>
			<td style="width: 300px; height: 300px"><div id="map" style="width: 300px; height: 300px; display: none"></div></td>
		</tr>
		<tr>
			<td>연락처(휴대폰)</td>
			<td colspan="2"><input type="text" name="parkinglotTel" id="parkinglotTel" /></td>
		</tr>
		<tr>
			<td>운영방식</td>
			<td colspan="2"><select name="operatingType" id="operatingType">
					<option value="공영">공영</option>
					<option value="민간">민간</option>
				</select>
			</td>
		</tr>

		<tr>
			<td>운영시간</td>
			<td>시작시간 
					<select name="openTime" id="openTime">
					<option value="06:00">06:00</option>
					<option value="07:00">07:00</option>
					<option value="08:00">08:00</option>
					<option value="09:00">09:00</option>
					<option value="10:00">10:00</option>
					<option value="11:00">11:00</option>
					<option value="12:00">12:00</option>
					</select>
			</td>
			<td>종료시간 
					<select name="closeTime" id="closeTime">
					<option value="20:00">20:00</option>
					<option value="21:00">21:00</option>
					<option value="22:00">22:00</option>
					<option value="23:00">23:00</option>
					<option value="24:00">24:00</option>
					</select>
			</td>
		</tr>
		<tr>
			<td>전체주차면수</td>
			<td colspan="2"><input type="text" name="maxCnt" id="maxCnt" />대</td>
		</tr>
		<tr>
			<td>기본요금(10분당)</td>
			<td colspan="2"><input type="text" name="basicFee" id="basicFee" />원</td>
		</tr>
		<tr>
			<td>일주차요금</td>
			<td colspan="2"><input type="text" name="dayFee" id="dayFee" />원</td>
		</tr>
		<tr>
			<td>월주차요금</td>
			<td colspan="2"><input type="text" name="monthFee" id="monthFee" />원</td>
		</tr>
		<tr>
			<td>사진등록</td>
			<td colspan="2"><input type="file" name="upload" id="upload" /></td>
		</tr>
		<tr>
		<td colspan="3">
		<button type="button" class="btn btn-primary" id="btnInsert" >등록</button>
		<button type="reset" class="btn btn-secondary">취소</button></td>
		</tr>
	</table>
</form>
</div>
</body>
</html>