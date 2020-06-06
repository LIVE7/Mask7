<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%
	//쿠키 꺼내기 => 쿠키의 키값이 "saveId"가 있다면 해당 value값(사용자아아디)
	//				 을 꺼내서 input name이 userid인 곳에 value값으로 넣어준다.

	Cookie cks[] = request.getCookies();
	String uid = "";
	boolean isChk = false;
	if (cks != null) {
		for (Cookie c : cks) {
			String key = c.getName();//key값
			if (key.equals("saveId")) {
				uid = c.getValue();
				isChk = true;
				break;
			}
		}
	}
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>마스크7 - 공적마스크 재고현황 사이트</title>

<!-- Bootstrap core CSS -->
<link
	href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom fonts for this template -->
<link
	href="https://fonts.googleapis.com/css?family=Saira+Extra+Condensed:500,700"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Muli:400,400i,800,800i"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath}/css/resume.min.css"
	rel="stylesheet">

<!-- Favicon -->
<%-- <link rel="icon" href="${pageContext.request.contextPath}/img/core-img/favicon.ico"> --%>

<link rel="shortcut icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/img/mask7logo(150).png" />

<%-- <!-- Core Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"> --%>

<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css"> --%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mycss.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=66867b3c26da45c7681621cf168c0357&libraries=services"></script>
<script>
	var markers = [];
	var infowindow = new kakao.maps.InfoWindow({
		zIndex : 1,
		removable : true
	});
	var ps = new kakao.maps.services.Places;
	function addMarker(position, placeName, stateStr, remain_stat, atString) {
		if (remain_stat == "plenty") {
			var imageSrc = "./img/plenty.png", imageSize = new kakao.maps.Size(
					40, 20), imageOption = {
				offset : new kakao.maps.Point(20, 10)
			}
		} else if (remain_stat == "some") {
			var imageSrc = "./img/some.png", imageSize = new kakao.maps.Size(
					40, 20), imageOption = {
				offset : new kakao.maps.Point(20, 10)
			}
		} else if (remain_stat == "few") {
			var imageSrc = "./img/few.png", imageSize = new kakao.maps.Size(40,
					20), imageOption = {
				offset : new kakao.maps.Point(20, 10)
			}
		} else if (remain_stat == "empty") {
			var imageSrc = "./img/empty.png", imageSize = new kakao.maps.Size(
					40, 20), imageOption = {
				offset : new kakao.maps.Point(20, 10)
			}
		} else {
			var imageSrc = "./img/empty.png", imageSize = new kakao.maps.Size(
					40, 20), imageOption = {
				offset : new kakao.maps.Point(20, 10)
			}
		}
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
				imageOption);
		var marker = new kakao.maps.Marker({
			position : position,
			image : markerImage
		});
		marker.setMap(map);
		kakao.maps.event.addListener(marker, "click", function() {
			infowindow.setContent('<div style="padding:5px;font-size:12px;">'
					+ placeName + "<br>재고상태 : " + stateStr + atString
					+ "</div>");
			infowindow.open(map, marker)
		});
		markers.push(marker)
	}
	function setMarkers(map) {
		for (var i = 0; i < markers.length; i++) {
			markers[i].setMap(map)
		}
	}
	function placesSearchCB(data, status, pagination) {
		if (status === kakao.maps.services.Status.OK) {
			setMarkers(null);
			var bounds = new kakao.maps.LatLngBounds;
			for (var i = 0; i < data.length; i++) {
				displayMarker(data[i]);
				bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x))
			}
			map.setBounds(bounds)
		}
	}
	function displayMarker(place) {
		var marker = new kakao.maps.Marker({
			position : new kakao.maps.LatLng(place.y, place.x)
		});
		marker.setMap(map);
		kakao.maps.event.addListener(marker, "click", function() {
			infowindow.setContent('<div style="padding:5px;font-size:12px;">'
					+ place.place_name + "</div>");
			infowindow.open(map, marker)
		});
		markers.push(marker)
	}
	$(document)
			.ready(
					function() {
						$("#exampleModalScrollable").modal({
							backdrop : "static",
							keyboard : false
						});
						$(".place").submit(function() {
							var keyword = $(".keyword").val();
							ps.keywordSearch(keyword, placesSearchCB)
						});
						$(".place-sumit").click(function() {
							$(".place").trigger("submit")
						});
						$(".readmore").click(function() {
							location.href = "#stock-wrap"
						});
						$("#search_location")
								.click(
										function() {
											if (navigator.geolocation) {
												navigator.geolocation
														.getCurrentPosition(function(
																position) {
															var lat = position.coords.latitude, lon = position.coords.longitude;
															var locPosition = new kakao.maps.LatLng(
																	lat, lon);
															map
																	.setCenter(locPosition);
															map.setLevel(4)
														})
											} else {
												alert("위치를 켜주세요")
											}
										});
						$(".search2").click(function() {
							$(this).attr("disabled", "disabled");
							$("#sang").val("Y");
							$(".search1").trigger("click")
						});
						$(".search1")
								.click(
										function() {
											$(".readmore").css("display",
													"none");
											$(".loading").css("display",
													"block");
											$(".loading-suc").css("display",
													"none");
											$(".loading-fail").css("display",
													"none");
											$(".loading-no").css("display",
													"none");
											$(this)
													.attr("disabled",
															"disabled");
											var lat = map.getCenter().getLat();
											var lng = map.getCenter().getLng();
											$("#stock-wrap").empty();
											$
													.ajax({
														url : "https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByGeo/json?lat="
																+ lat
																+ "&lng="
																+ lng
																+ "&m=2000",
														dataType : "json",
														success : function(data) {
															if (data.count > 0) {
																setMarkers(null);
																var $cnt = data.count;
																if ($("#sang")
																		.val() == "Y") {
																	var cntinfo = ""
																} else {
																	var cntinfo = $(
																			"<span/>")
																			.text(
																					"총 "
																							+ $cnt
																							+ "건이 검색되었습니다.")
																}
																var statediv = $("<div/>");
																var stateinfo1 = $(
																		'<span class="badge badge-success"/>')
																		.text(
																				"100▲")
																		.css(
																				"margin-right",
																				"3px");
																var stateinfo2 = $(
																		'<span class="badge badge-warning"/>')
																		.text(
																				"30~99개")
																		.css(
																				"margin-right",
																				"3px");
																var stateinfo3 = $(
																		'<span class="badge badge-danger"/>')
																		.text(
																				"1~29개");
																statediv
																		.append(
																				stateinfo1,
																				stateinfo2,
																				stateinfo3);
																statediv
																		.css(
																				"float",
																				"right")
																		.css(
																				"margin-bottom",
																				"3px");
																var tb = $(
																		'<table class="table" />')
																		.css(
																				"text-align",
																				"center");
																var th = $("<thead/>");
																var thdata = $(
																		"<tr />")
																		.append(
																				$(
																						'<th scope="col"/>')
																						.text(
																								"No."),
																				$(
																						'<th scope="col"/>')
																						.text(
																								"업체명 (클릭)"),
																				$(
																						'<th scope="col"/>')
																						.text(
																								"입고 시간"),
																				$(
																						'<th scope="col"/>')
																						.text(
																								"재고 상태"));
																th
																		.append(thdata);
																tb.append(th);
																var bounds = new kakao.maps.LatLngBounds;
																var checkcnt = 0;
																for ( var i in data.stores) {
																	if (data.stores[i].remain_stat == "plenty") {
																		var stateBtn = $(
																				'<span class="badge badge-success"/>')
																				.text(
																						"충분");
																		var stateStr = '<span class="badge badge-success">충분</span>'
																	} else if (data.stores[i].remain_stat == "some") {
																		var stateBtn = $(
																				'<span class="badge badge-warning"/>')
																				.text(
																						"보통");
																		var stateStr = '<span class="badge badge-warning">보통</span>'
																	} else if (data.stores[i].remain_stat == "few") {
																		var stateBtn = $(
																				'<span class="badge badge-danger"/>')
																				.text(
																						"부족");
																		var stateStr = '<span class="badge badge-danger">부족</span>'
																	} else if (data.stores[i].remain_stat == "empty") {
																		var stateBtn = $(
																				'<span class="badge badge-light"/>')
																				.text(
																						"품절");
																		var stateStr = '<span class="badge badge-light">품절</span>'
																	} else if (data.stores[i].remain_stat == "break") {
																		var stateBtn = $(
																				'<span class="badge badge-light"/>')
																				.text(
																						"판매중지");
																		var stateStr = '<span class="badge badge-light">판매중지</span>'
																	} else {
																		var stateBtn = $(
																				'<span class="badge badge-dark"/>')
																				.text(
																						"정보없음");
																		var stateStr = '<span class="badge badge-dark">정보없음</span>'
																	}
																	var atText = "";
																	var hourText = "";
																	if (data.stores[i].stock_at) {
																		atText = data.stores[i].stock_at
																				.substring(
																						5,
																						16);
																		hourText = data.stores[i].stock_at
																				.substring(
																						11,
																						13)
																	}
																	var now = new Date;
																	var nowString = now
																			.getMonth()
																			+ 1
																			+ "/"
																			+ now
																					.getDate();
																	var nowHour = now
																			.getHours();
																	nowString = "0"
																			+ nowString;
																	if (atText
																			.indexOf(nowString) > -1
																			&& nowHour
																					- hourText < 3) {
																		var atData = $(
																				'<span class="badge badge-primary"/>')
																				.text(
																						"최근입고")
																				.css(
																						"margin-left",
																						"2px");
																		var atString = '<span class="badge badge-primary" style="margin-left:2px;">최근입고</span>'
																	} else {
																		var atData = "";
																		var atString = "";
																		if ($(
																				"#sang")
																				.val() == "Y") {
																			continue
																		}
																	}
																	checkcnt++;
																	var row = $(
																			"<tr />")
																			.append(
																					$(
																							"<th scope='col'/>")
																							.text(
																									Number(i) + 1),
																					$(
																							"<td id='name"+i+"'/>")
																							.text(
																									data.stores[i].name),
																					$(
																							"<td />")
																							.append(
																									atText,
																									atData),
																					$(
																							"<td />")
																							.append(
																									stateBtn));
																	var hiddenlat = $(
																			'<input type="hidden" id="lat"/>')
																			.val(
																					data.stores[i].lat);
																	var hiddenlng = $(
																			'<input type="hidden" id="lng"/>')
																			.val(
																					data.stores[i].lng);
																	row
																			.children(
																					"#name"
																							+ i)
																			.append(
																					hiddenlat,
																					hiddenlng);
																	row
																			.children(
																					"#name"
																							+ i)
																			.click(
																					function() {
																						if ($(
																								this)
																								.children(
																										"#lat")
																								.val()
																								&& $(
																										this)
																										.children(
																												"#lng")
																										.val()) {
																							map
																									.setLevel(1);
																							var mLag = $(
																									this)
																									.children(
																											"#lat")
																									.val();
																							var mLng = $(
																									this)
																									.children(
																											"#lng")
																									.val();
																							var movLatLng = new kakao.maps.LatLng(
																									mLag,
																									mLng);
																							map
																									.setCenter(movLatLng);
																							location.href = "#map-wrap"
																						}
																					});
																	tb
																			.append(row);
																	if (data.stores[i].lat
																			&& data.stores[i].lng) {
																		addMarker(
																				new kakao.maps.LatLng(
																						data.stores[i].lat,
																						data.stores[i].lng),
																				data.stores[i].name,
																				stateStr,
																				data.stores[i].remain_stat,
																				atString);
																		bounds
																				.extend(new kakao.maps.LatLng(
																						data.stores[i].lat,
																						data.stores[i].lng))
																	}
																}
																if (checkcnt > 0) {
																	map
																			.setBounds(bounds)
																}
																$("#stock-wrap")
																		.append(
																				cntinfo);
																$("#stock-wrap")
																		.append(
																				statediv);
																$("#stock-wrap")
																		.append(
																				tb);
																$(".readmore")
																		.css(
																				"display",
																				"inline-block");
																$(".loading")
																		.css(
																				"display",
																				"none");
																$(
																		".loading-suc")
																		.css(
																				"display",
																				"block");
																$(".search1")
																		.removeAttr(
																				"disabled");
																$(".search2")
																		.removeAttr(
																				"disabled");
																$("#sang").val(
																		"N")
															} else {
																$(".loading")
																		.css(
																				"display",
																				"none");
																$(".loading-no")
																		.css(
																				"display",
																				"block");
																$(".search1")
																		.removeAttr(
																				"disabled");
																$(".search2")
																		.removeAttr(
																				"disabled");
																$("#sang").val(
																		"N")
															}
														},
														error : function(r) {
															$(".loading").css(
																	"display",
																	"none");
															$(".loading-fail")
																	.css(
																			"display",
																			"block");
															$(".search1")
																	.removeAttr(
																			"disabled")
														}
													})
										})
					});

</script>
<script src="http://code.jquery.com/jquery-1.9.0.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
</head>

<body id="page-top">
	<div id="layer-popup1"
		style="position: absolute; z-index: 1500; visibility: hidden;">
		<a href="javascript:changePage1();"><img
			src="${pageContext.request.contextPath}/img/info.png"
			class="img-thumbnail" width="640" height="427"></a>
		<div class="close-bar" align="right"
			style="background-color: white; border: 3px;">
			<form name="popform1" method="post" action="">
				<span class="left"><input type="checkbox" name="popup" />&nbsp;오늘
					하루 이 창을 열지 않음</span> <a href="javascript:closeLayer1();" title="닫기"
					class="right"><B>&nbsp;[닫기]&nbsp;</B></a>
			</form>
		</div>
	</div>

	<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top"
		id="sideNav">
		<a class="navbar-brand js-scroll-trigger" href="main"> <span
			class="d-block d-lg-none">MASK7 공적마스크 재고현황</span> <span
			class="d-none d-lg-block"> <img
				class="img-fluid img-profile rounded-circle mx-auto mb-2"
				src="${pageContext.request.contextPath}/img/mask7logo.gif" alt="">
		</span>
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="main" style="color: white; font-weight: bold; font-size: 20px;">공적마스크 재고현황</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="covid" style="color: white; font-weight: bold; font-size: 20px;">코로나19 행동수칙</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="mask" style="color: white; font-weight: bold; font-size: 20px;">마스크 사용 권고사항</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="mask5" style="color: white; font-weight: bold; font-size: 20px;">마스크 5부제란</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="http://0254.duckdns.org:9090/corona7" style="color: white; font-weight: bold; font-size: 20px;">코로나7</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="developer" style="color: white; font-weight: bold; font-size: 20px;">DEVELOPER</a></li>
			</ul>
		</div>

	</nav>

	<script>
		//Popup
		if (getCookie("popup_check1") != "done") { // popup_check가 설정안되어있으면 보여주기
			document.getElementById("layer-popup1").style.visibility = "visible"
			$("#layer-popup1").draggable();
		}

		function getCookie(name) //저장된 쿠키구하기
		{
			var nameOfCookie = name + "=";
			var x = 0;
			while (x <= document.cookie.length) {
				var y = (x + nameOfCookie.length);
				if (document.cookie.substring(x, y) == nameOfCookie)

				{
					if ((endOfCookie = document.cookie.indexOf(";", y)) == -1)
						endOfCookie = document.cookie.length;
					return unescape(document.cookie.substring(y, endOfCookie));
				}
				x = document.cookie.indexOf(" ", x) + 1;
				if (x == 0)
					break;
			}
			return "";
		}

		function setCookie(name, value, expiredays) { //쿠키 설정
			var todayDate = new Date();
			todayDate.setDate(todayDate.getDate() + expiredays);
			document.cookie = name + "=" + escape(value) + "; path=/; expires="
					+ todayDate.toGMTString() + ";"
			//document.cookie = name + "=" + value + "; path=/; expires=" + todayDate.toGMTString() + ";" 
		}

		function closeLayer1() { // 오늘하루보기가 체크 유무에 따른 쿠기 설정
			if (document.popform1.popup.checked) {
				setCookie("popup_check1", "done", 1);
			}
			$("div#layer-popup1").hide();
		}

		function changePage1() { //만약 팝업1 바로 눌렀을때           
			location.href = "#";
			$("div#layer-popup1").hide();
		}
	</script>