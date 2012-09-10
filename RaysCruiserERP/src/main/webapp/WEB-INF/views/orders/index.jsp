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
<title>Orders Listings.</title>
</head>
<body>
<spring:url value="/orders" var="showOrderUrl"/>
<spring:url value="/orders/new" var="addOrderUrl"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js" ></script>

	<spring:url value="/orders/set_delivery" var="setOrderDeliveryUrl"/>

<h1 id='banner'>Orders Listings.</h1>
<hr/>
	<form:form method="delete" id='form'>
	<table id='Orders'>
		<thead>
			<tr>
				<th>Name</th>
				<th>Description</th>
				<th>Delivery Date</th>
				<th>Set Date</th>
			</tr>
		</thead>

		<c:forEach var="order" items="${ordersList}">
			<tr>
				<td><a href="${showOrderUrl}/${order.id}"><c:out value="${order.name}"/></a></td>
				<td><c:out value="${order.description}"/></td>
				<td><c:out value="${order.delivery_date}"/></td>
				<td>
					<a href="${setOrderDeliveryUrl}/${order.id}">Set Delivery Date</a>
				</td>
			</tr>
		</c:forEach>		
	</table>
	</form:form>



</body>
</html>
