<%@page import="controller.GetAddress"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="controller.rea"%>
<%@ page import="controller.getmapcenter"%>
<%@ page import="controller.GetAddress" %>
<%
rea rea=new rea();
ArrayList<String> name = rea.GetNamelist();
ArrayList<String> x = rea.GetXlist();
ArrayList<String> y = rea.GetYlist();

ArrayList<String> centeraddress = rea.GetCenteraddress();
ArrayList<String> centerx = rea.GetCenterx();
ArrayList<String> centery = rea.GetCentery();

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/map/map.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=eeb3697ba67b965b981c89f05428889e"></script>

</head>
<body>
	<div id="map" style="width: 100%; height: 650px;"></div>
	<p>
		<em>지도를 클릭해주세요!</em>
	</p>
	<div id="clickLatlng"></div>
	<script>
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		
		mapOption = {
			center : new kakao.maps.LatLng(<%=(String) centery.get(0)%>, <%=(String) centerx.get(0)%>), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};  
		
		var xlist=<%=x%>;
		var ylist=<%=y%>;
		var namelist=<%=name%>;
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		// 좌표 주소 값 저장하는 객체
		for (var i = 0 ; i < 15; i++){
			displayMarker(xlist[i],ylist[i],namelist[i]);
		
		}			
		
		// 마커 찍는 함수 
		
		function displayMarker(place_x,place_y,place_name) {
		    
		    // 마커 이미지의 이미지 크기 입니다
		    var imageSize = new kakao.maps.Size(24, 35); 
		    
		    // 마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		    // 마커를 생성하고 지도에 표시합니다
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: new kakao.maps.LatLng(place_y, place_x),
		    	image : markerImage
		    });

		    // 마커에 클릭이벤트를 등록합니다
		    kakao.maps.event.addListener(marker, 'click', function() {
		        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
		        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place_name + '</div>');
		        infowindow.open(map, marker);
		    });
		}

		// 마커 이미지의 이미지 주소입니다
		


	</script>
	<!--  <script src="resources/map/map.js"></script>-->

</body>
</html>