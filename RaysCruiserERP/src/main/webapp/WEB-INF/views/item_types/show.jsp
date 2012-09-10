<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
 <%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>${item_type.name}</title>
</head>
<body>
	<spring:url value="/item_types/edit" var="editItemTypeUrl"/>
	<spring:url value="/item_types" var="listItemTypesUrl"/>
	
	<h1 id='banner'>Detail Info of '${item_type.name}' </h1>
	<hr/>
	<label>Name:</label> <span>${item_type.name}</span> <br/>
	<label>Description:</label><span>${item_type.description}</span> <br/>
	
	<a href="${editItemTypeUrl}/${item_type.id}">Edit</a> | <a href="${listItemTypesUrl}">Back</a> 
</body>
</html>
