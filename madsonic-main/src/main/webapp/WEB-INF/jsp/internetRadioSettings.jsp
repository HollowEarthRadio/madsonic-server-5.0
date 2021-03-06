<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="iso-8859-1" %>

<html><head>
    <%@ include file="head.jsp" %>
    <%@ include file="jquery.jsp" %>
	<link href="<c:url value="/style/customScrollbar.css"/>" rel="stylesheet">	
</head>
<body class="mainframe bgcolor1">

<div id="content_2" class="content_main">
<!-- CONTENT -->

<c:import url="settingsHeader.jsp">
    <c:param name="cat" value="internetRadio"/>
    <c:param name="toast" value="${model.reload}"/>
</c:import>
<br>
<form method="post" action="internetRadioSettings.view">
<table class="indent">
    <tr>
        <th><fmt:message key="internetradiosettings.name"/></th>
        <th><fmt:message key="internetradiosettings.streamurl"/></th>
        <th><fmt:message key="internetradiosettings.homepageurl"/></th>
        <th style="padding-left:1em"><fmt:message key="internetradiosettings.enabled"/></th>
        <th style="padding-left:1em"><fmt:message key="common.delete"/></th>
    </tr>

    <c:forEach items="${model.internetRadios}" var="radio">
        <tr>
            <td><input type="text" name="name[${radio.id}]" size="20" value="${radio.name}"/></td>
            <td><input type="text" name="streamUrl[${radio.id}]" size="40" value="${radio.streamUrl}"/></td>
            <td><input type="text" name="homepageUrl[${radio.id}]" size="40" value="${radio.homepageUrl}"/></td>
            <td align="center" style="padding-left:1em"><input type="checkbox" ${radio.enabled ? "checked" : ""} name="enabled[${radio.id}]" class="checkbox"/></td>
            <td align="center" style="padding-left:1em"><input type="checkbox" name="delete[${radio.id}]" class="checkbox"/></td>
        </tr>
    </c:forEach>

    <tr>
        <th colspan="5" align="left" style="padding-top:1em"><fmt:message key="internetradiosettings.add"/></th>
    </tr>

    <tr>
        <td><input type="text" name="name" size="20"/></td>
        <td><input type="text" name="streamUrl" size="40"/></td>
        <td><input type="text" name="homepageUrl" size="40"/></td>
        <td align="center" style="padding-left:1em"><input name="enabled" checked type="checkbox" class="checkbox"/></td>
        <td/>
    </tr>

    <tr>
        <td style="padding-top:1.5em" colspan="5">
            <input type="submit" value="<fmt:message key="common.save"/>" style="margin-right:0.3em">
            <input type="button" value="<fmt:message key="common.cancel"/>" onclick="location.href='nowPlaying.view'">
        </td>
    </tr>
</table>
</form>


<c:if test="${not empty model.error}">
    <p class="warning"><fmt:message key="${model.error}"/></p>
</c:if>

<c:if test="${model.reload}">
    <script language="javascript" type="text/javascript">parent.frames.left.location.href="left.view?"</script>
</c:if>
<!-- CONTENT -->
</div>
</body></html>