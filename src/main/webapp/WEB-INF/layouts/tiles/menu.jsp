<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%--
<div class="jae-background-color w-100">
<c:set var="currentPage" value="${requestScope['javax.servlet.forward.request_uri']}" />
<div class="menu-style" >
 	<nav class="navbar">
 		<a href="${pageContext.request.contextPath}/test" class="menu-nav ${currentPage.endsWith('/test') ? 'menu-active' : ''}" ><i class="fa fa-pie-chart fa-lg"></i>
 		&nbsp;Student
 		</a>
 	</nav>
</div>
<div class="menu-style" >
 	<nav class="navbar">
 		<a href="${pageContext.request.contextPath}/dashboard" class="menu-nav ${currentPage.endsWith('/dashboard') ? 'menu-active' : ''}" ><i class="fa fa-pie-chart fa-lg"></i>
 		&nbsp;Course
 		</a>
 	</nav>
</div>
<div class="menu-style" >
 	<nav class="navbar">
 		<a href="${pageContext.request.contextPath}/dashboard" class="menu-nav ${currentPage.endsWith('/dashboard') ? 'menu-active' : ''}" ><i class="fa fa-pie-chart fa-lg"></i>
 		&nbsp;Invoice
 		</a>
 	</nav>
</div>
<div class="menu-style" >
 	<nav class="navbar">
 		<a href="${pageContext.request.contextPath}/teacher" class="menu-nav ${currentPage.endsWith('/teacher') ? 'menu-active' : ''}" ><i class="fa fa-pie-chart fa-lg"></i>
 		&nbsp;Teacher
 		</a>
 	</nav>
</div>
<div class="menu-style" >
 	<nav class="navbar">
 		<a href="${pageContext.request.contextPath}/dashboard" class="menu-nav ${currentPage.endsWith('/dashboard') ? 'menu-active' : ''}" ><i class="fa fa-pie-chart fa-lg"></i>
 		&nbsp;User
 		</a>
 	</nav>
</div>
<div class="menu-style" >
 	<nav class="navbar">
 		<a href="${pageContext.request.contextPath}/list" class="menu-nav ${currentPage.endsWith('/list') ? 'menu-active' : ''}" ><i class="fa fa-pie-chart fa-lg"></i>
 		&nbsp;List
 		</a>
 	</nav>
</div>
<div class="menu-style" >
 	<nav class="navbar">
 		<a href="${pageContext.request.contextPath}/setting" class="menu-nav ${currentPage.endsWith('/setting') ? 'menu-active' : ''}" ><i class="fa fa-pie-chart fa-lg"></i>
 		&nbsp;Setting
 		</a>
 	</nav>
</div>
</div>
--%>

<style>
.jae-header{
	padding : 0;
	background-color: #263343;
}
.navbar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 8px 12px;
}
.navbar a {
	text-decoraton: none;
	color: white;
}
.navbar_logo{
	font-size: 24px;
	color: white;
}
.navbar_menu{
	display: flex;
	list-style: none;
	padding-left: 0;
}
.navbar_menu li {
	padding: 8px 12px;
}
.navbar_menu li:hover{
	background-color: yellow;
	border-radius: 4px;
}

.navbar_icon{
	color: white;
	font-size: 24px;
	list-style: none;
	display: flex;
	padding-left: 0;
}
.navbar_icon li {
	padding: 8px 12px;
}

@media screen and (max-width: 768px){
	.navbar{
		flex-direction: column;
		align-items: flex-start;
		padding: 8px 12px;
	}
	.navbar_menu{
		flex-direction: column;
		align-items: center;
		width: 100%;
	}
	.navbar_icon{
		justify-content: center;
		width: 100%;
		
	}
}
</style>
<div class="container-fluid jae-header">
<nav class="navbar">
	<div class="navbar_logo">
		<img src="${pageContext.request.contextPath}/image/logo.png" style="filter: brightness(0) invert(1);width:45px;" >
		James An Colleges
	</div>
	<ul class="navbar_menu">
		<li><a href="${pageContext.request.contextPath}/test">Student</a></li>
		<li><a href="${pageContext.request.contextPath}/test">Course</a></li>
		<li><a href="${pageContext.request.contextPath}/teacher">Teacher</a></li>
		<li><a href="${pageContext.request.contextPath}/list">List</a></li>
		<li><a href="${pageContext.request.contextPath}/test">Setting</a></li>
	</ul>
	<ul class="navbar_icon">
		<li><i class="fas fa-smile"></i></li>	
	</ul>
</nav>
</div>
 