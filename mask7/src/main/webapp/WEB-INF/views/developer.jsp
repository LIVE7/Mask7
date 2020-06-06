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
				<h1 class="string-01" style="color: #000000;">DEVELOPER</h1>
			</div>
		</div>
	</div>

	<hr class="m-0">
	
	 <div class="col-md-10 offset-md-1">
                	<div id="map_canvas"
					style="width: 100%; height: 400px; margin: 0px;"></div>
					<br>
					<div class="row" >
					<div class="col-md-6">
					저희 마스크7 사이트는
					<br>
					「공적 마스크 판매 정보 API」와 
					<br>
					「Kakao Maps API」를 활용해 개발되었습니다.
					<br>
					저희 사이트에 방문해주셔서
					<br>
					감사합니다.
					</div>
					<div class="col-md-2">
						
						<img
							src="${pageContext.request.contextPath}/img/me.jpg"
							class="rounded-circle img-fluid">
					</div>
					<div class="col-md-4">
						<h4 class="text-left">최 원 영</h4>
						<span class="text-left text-success">010 - **** - ****</span><br>
						<span class="text-left text-primary">androidapk@naver.com</span><br>
						<span class="text-left">
							하루빨리 <br>코로나19가 종식되었으면 좋겠습니다.
						</span>
					</div>
					</div>
                </div>

</div>
<br>


<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKsUUTbcO8B_OqKncUxmnpnpZ3QnrSttg&callback=initMap"
	async defer></script>

<script>
	function initialize() {
		var myLatlng = new google.maps.LatLng(37.673328, 126.753973);
		var mapOptions = {
			zoom : 14,
			center : myLatlng,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		}
		var map = new google.maps.Map(document.getElementById('map_canvas'),
				mapOptions);
		var marker = new google.maps.Marker({
			position : myLatlng,
			map : map,
			title : "map"
		});
	}
	window.onload = initialize;
</script>


<c:import url="/foot" />