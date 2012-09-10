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
<title>Item Listings</title>
</head>
<body>
<spring:url value="/items" var="showItemsUrl"/>
<spring:url value="/items/new" var="addItemsUrl"/>
<% String image_root = "https://rays-cruiser.s3.amazonaws.com/uploads/item/image"; %>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js" ></script>

<h1 id='banner'>Item Listings</h1>
<hr/>
<a href="${addItemsUrl}">Create a new Item</a>
<br/>
<hr/>
	
<form:form method="delete" id='form'>
	<table id='itemTypes'>
		<thead>
			<tr>
				<th>Name</th>
				<th>Image</th>
				<th>Price</th>
				<th>Quantity</th>
				<th>Delete</th>
			</tr>
		</thead>

		<c:forEach var="item" items="${itemsList}">
			<tr>
				<td><a href="${showItemsUrl}/${item.id}"><c:out value="${item.name}"/></a></td>
				<td><img src="<%= image_root%>/${item.id}/thumb_${item.image_filename}"/></td>
				<td>$ <c:out value="${item.price}"/></td>
				<td><c:out value="${item.quantity}"/></td>
				<td><p class="submit"><input type="submit" value="Delete" onclick="javascript: sendform('${item.id}'); return false;"/></p></td>
			</tr>
		</c:forEach>		
	</table>	
</form:form>

<script>
function sendform(id) {
	result=confirm('Do you really want to delete this item?');
	if (result == true) {
		//send form
		var myform = $('#form');
		form_target = myform.attr('action') + '/' + id;
		myform.attr('action', form_target);
		//alert(form_target);
		myform.submit();
	} else {
		//do nothing
		return false;
	}
}
</script>
</body>
</html>
