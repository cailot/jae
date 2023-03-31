<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<div class="jae-background-color container-fluid">






<c:set var="currentPage" value="${requestScope['javax.servlet.forward.request_uri']}" />

<div class="menu-style" >
 	<nav class="navbar">
 		<a href="${pageContext.request.contextPath}/dashboard" class="menu-nav ${currentPage.endsWith('/dashboard') ? 'menu-active' : ''}" ><i class="fa fa-pie-chart fa-lg"></i>
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
 		<a href="${pageContext.request.contextPath}/dashboard" class="menu-nav ${currentPage.endsWith('/dashboard') ? 'menu-active' : ''}" ><i class="fa fa-pie-chart fa-lg"></i>
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
 		<a href="${pageContext.request.contextPath}/dashboard" class="menu-nav ${currentPage.endsWith('/dashboard') ? 'menu-active' : ''}" ><i class="fa fa-pie-chart fa-lg"></i>
 		&nbsp;Setting
 		</a>
 	</nav>
</div>



</div>