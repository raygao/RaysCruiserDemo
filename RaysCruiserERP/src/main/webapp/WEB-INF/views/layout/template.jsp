<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<html >
<link rel="stylesheet" type="text/css" href="/RaysCruiserERP/resources/application.css" />
<body style="width: 100%; height: 100%; ">
	<table border="0" cellspacing="0" cellpadding="0"
		style="width: 100%;">
		<tr style="height: 150px" >
			<td colspan="2"  background='/RaysCruiserERP/resources/cruiser_schematic.jpg'>
				<tiles:insertAttribute name="header" />
			</td>
		</tr>
		<tr  style="height: 500px">
			<td style="background-color:#CCFF99; height: 500px; max-height: 800px; width: 200px; vertical-align: top;">
				<br/>
				<tiles:insertAttribute name="menu" />
			</td>
			<td style="background-color:#FFFF66; height: 500px; max-height: 800px; vertical-align: top;">
				<br/>
				<tiles:insertAttribute name="body" />
			</td>
		</tr>
		<tr style="height: 100px; background-color:#A3FFA3">
			<td colspan="2"><tiles:insertAttribute name="footer" /></td>
		</tr>
	</table>
</body>
</html>