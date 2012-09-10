<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
 <%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>${item.name}</title>
</head>
<body>
	<spring:url value="/item_types" var="showItemTypesUrl"/>
	<spring:url value="/items/edit" var="editItemUrl"/>
	<spring:url value="/items" var="listItemsUrl"/>
	
	<% String image_root = "https://rays-cruiser.s3.amazonaws.com/uploads/item/image"; %>
	
	<h1 id='banner'>Detail Info of '${item.name}' </h1>
	<hr/>
	<label>Name:</label> <span>${item.name}</span> <br/>
	<label>Image:</label> <span> <img src="<%= image_root%>/${item.id}/${item.image_filename}"/></span><br/>
	<label>Description:</label> <span> ${item.description}</span> <br/>
	<label>Price:</label> <span> \$${item.price}</span> <br/>
	<label>Quantity:</label> <span> ${item.quantity}</span> <br/>
	<label>Item Type:</label> <span> <a href="${showItemTypesUrl}/${item_type.id}"><c:out value=" ${item_type.name}"/></a></span> <br/>
	<hr/>
	<a href="${editItemUrl}/${item.id}">Edit</a> | <a href="${listItemsUrl}">Back</a> 
	<br/>
</body>
</html>
