<%@page import="controller.GetAddress"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="controller.rea"%>
<%@ page import="controller.getmapcenter"%>
<%@ page import="controller.GetAddress" %>
<%
rea rea = new rea();
ArrayList<String> name = rea.GetNamelist();
ArrayList<String> x = rea.GetXlist();
ArrayList<String> y = rea.GetYlist();

ArrayList<String> centeraddress = rea.GetCenteraddress();
ArrayList<String> centerx = rea.GetCenterx();
ArrayList<String> centery = rea.GetCentery();
ArrayList<String> road = rea.GetRoadlist();
ArrayList<String> addr = rea.GetAddresslist();
ArrayList<String> url = rea.GetUrllist();
ArrayList<String> phone = rea.GetPhonelist();
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
	<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
                <p>근처 도서관</p>
                
            </div>
        </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
</div>

	<script>
		var mapcentery=<%= rea.GetCentery().get(0)%>;
		var mapcenterx=<%= rea.GetCenterx().get(0)%>;
		var xlist=<%=rea.GetXlist()%>;
		var ylist=<%=rea.GetYlist()%>;
		var namelist=<%=rea.GetNamelist()%>;
		var addrlist=<%=rea.GetAddresslist()%>;
		var roadlist=<%=rea.GetRoadlist()%>;
		var phonelist=<%=rea.GetPhonelist()%>;
		var urllist=<%=rea.GetUrllist()%>;
	
	
	
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		 
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		
		mapOption = {
			center : new kakao.maps.LatLng(<%=(String) centery.get(0)%>, <%=(String) centerx.get(0)%>), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};  

		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		// 좌표 주소 값 저장하는 객체
		for (var i = 0 ; i < 15; i++){
			displayMarker(i,xlist[i],ylist[i],namelist[i]);
			displayList(i);
		}			
		
		// 마커 찍는 함수 
		
		function displayMarker(idx,place_x,place_y,place_name) {
		    
		    // 마커 이미지의 이미지 크기 입니다
		    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', 
		    imageSize = new kakao.maps.Size(36, 37), 
		    imgOptions =  {
		            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
		            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		        };
		    // 마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,imgOptions); 
		    // 마커를 생성하고 지도에 표시합니다
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: new kakao.maps.LatLng(place_y, place_x),
		        title: place_name,
		    	image : markerImage
		    });
		    // 마커에 클릭이벤트를 등록합니다
		    kakao.maps.event.addListener(marker, 'click', function() {
		        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
		        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place_name + '</div>');
		        infowindow.open(map, marker);
		    });
		}
		function displayList(){
		    var listEl = document.getElementById('placesList'), 
		    menuEl = document.getElementById('menu_wrap'),
		    fragment = document.createDocumentFragment(), 
		    
		    listStr = '';
		    
		    var itemEl = getListItem(i); // 검색 결과 항목 Element를 생성합니다
		    //목록 마우스 올릴시 인포윈도우 
     
            fragment.appendChild(itemEl);

            listEl.appendChild(fragment);
            menuEl.scrollTop = 0;
            
		}
		function getListItem(index) {

		    var el = document.createElement('li'),
		    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
		                '<div class="info">' +
		                '   <h5><a href ='+urllist[i]+'>'+ namelist[i] + '</a> </h5>';

		  
	        itemStr += '    <span>' + roadlist[i]+ '</span>' +
		                    '   <span class="jibun gray">' +  addrlist[i]+ '</span>';
		                 
		    itemStr += '  <span class="tel">' + phonelist[i]  + '</span>' +
		                '</div>';           
			
		    el.innerHTML = itemStr;
		    el.className = 'item';

		    return el;
		}
		function displayInfowindow(marker,title) {
		    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

		    infowindow.setContent(content);
		    infowindow.open(map, marker);
		}
		// 마커 이미지의 이미지 주소입니다
		
	</script>
	<!--  <script src="resources/map/map.js"></script>-->

</body>
</html>