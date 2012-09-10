<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
 <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
 <%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js" ></script>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.5/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src='https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.5/jquery-ui.min.js' type='text/javascript'></script>
<script>
	$(function() {
		$( "#delivery_date" ).datepicker({ dateFormat: "dd-MM-yy" } );
	});
</script>

<title>Set Delivery Date for ${order.name}</title>
</head>
<body>
<spring:url value="/orders/update" var="updateOrderUrl"/>
<spring:url value="/orders/set_delivery" var="setOrderDeliveryUrl"/>

<spring:url value="/orders" var="createOrdersUrl"/>
<form:form method="POST" id='form' modelAttribute="order" action="${updateOrderUrl}">
<h1 id='banner'>Edit '${order.name}' </h1>
	<hr/>
	<form:hidden path="id" id="id" value="${order.id}"/> 
	<form:hidden path="owner_id" id="owner_id"  value="${order.owner_id}"/>
	<form:hidden path="submitted" id="submitted" value="${order.submitted}"/>
	<form:hidden path="sf_cruiser_order_id" id="sf_cruiser_order_id" value="${order.sf_cruiser_order_id}"/>
	<form:hidden path="name" id="name" />
	<form:hidden path="description" id="description"/>

	<label>Name:</label> <span>${order.name}</span> <br/>
	<label>Description:</label> <span>${order.description}</span> <br/>
	<label>Submitted:</label> <span>${order.submitted}</span> <br/>
	<label>OwnerId:</label> <span>${order.owner_id}</span> <br/>
	<label>SF Cruiser Order Id:</label> <span>${order.sf_cruiser_order_id}</span> <br/>	
	
	<label>Delivery Date:</label> <span> <form:input path="delivery_date" id="delivery_date"/></span> <br/>
	
	<button type="submit">Save</button>
	<button type="reset" onclick="document.location.href=${setOrderDeliveryUrl}/${order.id}">Reset</button>
</form:form>
</body>
</html>
