<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- top -->
<c:import url="/top" />

<!-- 여기에 추가 -->
<div class="container-fluid p-0">

	<hr class="m-0">

	<div>
		<div class="container text-center p-1 info-box">
			<div class="string-wrap">
				<h1 class="string-01" style="color: #000000;">공적마스크 재고현황</h1>
			</div>
		</div>
	</div>

	<hr class="m-0">


	


	<div class="container p-3 my-3 text-center">
		<div class="alert alert-warning alert-dismissible fade show">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			현재 위치를 반영하기 때문에 위치정보 접근 권한을 허용해주시기 바랍니다.
		</div>
		<div class="alert alert-warning alert-dismissible fade show">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			공적마스크 재고 정보는 <strong>최소 5~10분</strong> 지연된 정보입니다.
		</div>



		<div class="border border-secondary rounded" id="map-wrap">
			<div id="map" style="margin-bottom: 5px;"></div>
			<div>
				<form class="form-inline place" onsubmit="return false;">
					<input type="text" class="form-control ml-auto keyword"
						placeholder="검색할 장소를 입력하세요">
					<button type="button" class="btn btn-success ml-1 place-sumit">검색</button>
					<button id="search_location" type="button"
						class="btn btn-primary ml-1">현재 위치로</button>
				</form>
			</div>
			<p></p>
			<div>※ 현재 위치에서 검색하시려면 현재 위치로를 클릭하신 후 아래의 찾기를 클릭하시기 바랍니다.</div>
			<div>※ 다른 위치에서 검색하시려면 장소를 검색 후 해당 장소가 지도에 뜨면 아래의 찾기를 클릭하시기 바랍니다.</div>
		</div>
		<p>※ 현재 위치를 기준으로 반경 2km내의 공적마스크 판매처를 검색합니다.</p>


		<div class="alert alert-info alert-dismissible fade show loading"
			role="alert" style="margin-top: 10px; display: none;">
			검색중입니다. 잠시만 기다려 주십시오.
		</div>
		<div
			class="alert alert-primary alert-dismissible fade show loading-suc"
			role="alert" style="margin-top: 10px; display: none;">
			검색이 완료되었습니다.
		</div>
		<div class="alert alert-danger alert-dismissible fade show loading-no"
			role="alert" style="margin-top: 10px; display: none;">
			인근에 판매처가 없거나 데이터를 불러오는데 실패했습니다.
		</div>
		<div
			class="alert alert-danger alert-dismissible fade show loading-fail"
			role="alert" style="margin-top: 10px; display: none;">
			오류로 인하여 검색에 실패하였습니다. 다시 시도해 보시기 바랍니다.
		</div>


		<button type="button" class="btn btn-info search1 btn-sm"
			style="margin-right: 5px;">찾기</button>
		<button type="button" class="btn btn-info search2 btn-sm"
			style="margin-right: 5px;">최근 입고된 곳만 찾기</button>
		<button type="button" class="btn btn-warning readmore btn-sm"
			style="display: none;">상세보기</button>
		<input type="hidden" id="sang" value="N" />

	</div>

	<div class="container p-3 my-3">

		<div id="stock-wrap"></div>

	</div>


</div>

<script>
	var mapContainer = document.getElementById("map"), mapOption = {
		center : new kakao.maps.LatLng(37.673328, 126.753973),
		level : 5
	};
	var map = new kakao.maps.Map(mapContainer, mapOption);
	if (navigator.geolocation) {
		navigator.geolocation
				.getCurrentPosition(function(position) {
					var lat = position.coords.latitude, lon = position.coords.longitude;
					var locPosition = new kakao.maps.LatLng(lat, lon);
					map.setCenter(locPosition)
				})
	} else {
	}
</script>


<c:import url="/foot" />