<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<html>
<head>
<title><tiles:getAsString name="title" /></title>

</head>
<body>
	<div class="container-fluid d-flex h-100 flex-column">
		<div class="row">
			<tiles:insertAttribute name="header" />
		</div>
		<div class="row">
			<tiles:insertAttribute name="menu" />
		</div>
		<div class="row justify-content-center align-items-center">		
			<tiles:insertAttribute name="body" />
		</div>
		<footer class="mt-auto">
			<div class="row dhhs-color" style="padding: 15px 20px;">
				This web site is managed and authorised by the Department of Health & Human Services, State Government of Victoria, Australia&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &copy;&nbsp;Copyright State of Victoria 2017-2022
			</div>
		</footer>
	</div>
</body>
</html>