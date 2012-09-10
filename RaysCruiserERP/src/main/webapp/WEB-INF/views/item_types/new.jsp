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
<title>Create a new Item Type</title>
</head>
<body>

<spring:url value="/item_types" var="createItemTypeUrl"/>
<spring:url value="/item_types/new" var="addItemTypeUrl"/>
<form:form method="POST" id='form' modelAttribute="item_type" action="${createItemTypeUrl}">

<h1>Add a new item Type</h1>
	<hr/>
	<label>Name:</label> <span> <form:input path="name" id="name"/></span> <br/>
	<label>Description:</label> <span> <form:input path="description" id="description"/></span> <br/>
	<button type="submit">Save</button>
	<button type="reset" onclick="document.location.href=${addItemTypeUrl}">reset</button>
</form:form>
</body>
</html>