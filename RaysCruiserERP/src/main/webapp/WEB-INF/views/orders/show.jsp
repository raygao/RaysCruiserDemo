<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
 <%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>${order.name}</title>
</head>
<body>
	<spring:url value="/orders/edit" var="editOrderUrl"/>
	<spring:url value="/orders" var="listOrdersUrl"/>
	<spring:url value="/orders/show_delivery" var="showOrderDeliveryUrl"/>
	
	<h1 id='banner'>Detail Info of '${order.name}' </h1>
	<hr/>
	<label>Name:</label> <span>${order.name}</span> <br/>
	<label>Description:</label> <span>${order.description}</span> <br/>
	<label>Submitted:</label> <span>${order.submitted}</span> <br/>
	<label>OwnerId:</label> <span>${order.owner_id}</span> <br/>
	<label>SF Cruiser Order Id:</label> <span>${order.sf_cruiser_order_id}</span> <br/>
	<label>Delivery Date:</label> <span>${order.delivery_date}</span> <br/>
	
	<a href="${editOrderUrl}/${order.id}">Edit</a> | <a href="${listOrdersUrl}">Back</a> | 
	<a href="${showOrderDeliveryUrl}/${order.id}">Show Delivery Date</a> 
</body>
</html>
