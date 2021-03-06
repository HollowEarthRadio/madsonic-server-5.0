<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="iso-8859-1"%>

<html><head>
    <%@ include file="head.jsp" %>
    <%@ include file="jquery.jsp" %>
	
    <c:if test="${model.customScrollbar}">
	<link href="<c:url value="/style/customScrollbar.css"/>" rel="stylesheet">
	<script type="text/javascript" src="<c:url value="/script/jquery.mousewheel.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/script/jquery.mCustomScrollbar.js"/>"></script>
    </c:if>		
	
    <script type="text/javascript" src="<c:url value="/dwr/util.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/dwr/engine.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/dwr/interface/starService.js"/>"></script>
    <script type="text/javascript" language="javascript">

        function toggleStar(mediaFileId, imageId) {
            if ($(imageId).attr("src").indexOf("<spring:theme code="ratingOnImage"/>") != -1) {
                $(imageId).attr("src", "<spring:theme code="ratingOffImage"/>");
                starService.unstar(mediaFileId);
            }
            else if ($(imageId).attr("src").indexOf("<spring:theme code="ratingOffImage"/>") != -1) {
                $(imageId).attr("src", "<spring:theme code="ratingOnImage"/>");
                starService.star(mediaFileId);
            }
        }
    </script>
</head>
<body class="mainframe bgcolor1">

<!-- content block -->

<div id="content_2" class="content_main">
<!-- CONTENT -->

<h1>
    <img src="<spring:theme code="historyImage"/>" alt="">
    <fmt:message key="history.title"/>
</h1>

<h2>
    <c:forTokens items="audio audiobook podcast video" delims=" " var="cat" varStatus="loopStatus">
        <c:if test="${loopStatus.count > 1}">&nbsp;<img src="<spring:theme code="sepImage"/>">&nbsp;</c:if>
        <sub:url var="url" value="history.view">
            <sub:param name="listType" value="${cat}"/>
        </sub:url>
        <c:choose>
            <c:when test="${model.listType eq cat}">
                <span class="headerSelected"><fmt:message key="history.${cat}.title"/></span>
            </c:when>
            <c:otherwise>
                <a href="${url}"><fmt:message key="history.${cat}.title"/></a>
            </c:otherwise>
        </c:choose>
    </c:forTokens>
</h2>

<c:choose>
	<c:when test="${model.listType eq 'audio'}">
	<!-- audio --> 
	</c:when>
</c:choose>
<c:choose>
	<c:when test="${model.listType eq 'audiobook'}">
	<!-- audiobook -->
	</c:when>
</c:choose>
<c:choose>
	<c:when test="${model.listType eq 'podcast'}">
	<!-- podcast --> 
	</c:when>
</c:choose>
<c:choose>
	<c:when test="${model.listType eq 'video'}">
	<!-- video --> 
	</c:when>
</c:choose>

<c:if test="${not empty model.songs}">
	<h2></h2>
	<table style="border-collapse:collapse">
		<c:forEach items="${model.songs}" var="song" varStatus="loopStatus">

			<sub:url value="/main.view" var="mainUrl">
				<sub:param name="path" value="${song.parentPath}"/>
			</sub:url>

			<tr>
				<c:import url="playAddDownload.jsp">
					<c:param name="id" value="${song.id}"/>
					<c:param name="playEnabled" value="${model.user.streamRole and not model.partyModeEnabled}"/>
					<c:param name="addEnabled" value="${model.user.streamRole and (not model.partyModeEnabled or not song.directory)}"/>
					<c:param name="downloadEnabled" value="${model.user.downloadRole and not model.partyModeEnabled}"/>
					<c:param name="starEnabled" value="true"/>
					<c:param name="starred" value="${not empty song.starredDate}"/>
					<c:param name="video" value="${model.listType eq 'video'}"/>
					<c:param name="asTable" value="true"/>
				</c:import>


				
				<td ${loopStatus.count % 2 == 1 ? "class='bgcolor2'" : ""} style="padding-left:0.25em;padding-right:1.25em">
					<str:truncateNicely upper="40">${song.title}</str:truncateNicely>
				</td>

				<td ${loopStatus.count % 2 == 1 ? "class='bgcolor2'" : ""} style="padding-right:1.25em">
					<a href="${mainUrl}"><span class="detail"><str:truncateNicely upper="40">${song.albumName}</str:truncateNicely></span></a>
				</td>

				<td ${loopStatus.count % 2 == 1 ? "class='bgcolor2'" : ""} style="padding-right:1.25em">
					<span class="detail"><str:truncateNicely upper="40">${song.artist}</str:truncateNicely></span>
				</td>
			
				<td ${loopStatus.count % 2 == 1 ? "class='bgcolor2'" : ""} style="padding-right:1.25em">
					<span class="detail">${fn:substring(song.lastPlayed, 0, 16)}</span>
				</td>
				
				<td ${loopStatus.count % 2 == 1 ? "class='bgcolor2'" : ""} style="padding-right:0.75em">
					<span class="detail">${fn:substring(song.firstScanned, 0, 19)}</span>
				</td>
				</tr>
				
		</c:forEach>
	</table>
	<table>
		<tr style="padding-top:2.5em">
		</tr>
		<tr>
			<sub:url value="history.view" var="previousUrl">
				<sub:param name="listOffset" value="${model.listOffset - model.listSize}"/>
				<sub:param name="listType" value="${model.listType}"/>
				</sub:url>
			<sub:url value="history.view" var="nextUrl">
				<sub:param name="listOffset" value="${model.listOffset + model.listSize}"/>
				<sub:param name="listType" value="${model.listType}"/>
				</sub:url>

			<td style="padding-right:1.5em"><div class="back"><a href="${previousUrl}"><fmt:message key="common.previous"/></a></div></td>
			<td style="padding-right:1.5em"><fmt:message key="history.title"><fmt:param value="${model.listOffset + 1}"/><fmt:param value="${model.listOffset + model.listSize}"/></fmt:message></td>
			<td><div class="forwardright"><a href="${nextUrl}"><fmt:message key="common.next"/></a></div></td>				
			
		</tr>
	</table>
</c:if>


<!-- CONTENT -->
</div>

</body>

<c:if test="${model.customScrollbar}">
<script type="text/javascript">        
(function($){
	$(window).load(function(){
		$("#content_2").mCustomScrollbar({
			set_width:false, /*optional element width: boolean, pixels, percentage*/
			set_height:false, /*optional element height: boolean, pixels, percentage*/
			horizontalScroll:false, /*scroll horizontally: boolean*/
			scrollInertia:400, /*scrolling inertia: integer (milliseconds)*/
			scrollEasing:"easeOutCubic", /*scrolling easing: string*/
			mouseWheel:"auto", /*mousewheel support and velocity: boolean, "auto", integer*/
			autoDraggerLength:true, /*auto-adjust scrollbar dragger length: boolean*/
			scrollButtons:{ /*scroll buttons*/
				enable:true, /*scroll buttons support: boolean*/
				scrollType:"pixels", /*scroll buttons scrolling type: "continuous", "pixels"*/
				scrollSpeed:35, /*scroll buttons continuous scrolling speed: integer*/
				scrollAmount:250 /*scroll buttons pixels scroll amount: integer (pixels)*/
			},
			advanced:{
				updateOnBrowserResize:true, /*update scrollbars on browser resize (for layouts based on percentages): boolean*/
				updateOnContentResize:true, /*auto-update scrollbars on content resize (for dynamic content): boolean*/
				autoExpandHorizontalScroll:false /*auto expand width for horizontal scrolling: boolean*/
			},
			callbacks:{
				onScroll:function(){}, /*user custom callback function on scroll event*/
				onTotalScroll:function(){}, /*user custom callback function on bottom reached event*/
				onTotalScrollOffset:0 /*bottom reached offset: integer (pixels)*/
			}
		});
	});
})(jQuery);

$(".content_main").resize(function(e){
	$(".content_main").mCustomScrollbar("update");
});
</script>
</c:if>	
</html>