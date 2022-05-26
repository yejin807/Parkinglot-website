<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ include file="/WEB-INF/views/includes/header.jsp" %>
<script src="/js/member.js"></script>

<div class="pagename">
  <h1>차량 등록</h1>
</div>

<div class="page">
  <div class="container row">
    <div class="col">
      <label for="carNum">차량번호:</label>
      <input class="form-control" type="text" name="carNum" id="carNum" />
    </div>
    <div class="col">
      <label for="carName">차량 이름:</label>
      <input class="form-control" type="text" name="carName" id="carName" />
    </div>
    <div class="col align-self-end">
      <button class="btn btn-primary" id="btnCarRegister">등록하기</button>
    </div>
  </div>
</div>
