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
<title>Create a new Item</title>
</head>
<body>

<spring:url value="/items" var="createItemUrl"/>
<spring:url value="/items/new" var="addItemUrl"/>
<form:form method="POST" id='form' modelAttribute="item" action="${createItemUrl}">

<h1>Add a new item </h1>
	<hr/>
	<label>Name:</label> <span> <form:input path="name" id="name"/></span> <br/>
	<label>Image:</label> <span> file upload</span><br/>
	<label>Description:</label> <span> <form:input path="description" id="description"/></span> <br/>
	<label>Price:</label> <span> \$<form:input path="price" id="price"/></span>  <br/>
	<label>Quantity:</label> <span> <form:input path="quantity" id="quantity"/></span> <br/>
	<label>Item Type:</label> <span> type</span> <br/>
	<button type="submit">Save</button>
	<button type="reset" onclick="document.location.href=${addItemUrl}">reset</button>
</form:form>
</body>
</html>