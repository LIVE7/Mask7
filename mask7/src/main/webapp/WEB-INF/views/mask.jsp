<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- top -->
<c:import url="/top"/>  

<!-- 여기에 추가 -->
<div class="container-fluid p-0">

	<hr class="m-0">

	<div>
		<div class="container text-center p-1 info-box">
			<div class="string-wrap">
				<h1 class="string-01" style="color: #000000;">마스크 사용 권고사항</h1>
			</div>
		</div>
	</div>

	<hr class="m-0">
	
	<div class="col-12">
        <img class="d-block w-100" src="./img/mask.png" alt="First slide">
    </div>
</div>
<br>
<c:import url="/foot" />