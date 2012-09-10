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
<title>${item_type.name}</title>
</head>
<body>
<spring:url value="/item_types/update" var="updateItemTypeUrl"/>
<spring:url value="/item_types/edit" var="editItemTypeUrl"/>

<spring:url value="/item_types" var="createItemTypesUrl"/>
<form:form method="POST" id='form' modelAttribute="item_type" action="${updateItemTypeUrl}">
<h1 id='banner'>Edit '${item_type.name}' </h1>
	<hr/>
	<form:hidden path="id" id="id" value="${item_type.id}"/>

	<label>Name:</label> <span> <form:input path="name" id="name" /></span> <br/>
	<label>Description:</label> <span> <form:textarea path="description" id="description"/></span> <br/>
	<button type="submit">Save</button>
	<button type="reset" onclick="document.location.href=${editItemTypeUrl}/${item_type.id}">reset</button>
</form:form>
</body>
</html>
