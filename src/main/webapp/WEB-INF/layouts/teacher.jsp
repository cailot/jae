<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="hyung.jin.seo.jae.model.StudentDTO"%>
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
    $('#teacherListTable').DataTable({
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

    
});

// Register Teacher
function addTeacher() {
	// Get from form data
	var teacher = {
		state : $("#addState").val(),
		branch : $("#addBranch").val(),
		title : $("#addTitle").val(),
		firstName : $("#addFirstName").val(),
		lastName : $("#addLastName").val(),
		email : $("#addEmail").val(),
		phone : $("#addPhone").val(),
		address : $("#addAddress").val(),
		bank : $("#addBank").val(),
		bsb : $("#addBsb").val(),
		accountNumber : $("#addAccountNumber").val(),
		tfn : $("#addTfn").val(),
		superannuation : $("#addSuperannuation").val(),
		superMember : $("#addSuperMember").val(),
		memo : $("#addMemo").val(),
	}
	console.log(teacher);
	
	// Send AJAX to server
	$.ajax({
		url : '${pageContext.request.contextPath}/teacher/register',
		type : 'POST',
		dataType : 'json',
		data : JSON.stringify(teacher),
		contentType : 'application/json',
		success : function(teacher) {
			// Display the success alert
			$('#success-alert .modal-body').text(
					'Your action has been completed successfully.');
			$('#success-alert').modal('show');
//			// Update display info
//			$("#formId").val(teacher.id);
//			$("#formFirstName").val(teacher.firstName);
//			$("#formLastName").val(teacher.lastName);
//			$("#formEmail").val(teacher.email);
//			$("#formAddress").val(teacher.address);
//			$("#formContact1").val(teacher.contactNo1);
//			$("#formContact2").val(teacher.contactNo2);
//			$("#formMemo").val(teacher.memo);
//			$("#formState").val(teacher.state);
//			$("#formBranch").val(teacher.branch);
//			//$("#formGrade").val(teacher.grade);
//			$("#elearningGrade").val(teacher.grade);
//			// Set date value
//			var date = new Date(teacher.enrolmentDate); // Replace with your date value
//			$("#formEnrolment").datepicker('setDate', date);

		},
		error : function(xhr, status, error) {
			console.log('Error : ' + error);
		}
	});
	$('#registerStudentModal').modal('hide');
	// flush all registered data
	document.getElementById("teacherRegister").reset();
}


// de-activate teacher
function inactivateStudent(id) {
	if(confirm("Are you sure you want to de-activate this teacher?")){
		// send query to controller
		$.ajax({
			url : '${pageContext.request.contextPath}/teacher/inactivate/' + id,
			type : 'PUT',
			success : function(data) {
				// clear existing form
				$('#success-alert .modal-body').text(
						'ID : ' + id + ' is now inactivated');
				$('#success-alert').modal('show');
				//clearStudentForm();
			},
			error : function(xhr, status, error) {
				console.log('Error : ' + error);
			}
		}); 
	}else{
		return;
	}
}








//Search Student with Keyword	
function retreiveStudentInfo(std) {
	// send query to controller
	$.ajax({
		url : '${pageContext.request.contextPath}/teacher/get/' + std,
		type : 'GET',
		success : function(teacher) {
			$('#editStudentModal').modal('show');
			// Update display info
			$("#teacherEditId").val(teacher.id);
			$("#teacherEditFirstName").val(teacher.firstName);
			$("#teacherEditLastName").val(teacher.lastName);
			$("#teacherEditEmail").val(teacher.email);
			$("#teacherEditAddress").val(teacher.address);
			$("#teacherEditContact1").val(teacher.contactNo1);
			$("#teacherEditContact2").val(teacher.contactNo2);
			$("#teacherEditMemo").val(teacher.memo);
			$("#teacherEditState").val(teacher.state);
			$("#teacherEditBranch").val(teacher.branch);
			//$("#formGrade").val(teacher.grade);
			$("#teacherEditGrade").val(teacher.grade);
			// Set date value
			var date = new Date(teacher.enrolmentDate); // Replace with your date value
			$("#teacherEditEnrolment").datepicker('setDate', date);
		},
		error : function(xhr, status, error) {
			console.log('Error : ' + error);
		}
	});
}


function updateStudentInfo(){
	
	// get from formData
	var std = {
		id : $('#teacherEditId').val(),
		firstName : $("#teacherEditFirstName").val(),
		lastName : $("#teacherEditLastName").val(),
		email : $("#teacherEditEmail").val(),
		address : $("#teacherEditAddress").val(),
		contactNo1 : $("#teacherEditContact1").val(),
		contactNo2 : $("#teacherEditContact2").val(),
		memo : $("#teacherEditMemo").val(),
		state : $("#teacherEditState").val(),
		branch : $("#teacherEditBranch").val(),
		//grade : $("#teacherEditGrade").val(),
		grade : $("#elearningGrade").val(),
		enrolmentDate : $("#teacherEditEnrolment").val(),
		elearnings : []
	}
	
	
	// send query to controller
	$.ajax({
		url : '${pageContext.request.contextPath}/teacher/updateOnlyStudent',
		type : 'PUT',
		dataType : 'json',
		data : JSON.stringify(std),
		contentType : 'application/json',
		success : function(value) {
			// Display success alert
			$('#success-alert .modal-body').text(
					'ID : ' + value.id + ' is updated successfully.');
			$('#success-alert').modal('show');
			
		},
		error : function(xhr, status, error) {
			console.log('Error : ' + error);
		}
	});
	
	$('#editStudentModal').modal('hide');
	// flush all registered data
	document.getElementById("teacherEdit").reset();
	
	
	
}













</script>

<!-- List Body -->
<div class="row">
	<div class="modal-body">
		<form id="teacherList" method="get" action="${pageContext.request.contextPath}/teacher/list">
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
						<select class="form-control" id="listActive" name="listActive">
							<option value="All">All Teachers</option>
							<option value="Current">Current Teachers</option>
							<option value="Stopped">Stopped Teachers</option>
						</select>
					</div>
					<div class="col mx-auto">
						<button type="submit" class="btn btn-primary btn-block" onclick="return validate()">Search</button>
					</div>
					<div class="col mx-auto">
						<button type="button" class="btn btn-block btn-success" data-toggle="modal" data-target="#registerStudentModal">New</button>
					</div>
				</div>
			</div>


			<div class="form-group">
				<div class="form-row">
					<div class="col-md-12">
						<div class="table-wrap">
							<table id="teacherListTable" class="table table-striped table-bordered"><thead class="table-primary">
									<tr>
										<th>ID</th>
										<th>First Name</th>
										<th>Last Name</th>
										<th>Gender</th>
										<th>Phone</th>
										<th>Email</th>
										<th>Address</th>
										<th>TFN</th>
										<th>Start Date</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody id="list-teacher-body">
								<c:choose>
									<c:when test="${TeacherList != null}">
									
										<c:forEach items="${TeacherList}" var="teacher">
											<tr>
												<td class="small ellipsis" id="teacherId" name="teacherId"><span><c:out value="${teacher.id}" /></span></td>
												<td class="small ellipsis"><span><c:out value="${teacher.firstName}" /></span></td>
												<td class="small ellipsis"><span><c:out value="${teacher.lastName}" /></span></td>
												<td class="center-cell">
													<c:set var="gender" value="${teacher.title}" />
													<c:choose>
														<c:when test="${gender=='mr'}">
															<i class="fa fa-male text-primary"></i>
														</c:when>
														<c:when test="${gender=='other'}">
															<i class="fa fa-question"></i>
														</c:when>
														<c:otherwise>
															<i class="fa fa-female text-danger"></i>
														</c:otherwise>
													</c:choose>
												</td>
												<td class="small ellipsis"><span><c:out value="${teacher.phone}" /></span></td>
												<td class="small ellipsis"><span><c:out value="${teacher.email}" /></span></td>
												<td class="small ellipsis"><span><c:out value="${teacher.address}" /></span></td>
												<td class="small ellipsis"><span><c:out value="${teacher.tfn}" /></span></td>
												<td class="small ellipsis"><span><c:out value="${teacher.startDate}" /></span></td>
												<td>
													<i class="fa fa-edit text-primary" data-toggle="tooltip" title="Edit" onclick="retreiveTeacherInfo('${teacher.id}')"></i>&nbsp;
													<a href="#passwordTeacherModal" class="password" data-toggle="modal"><i class="fa fa-key text-warning" data-toggle="tooltip" title="Change Password"></i></a>&nbsp;
				 									<i class="fa fa-trash text-danger" data-toggle="tooltip" title="Delete" onclick="inactivateTeacher('${teacher.id}')"></i>
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
<div class="modal fade" id="registerStudentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">Teacher Register</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form id="teacherRegister">
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-4">
								<label for="selectOption">State</label> <select
									class="form-control" id="addState" name="addState">
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
							<div class="col-md-6">
								<label for="selectOption">Branch</label> <select
									class="form-control" id="addBranch" name="addBranch">
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
								<label for="selectOption">Title</label>
								<select class="form-control" id="addTitle" name="addTitle">
									<option value="mr">Mr</option>
									<option value="mrs">Mrs</option>
									<option value="ms">Ms</option>
									<option value="miss">Miss</option>
									<option value="other">Other</option>
								</select>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="name">First Name:</label> <input type="text"
									class="form-control" id="addFirstName" name="addFirstName">
							</div>
							<div class="col-md-6">
								<label for="name">Last Name:</label> <input type="text"
									class="form-control" id="addLastName" name="addLastName">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-5">
								<label for="name">Email</label>
								<input type="text" class="form-control" id="addEmail" name="addEmail">
							</div>
							<div class="col-md-6">
								<label for="name">Phone</label>
								<input type="text" class="form-control" id="addPhone" name="addPhone">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-12">
								<label for="name">Address</label> 
								<input type="text" class="form-control" id="addAddress" name="addAddress">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-4">
								<label for="name">Bank</label> 
								<input type="text" class="form-control" id="addBank" name="addBank">
							</div>
							<div class="col-md-3">
								<label for="name">Bsb</label> 
								<input type="text" class="form-control" id="addBsb" name="addBsb">
							</div>
							<div class="col-md-5">
								<label for="name">Account #</label> 
								<input type="text" class="form-control" id="addAccountNumber" name="addAccountNumber">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-5">
								<label for="name">TFN</label> 
								<input type="text" class="form-control" id="addTfn" name="addTfnr">
							</div>
							<div class="col-md-4">
								<label for="name">Superannuation</label> 
								<input type="text" class="form-control" id="addSuperannuation" name="addSuperannuation">
							</div>
							<div class="col-md-3">
								<label for="name"> Membership #</label> 
								<input type="text" class="form-control" id="addSuperMember" name="addSuperMember">
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="form-row">
							<div class="col-md-12">
								<label for="message">Memo</label>
								<textarea class="form-control" id="addMemo" name="addMemo"></textarea>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="submit" class="btn btn-primary" onclick="addTeacher()">Register</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<!-- Edit Form Dialogue -->
<div class="modal fade" id="editStudentModal" tabindex="-1" role="dialog" aria-labelledby="modalEditLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="modalEditLabel">Student Edit</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form id="teacherEdit">
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-4">
								<label for="selectOption">State</label> <select
									class="form-control" id="teacherEditState" name="teacherEditState">
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
							<div class="col-md-5">
								<label for="selectOption">Branch</label> <select
									class="form-control" id="teacherEditBranch" name="teacherEditBranch">
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
								<label for="datepicker">Enrolment</label> 
								<input type="text" class="form-control datepicker" id="teacherEditEnrolment" name="teacherEditEnrolment" placeholder="dd/mm/yyyy">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-2">
								<label for="name">ID:</label> <input type="text"
									class="form-control" id="teacherEditId" name="teacherEditId">
							</div>
							
							<div class="col-md-4">
								<label for="name">First Name:</label> <input type="text"
									class="form-control" id="teacherEditFirstName" name="teacherEditFirstName">
							</div>
							<div class="col-md-4">
								<label for="name">Last Name:</label> <input type="text"
									class="form-control" id="teacherEditLastName" name="teacherEditLastName">
							</div>
							<div class="col-md-2">
								<label for="selectOption">Grade</label> <select
									class="form-control" id="teacherEditGrade" name="teacherEditGrade">
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
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-5">
								<label for="name">Email</label> <input type="text"
									class="form-control" id="teacherEditEmail" name="teacherEditEmail">
							</div>
							<div class="col-md-7">
								<label for="name">Address</label> <input type="text"
									class="form-control" id="teacherEditAddress" name="teacherEditAddress">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="name">Contact No 1</label> <input type="text"
									class="form-control" id="teacherEditContact1" name="teacherEditContact1">
							</div>
							<div class="col-md-6">
								<label for="name">Contact No 2</label> <input type="text"
									class="form-control" id="teacherEditContact2" name="teacherEditContact2">
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="form-row">
							<label for="message">Memo</label>
							<textarea class="form-control" id="teacherEditMemo" name="teacherEditMemo"></textarea>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="submit" class="btn btn-primary" onclick="updateStudentInfo()">Save</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->










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
























<!-- Success Message Modal -->
<div class="modal fade" id="success-alert" tabindex="-1"
	aria-labelledby="successModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="successModalLabel">Success!</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
