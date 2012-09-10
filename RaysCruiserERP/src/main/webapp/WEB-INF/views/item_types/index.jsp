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
<title>ItemTypes Listings.</title>
</head>
<body>
<spring:url value="/item_types" var="showItemTypeUrl"/>
<spring:url value="/item_types/new" var="addItemTypeUrl"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js" ></script>

<h1 id='banner'>ItemTypes Listings.</h1>
<hr/>
<a href="${addItemTypeUrl}">Create a new Item Type</a>
<br/>
	<hr/>
	
	<form:form method="delete" id='form'>
	<table id='itemTypes'>
		<thead>
			<tr>
				<th>Name</th>
				<th>Description</th>
				<th>Delete</th>
			</tr>
		</thead>


		<c:forEach var="itemType" items="${item_TypesList}">
			<tr>
				<td><a href="${showItemTypeUrl}/${itemType.id}"><c:out value="${itemType.name}"/></a></td>
				<td><c:out value="${itemType.description}"/></td>
				<td><p class="submit"><input type="submit" value="Delete" onclick="javascript: sendform('${itemType.id}'); return false;"/></p></td>
			</tr>
		</c:forEach>		
	</table>
	</form:form>

<script>
function sendform(id) {
	result=confirm('Do you really want to delete this item type?');
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
