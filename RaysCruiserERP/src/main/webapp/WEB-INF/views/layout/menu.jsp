<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page isELIgnored="false"%>

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
<spring:url value="/" var="homeUrl" />
<spring:url value="/orders" var="showOrdersUrl" />
<spring:url value="/items" var="showItemsUrl"/>
<spring:url value="/item_types" var="showItemTypesUrl"/>
<div>
	
		<a href="${homeUrl}" class="nav_link">Home</a><br/><br/>
		<a href="${showOrdersUrl}" class="nav_link">Orders</a><br/><br/>
		<a href="${showItemsUrl}" class="nav_link">Items</a></br/><br/>
		<a href="${showItemTypesUrl}" class="nav_link">Item Types</a><br/><br/>
	
</div>