<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="hyung.jin.seo.jae.dto.StudentDTO"%>
<%@page import="hyung.jin.seo.jae.utils.JaeUtils"%>

<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css"></link>
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.3.6/css/buttons.dataTables.min.css"></link>

<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>


<script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js"></script>

 
  
<script>
$(document).ready(function () {
    $('#courseListTable').DataTable({
    	language: {
    		search: 'Filter:'
    	},
    	dom: 'Blfrtip',	
    	buttons: [
    		 'excelHtml5', 
             {
 	            extend: 'pdfHtml5',
 	            download: 'open',
 	            pageSize: 'A0'
 	        },
 	        'print'
        ],
		//pageLength: 20
    });
    

	$('table .password').on('click', function(){
		var username = $(this).parent().find('#username').val();
		$('#passwordModal #usernamepassword').val(username);
	});
	
	// Set default date format
	$.fn.datepicker.defaults.format = 'dd/mm/yyyy';

	$('.datepicker').datepicker({
		//format: 'dd/mm/yyyy',
		autoclose : true,
		todayHighlight : true
	});

    // When the Grade dropdown changes, send an Ajax request to get the corresponding Type
	// $('#addGrade').change(function() {
	// var grade = $(this).val();
	// 	getCoursesByGrade(grade, '#addCourse');
	// });

	// // When the Grade dropdown changes, send an Ajax request to get the corresponding Type
	// $('#editGrade').change(function() {
	// var grade = $(this).val();
	// 	getCoursesByGrade(grade, '#editCourse');
	// });


});

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//		Register Course
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function addCourse() {
	// Get from form data
	var course = {
		name : $("#addName").val(),
		grade : $("#addGrade").val(),
		description : $("#addDescription").val(),
		price : $("#addPrice").val()
	}
	console.log(course);
	
	// Send AJAX to server
	$.ajax({
		url : '${pageContext.request.contextPath}/class/registerCourse',
		type : 'POST',
		dataType : 'json',
		data : JSON.stringify(course),
		contentType : 'application/json',
		success : function(response) {
			console.log(response);
			// Display the success alert
            $('#success-alert .modal-body').text('New Class is registered successfully.');
            $('#success-alert').modal('show');
			$('#success-alert').on('hidden.bs.modal', function(e) {
				location.reload();
			});
		},
		error : function(xhr, status, error) {
			console.log('Error : ' + error);
		}
	});
	$('#registerCourseModal').modal('hide');
	// flush all registered data
	document.getElementById("courseRegister").reset();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//		Retrieve Course
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function retrieveCourseInfo(clazzId) {
	// send query to controller
	$.ajax({
		url : '${pageContext.request.contextPath}/class/get/' + clazzId,
		type : 'GET',
		success : async function(clazz) {
			//console.log(clazz);
			// firstly populate courses by grade then set the selected option
			await editInitialiseCourseByGrade(clazz.grade, clazz.courseId);
			$("#editId").val(clazz.id);
			$("#editState").val(clazz.state);
			$("#editBranch").val(clazz.branch);
			// Set date value
			var date = new Date(clazz.startDate); // Replace with your date value
			$("#editStartDate").datepicker('setDate', date);
			$("#editGrade").val(clazz.grade);
			$("#editDay").val(clazz.day);
			// $("#editName").val(clazz.name);
			// $("#editFee").val(clazz.fee);
			$("#editActive").val(clazz.active);
			// if clazz.active = true, tick the checkbox 'editActiveCheckbox'
			if(clazz.active == true){
				$("#editActiveCheckbox").prop('checked', true);
			}else{
				$("#editActiveCheckbox").prop('checked', false);
			}
			$('#editClassModal').modal('show');
		},
		error : function(xhr, status, error) {
			console.log('Error : ' + error);
		}
	});
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//		Update Course
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function updateCourseInfo(){
	// get from formData
	var clazz = {
		id : $("#editId").val(),
		state : $("#editState").val(),
		branch : $("#editBranch").val(),
		startDate : $("#editStartDate").val(),
		// name : $("#editName").val(),
		grade : $("#editGrade").val(),
		courseId : $("#editCourse").val(),
		day : $("#editDay").val(),
		active : $("#editActive").val()
		// fee : $("#editFee").val()
	}
	
	console.log(clazz);
	// send query to controller
	$.ajax({
		url : '${pageContext.request.contextPath}/class/update',
		type : 'PUT',
		dataType : 'json',
		data : JSON.stringify(clazz),
		contentType : 'application/json',
		success : function(value) {
			// Display success alert
			$('#success-alert .modal-body').text(
					'ID : ' + value.id + ' is updated successfully.');
			$('#success-alert').modal('show');
			$('#success-alert').on('hidden.bs.modal', function(e) {
				location.reload();
			});
		},
		error : function(xhr, status, error) {
			console.log('Error : ' + error);
		}
	});
	
	$('#editClassModal').modal('hide');
	// flush all registered data
	document.getElementById("classEdit").reset();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//		Clear class register form
/////////////////////////////////////////////////////////////////////////////////////////////////////////	
function clearCourseForm(elementId) {
	document.getElementById(elementId).reset();
}


</script>

<!-- List Body -->
<div class="row">
	<div class="modal-body">
		<form id="classList" method="get" action="${pageContext.request.contextPath}/class/listCourse">
			<div class="form-group">
				<div class="form-row">
					<div class="col-md-2">
						<select class="form-control" id="listState" name="listState">
							<option value="All">All State</option>
							<option value="vic">Victoria</option>
							<option value="nsw">New South Wales</option>
							<option value="qld">Queensland</option>
							<option value="sa">South Australia</option>
							<option value="tas">Tasmania</option>
							<option value="wa">Western Australia</option>
							<option value="nt">Northern Territory</option>
							<option value="act">ACT</option>
						</select>
					</div>
					<div class="col-md-2">
						<select class="form-control" id="listBranch" name="listBranch">
							<option value="All">All Branch</option>
							<option value="braybrook">Braybrook</option>
							<option value="epping">Epping</option>
							<option value="balwyn">Balwyn</option>
							<option value="bayswater">Bayswater</option>
							<option value="boxhill">Box Hill</option>
							<option value="carolinesprings">Caroline Springs</option>
							<option value="chadstone">Chadstone</option>
							<option value="craigieburn">Craigieburn</option>
							<option value="cranbourne">Cranbourne</option>
							<option value="glenwaverley">Glen Waverley</option>
							<option value="mitcha">Mitcham</option>
							<option value="narrewarren">Narre Warren</option>
							<option value="ormond">Ormond</option>
							<option value="pointcook">Point Cook</option>
							<option value="preston">Preston</option>
							<option value="springvale">Springvale</option>
							<option value="stalbans">St Albans</option>
							<option value="werribee">Werribee</option>
							<option value="mernda">Mernda</option>
							<option value="melton">Melton</option>
							<option value="glenroy">Glenroy</option>
							<option value="packenham">Packenham</option>
						</select>
					</div>
					<div class="col-md-2">
						<select class="form-control" id="listGrade" name="listGrade">
							<option value="All">All</option>
							<option value="p2">P2</option>
							<option value="p3">P3</option>
							<option value="p4">P4</option>
							<option value="p5">P5</option>
							<option value="p6">P6</option>
							<option value="s7">S7</option>
							<option value="s8">S8</option>
							<option value="s9">S9</option>
							<option value="s10">S10</option>
							<option value="s10e">S10E</option>
							<option value="tt6">TT6</option>
							<option value="tt8">TT8</option>
							<option value="tt8e">TT8E</option>
							<option value="srw4">SRW4</option>
							<option value="srw5">SRW5</option>
							<option value="srw6">SRW6</option>
							<option value="srw8">SRW8</option>
							<option value="jmss">JMSS</option>
							<option value="vce">VCE</option>
						</select>
					</div>
					<div class="col-md-2">
						<select class="form-control" id="listYear" name="listYear">
							<option value="All">All</option>
							<option value="2023">2023</option>
							<option value="2022">2022</option>
							<option value="2021">2021</option>
							<option value="2020">2020</option>
						</select>
					</div>
					<div class="col mx-auto">
						<button type="submit" class="btn btn-primary btn-block"> <i class="fa fa-search"></i>&nbsp;Search</button>
					</div>
					<div class="col mx-auto">
						<button type="button" class="btn btn-block btn-success" data-toggle="modal" data-target="#registerCourseModal"><i class="fa fa-plus"></i>&nbsp;New</button>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="form-row">
					<div class="col-md-12">
						<div class="table-wrap">
							<table id="courseListTable" class="table table-striped table-bordered"><thead class="table-primary">
									<tr>
										<th>Name</th>
										<th>Description</th>
										<th>Grade</th>
										<th>Price</th>
										<th data-orderable="false">Action</th>
									</tr>
								</thead>
								<tbody id="list-class-body">
								<c:choose>
									<c:when test="${ClassList != null}">
										<c:forEach items="${ClassList}" var="clazz">
											<tr>
												<td class="small ellipsis"><span><c:out value="${clazz.state}" /></span></td>
												<td class="small ellipsis"><span><c:out value="${clazz.branch}" /></span></td>
												<td class="small ellipsis"><span><c:out value="${fn:toUpperCase(clazz.grade)}" /></span></td>
												<td class="small ellipsis"><span><c:out value="${clazz.description}" /></span></td>
												<td>
													<i class="fa fa-edit text-primary fa-lg" data-toggle="tooltip" title="Edit" onclick="retrieveClassInfo('${clazz.id}')"></i>&nbsp;
												</td>
											</tr>
										</c:forEach>
									
									</c:when>
								</c:choose>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

		</form>
	</div>
</div>

<!-- Add Form Dialogue -->
<div class="modal fade" id="registerCourseModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<section class="fieldset rounded border-primary">
					<header class="text-primary font-weight-bold">Course Registration</header>
					<form id="courseRegister">
						<div class="form-group mt-3">
							<div class="form-row">
								<div class="col-md-3">
									<label for="addGrade" class="label-form">Grade</label>
									<select class="form-control" id="addGrade" name="addGrade">
										<option value="p2">P2</option>
										<option value="p3">P3</option>
										<option value="p4">P4</option>
										<option value="p5">P5</option>
										<option value="p6">P6</option>
										<option value="s7">S7</option>
										<option value="s8">S8</option>
										<option value="s9">S9</option>
										<option value="s10">S10</option>
										<option value="s10e">S10E</option>
										<option value="tt6">TT6</option>
										<option value="tt8">TT8</option>
										<option value="tt8e">TT8E</option>
										<option value="srw4">SRW4</option>
										<option value="srw5">SRW5</option>
										<option value="srw6">SRW6</option>
										<option value="srw8">SRW8</option>
										<option value="jmss">JMSS</option>
										<option value="vce">VCE</option>
									</select>
								</div>
								<div class="col-md-9">
									<label for="addName" class="label-form">Name</label> 
									<input type="text" class="form-control" id="addName" name="addName" placeholder="Name" title="Please enter Course name">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="form-row">
								<div class="col-md-3">
									<label for="addPrice" class="label-form">Price</label> 
									<input type="text" class="form-control" id="addPrice" name="addPrice" placeholder="Price" title="Please enter Course price">
								</div>
								<div class="col-md-9">
									<label for="addDescription" class="label-form">Description</label> 
									<input type="text" class="form-control" id="addDescription" name="addDescription" placeholder="Description" title="Please enter Course description">
								</div>
							</div>
						</div>
					</form>
					<div class="d-flex justify-content-end">
						<button type="submit" class="btn btn-primary" onclick="addCourse()">Create</button>&nbsp;&nbsp;
						<button type="button" class="btn btn-default btn-secondary" onclick="clearCourseForm('courseRegister')" data-dismiss="modal">Close</button>	
					</div>	
				</section>
			</div>
		</div>
	</div>
</div>

<!-- Edit Form Dialogue -->
<div class="modal fade" id="editClassModal" tabindex="-1" role="dialog" aria-labelledby="modalEditLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<section class="fieldset rounded border-primary">
					<header class="text-primary font-weight-bold">Class Edit</header>
			
				<form id="classEdit">
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-4">
								<label for="editState" class="label-form">State</label> <select class="form-control" id="editState" name="editState">
									<option value="vic">Victoria</option>
									<!-- <option value="nsw">New South Wales</option>
									<option value="qld">Queensland</option>
									<option value="sa">South Australia</option>
									<option value="tas">Tasmania</option>
									<option value="wa">Western Australia</option>
									<option value="nt">Northern Territory</option>
									<option value="act">ACT</option> -->
								</select>
							</div>
							<div class="col-md-5">
								<label for="editBranch" class="label-form">Branch</label> <select class="form-control" id="editBranch" name="editBranch">
									<option value="braybrook">Braybrook</option>
									<option value="epping">Epping</option>
									<option value="balwyn">Balwyn</option>
									<option value="bayswater">Bayswater</option>
									<option value="boxhill">Box Hill</option>
									<option value="carolinesprings">Caroline Springs</option>
									<option value="chadstone">Chadstone</option>
									<option value="craigieburn">Craigieburn</option>
									<option value="cranbourne">Cranbourne</option>
									<option value="glenwaverley">Glen Waverley</option>
									<option value="mitcha">Mitcham</option>
									<option value="narrewarren">Narre Warren</option>
									<option value="ormond">Ormond</option>
									<option value="pointcook">Point Cook</option>
									<option value="preston">Preston</option>
									<option value="springvale">Springvale</option>
									<option value="stalbans">St Albans</option>
									<option value="werribee">Werribee</option>
									<option value="mernda">Mernda</option>
									<option value="melton">Melton</option>
									<option value="glenroy">Glenroy</option>
									<option value="packenham">Packenham</option>
								</select>
							</div>
							<div class="col-md-3">
								<label for="editStartDate" class="label-form">Start Date</label> 
								<input type="text" class="form-control datepicker" id="editStartDate" name="editStartDate" placeholder="dd/mm/yyyy">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-3">
								<label for="editGrade" class="label-form">Grade</label> <select class="form-control" id="editGrade" name="editGrade">
									<option value="p2">P2</option>
									<option value="p3">P3</option>
									<option value="p4">P4</option>
									<option value="p5">P5</option>
									<option value="p6">P6</option>
									<option value="s7">S7</option>
									<option value="s8">S8</option>
									<option value="s9">S9</option>
									<option value="s10">S10</option>
									<option value="s10e">S10E</option>
									<option value="tt6">TT6</option>
									<option value="tt8">TT8</option>
									<option value="tt8e">TT8E</option>
									<option value="srw4">SRW4</option>
									<option value="srw5">SRW5</option>
									<option value="srw6">SRW6</option>
									<option value="srw8">SRW8</option>
									<option value="jmss">JMSS</option>
									<option value="vce">VCE</option>
								</select>
							</div>
							<div class="col-md-5">
								<label for="editCourse" class="label-form">Course</label> 
								<select class="form-control" id="editCourse" name="editCourse">
								</select>
							</div>
							<div class="col-md-4">
								<label for="editDay" class="label-form">Day</label>
								<select class="form-control" id="editDay" name="editDay">
									<option value="All">All</option>
									<option value="Monday">Monday</option>
									<option value="Tuesday">Tuesday</option>
									<option value="Wednesday">Wednesday</option>
									<option value="Thursday">Thursday</option>
									<option value="Friday">Friday</option>
									<option value="Saturday">Saturday</option>
									<option value="Sunday">Sunday</option>
								</select>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-8">
								<input type="text" class="form-control" id="editName" name="editName" placeholder="Name" title="Please enter Class name">
							</div>
							<div class="input-group col-md-4">
								<div class="input-group-prepend">
								  <div class="input-group-text">
									<input type="checkbox" id="editActiveCheckbox" name="editActiveCheckbox" onchange="updateEditActiveValue(this)">
								  </div>
								</div>
								<input type="hidden" id="editActive" name="editActive" value="false">
								<input type="text" id="editActiveLabel" class="form-control" placeholder="Activate">
							</div>
						</div>
					</div>
					<input type="hidden" id="editId" name="editId">
				</form>
				<div class="d-flex justify-content-end">
					<button type="submit" class="btn btn-primary" onclick="updateClassInfo()">Save</button>&nbsp;&nbsp;
					<button type="button" class="btn btn-default btn-secondary" data-dismiss="modal">Close</button>	
				</div>	
				</section>
			</div>
		</div>
	</div>
</div>










<!--  Password Modal HTML -->
<div id="passwordStudentModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<form method="POST" action="${pageContext.request.contextPath}/changePassword">
				<div class="modal-header">
					<h4 class="modal-title">Change Password</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>Password</label> <input type="password" class="form-control" required="required" name="passwordpassword" id="passwordpassword" />
					</div>
					<div class="form-group">
						<label>Confirm Password</label> <input type="password" class="form-control" required="required" name="confirmPasswordpassword" id="confirmPasswordpassword"/>
					</div>
				</div>
				<div class="modal-footer">
					<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
					<button type="submit" class="btn btn-info" onclick="return passwordChange();">Change Password</button> 
					<input type="hidden" name="usernamepassword" id="usernamepassword" />
				</div>
			</form>
		</div>
	</div>
</div>


<!-- Success Alert -->
<div id="success-alert" class="modal fade">
	<div class="modal-dialog">
		<div class="alert alert-block alert-success alert-dialog-display">
			<i class="fa fa-check-circle fa-2x"></i>&nbsp;&nbsp;<div class="modal-body"></div>
			<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
		</div>
	</div>
</div>