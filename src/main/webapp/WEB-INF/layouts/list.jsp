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
    $('#studentListTable').DataTable({
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
    
    
    
    $('table .edit').on('click', function(){
		var stdId = $(this).parent().find('#studentId').val();
		console.log(stdId);
		document.getElementById("studentEdit").reset();
		$.ajax({
			type: 'GET',
			url: '${pageContext.request.contextPath}/student/get',
			data : {
				id : stdId
			},
			success: function(std){
				$('#editStudentModal #studentEditState').val(std.state);
				$('#editStudentModal #studentEditFirstName').val(std.firstname);
				$('#editStudentModal #studentEditFirstName').val(std.lastname);
				
				
				
				/* 
				$("#formId").val(value['id']);
				$("#formFirstName").val(value['firstName']);
				$("#formLastName").val(value['lastName']);
				$("#formEmail").val(value['email']);
				$("#formAddress").val(value['address']);
				$("#formContact1").val(value['contactNo1']);
				$("#formContact2").val(value['contactNo2']);
				$("#formMemo").val(value['memo']);
				$("#formState").val(value['state']);
				$("#formBranch").val(value['branch']);
				//$("#formGrade").val(value['grade']);
				$("#elearningGrade").val(value['grade']);
				// display same selected grade to Course Register section
				$("#registerGrade").val(value['grade']);
				 */
				// Set date value
/* 				var date = new Date(value['enrolmentDate']); // Replace with your date value
				$("#studentEditEnrolment").datepicker('setDate', date);
 */
				
				
				
				
				
			}	
		});
	});
    

	$('table .password').on('click', function(){
		var username = $(this).parent().find('#username').val();
		$('#passwordModal #usernamepassword').val(username);
	});
	
	$('table .delete').on('click', function(){
		var username = $(this).parent().find('#username').val();
		$('#deleteUserModal #usernameDelete').val(username);
	});

    
});

// Register Student
function addStudent() {
	// Get from form data
	var std = {
		firstName : $("#addFirstName").val(),
		lastName : $("#addLastName").val(),
		email : $("#addEmail").val(),
		address : $("#addAddress").val(),
		contactNo1 : $("#addContact1").val(),
		contactNo2 : $("#addContact2").val(),
		memo : $("#addMemo").val(),
		state : $("#addState").val(),
		branch : $("#addBranch").val(),
		grade : $("#addGrade").val(),
		enrolmentDate : $("#addEnrolment").val()
	}
	// Send AJAX to server
	$.ajax({
		url : 'student/register',
		type : 'POST',
		dataType : 'json',
		data : JSON.stringify(std),
		contentType : 'application/json',
		success : function(student) {
			// Display the success alert
			$('#success-alert .modal-body').text(
					'Your action has been completed successfully.');
			$('#success-alert').modal('show');
			// Update display info
			$("#formId").val(student.id);
			$("#formFirstName").val(student.firstName);
			$("#formLastName").val(student.lastName);
			$("#formEmail").val(student.email);
			$("#formAddress").val(student.address);
			$("#formContact1").val(student.contactNo1);
			$("#formContact2").val(student.contactNo2);
			$("#formMemo").val(student.memo);
			$("#formState").val(student.state);
			$("#formBranch").val(student.branch);
			//$("#formGrade").val(student.grade);
			$("#elearningGrade").val(student.grade);
			// Set date value
			var date = new Date(student.enrolmentDate); // Replace with your date value
			$("#formEnrolment").datepicker('setDate', date);

		},
		error : function(xhr, status, error) {
			console.log('Error : ' + error);
		}
	});
	$('#registerModal').modal('hide');
	// ready to associate
	listElearnings(std.grade);
	// flush all registered data
	document.getElementById("studentRegister").reset();
}
</script>



<!-- List Body -->
<div class="row">
	<div class="modal-body">
		<form id="studentList" method="get" action="${pageContext.request.contextPath}/student/list">
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
					<div class="col-md-1">
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
							<option value="jmss">JMSS</option>
							<option value="vce">VCE</option>
						</select>
					</div>
					<div class="col-md-2">
						<select class="form-control" id="listYear" name="listYear">
							<option value="All">All</option>
							<c:set var="academicYear" scope="session" value='<%= JaeUtils.academicYear() %>' />
							<option value="${academicYear}">${academicYear}</option>
							<option value="${academicYear-1}">${academicYear-1}</option>
							<option value="${academicYear-2}">${academicYear-2}</option>
						</select>
					</div>
					<div class="col-md-2">
						<select class="form-control" id="listActive" name="listActive">
							<option value="All">All Students</option>
							<option value="Current">Current Students</option>
							<option value="Stopped">Stopped Students</option>
						</select>
					</div>
					<div class="col mx-auto">
						<button type="submit" class="btn btn-primary btn-block" onclick="return validate()">Search</button>
					</div>
					<div class="col mx-auto">
						<button type="button" class="btn btn-block btn-success" data-toggle="modal" data-target="#registerModal">New</button>
					</div>
				</div>
			</div>


			<div class="form-group">
				<div class="form-row">
					<div class="col-md-12">
						<div class="table-wrap">
							<table id="studentListTable" class="table table-striped table-bordered"><thead class="table-primary">
									<tr>
										<th>ID</th>
										<th>First Name</th>
										<th>Last Name</th>
										<th>Grade</th>
										<th>Start Date</th>
										<th>Week</th>
										<th>End Date</th>
										<th>Email</th>
										<th>Contact 1</th>
										<th>Contact 2</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody id="list-student-body">
								<c:choose>
									<c:when test="${StudentList != null}">
									
										<c:forEach items="${StudentList}" var="student">
											<tr>
												<td class="small ellipsis"><span><c:out value="${student.id}" /></span></td>
												<td class="small ellipsis"><span><c:out value="${student.firstName}" /></span></td>
												<td class="small ellipsis"><span><c:out value="${student.lastName}" /></span></td>
												<td class="small ellipsis"><span><c:out value="${fn:toUpperCase(student.grade)}" /></span></td>
												
												<c:set var="regDate" value="${student.registerDate}" />
												<c:set var="starts" value="${fn:split(regDate, '|')}" />
							
												<td class="small ellipsis"><span><c:out value="${starts[0]}" /></span></td>
												<td class="small ellipsis"><span><c:out value="${starts[1]}" /></span></td>
												<td class="small ellipsis"><span><c:out value="${student.endDate}" /></span></td>
												<td class="small ellipsis"><span><c:out value="${student.email}" /></span></td>
												<td class="small ellipsis"><span><c:out value="${student.contactNo1}" /></span></td>
												<td class="small ellipsis"><span><c:out value="${student.contactNo2}" /></span></td>
												<td>
													<a href="#editStudentModal" class="edit" data-toggle="modal"><i class="fa fa-edit text-primary" data-toggle="tooltip" title="Edit"></i></a>&nbsp;
													<a href="#passwordStudentModal" class="password" data-toggle="modal"><i class="fa fa-key text-warning" data-toggle="tooltip" title="Change Password"></i></a>&nbsp;
													<a href="#deleteStudentModal" class="delete" data-toggle="modal"><i class="fa fa-trash text-danger" data-toggle="tooltip" title="Delete"></i></a>
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












<!-- Register Form Dialogue -->
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">Student Enrolment</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form id="studentRegister">
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
							<div class="col-md-5">
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
							<div class="col-md-3">
								<label for="datepicker">Enrolment</label> 
								<input type="text" class="form-control datepicker" id="addEnrolment" name="addEnrolment" placeholder="dd/mm/yyyy">
							</div>
							<script>
								var today = new Date();
								var day = today.getDate();
								var month = today.getMonth() + 1; // Note: January is 0
								var year = today.getFullYear();
								var formattedDate = (day < 10 ? '0' : '') + day + '/' + (month < 10 ? '0' : '') + month + '/' + year;
								document.getElementById('addEnrolment').value = formattedDate;
							</script>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-5">
								<label for="name">First Name:</label> <input type="text"
									class="form-control" id="addFirstName" name="addFirstName">
							</div>
							<div class="col-md-5">
								<label for="name">Last Name:</label> <input type="text"
									class="form-control" id="addLastName" name="addLastName">
							</div>
							<div class="col-md-2">
								<label for="selectOption">Grade</label> <select
									class="form-control" id="addGrade" name="addGrade">
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
									class="form-control" id="addEmail" name="addEmail">
							</div>
							<div class="col-md-7">
								<label for="name">Address</label> <input type="text"
									class="form-control" id="addAddress" name="addAddress">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="name">Contact No 1</label> <input type="text"
									class="form-control" id="addContact1" name="addContact1">
							</div>
							<div class="col-md-6">
								<label for="name">Contact No 2</label> <input type="text"
									class="form-control" id="addContact2" name="addContact2">
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="form-row">
							<label for="message">Memo</label>
							<textarea class="form-control" id="addMemo" name="addMemo"></textarea>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="submit" class="btn btn-primary" onclick="addStudent()">Register</button>
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
				<form id="studentEdit">
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-4">
								<label for="selectOption">State</label> <select
									class="form-control" id="studentEditState" name="studentEditState">
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
									class="form-control" id="studentEditBranch" name="studentEditBranch">
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
								<input type="text" class="form-control datepicker" id="studentEditEnrolment" name="studentEditEnrolment" placeholder="dd/mm/yyyy">
							</div>
							<script>
								var today = new Date();
								var day = today.getDate();
								var month = today.getMonth() + 1; // Note: January is 0
								var year = today.getFullYear();
								var formattedDate = (day < 10 ? '0' : '') + day + '/' + (month < 10 ? '0' : '') + month + '/' + year;
								document.getElementById('studentEditEnrolment').value = formattedDate;
							</script>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-5">
								<label for="name">First Name:</label> <input type="text"
									class="form-control" id="studentEditFirstName" name="studentEditFirstName">
							</div>
							<div class="col-md-5">
								<label for="name">Last Name:</label> <input type="text"
									class="form-control" id="studentEditLastName" name="studentEditLastName">
							</div>
							<div class="col-md-2">
								<label for="selectOption">Grade</label> <select
									class="form-control" id="studentEditGrade" name="studentEditGrade">
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
									class="form-control" id="studentEditEmail" name="studentEditEmail">
							</div>
							<div class="col-md-7">
								<label for="name">Address</label> <input type="text"
									class="form-control" id="studentEditAddress" name="studentEditAddress">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="name">Contact No 1</label> <input type="text"
									class="form-control" id="studentEditContact1" name="studentEditContact1">
							</div>
							<div class="col-md-6">
								<label for="name">Contact No 2</label> <input type="text"
									class="form-control" id="studentEditContact2" name="studentEditContact2">
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="form-row">
							<label for="message">Memo</label>
							<textarea class="form-control" id="studentEditMemo" name="studentEditMemo"></textarea>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="submit" class="btn btn-primary" onclick="editStudent()">Save</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->









<!--  Edit Modal HTML -->
<div id="editStudentModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<form method="POST" action="${pageContext.request.contextPath}/editUser">
				<div class="modal-header">
					<h4 class="modal-title">Edit User</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>Username</label> <input type="text" class="form-control" required="required" name="usernameEdit" id="usernameEdit" readonly/>
					</div>
					<div class="form-group">
						<label>First Name</label> <input type="text" class="form-control" required="required" name="firstnameEdit" id="firstnameEdit"/>
					</div>
					<div class="form-group">
						<label>Last Name</label> <input type="text" class="form-control" required="required" name="lastnameEdit"  id="lastnameEdit"/>
					</div>
					<div class="form-group">
						<label>Organisation</label>
							<input type="text" class="form-control" required="required" name="roleEdit" id="roleEdit" />
					</div>
				</div>
				<div class="modal-footer">
					<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel"><input type="submit" class="btn btn-info" value="Save">
				</div>
			</form>
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

<!--  Delete Modal HTML -->
<div id="deleteStudentModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<form method="POST" action="${pageContext.request.contextPath}/deleteUser">
				<div class="modal-header">
					<h4 class="modal-title">Delete User</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<p>Are you sure you want to delete this user ?</p>
						<p class="text-warning"><small>This action cannot be undone.</small></p>	
					</div>
				</div>
				<div class="modal-footer">
					<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel"><input type="submit" class="btn btn-danger" value="Delete">
					<input type="hidden" name="usernameDelete" id="usernameDelete"/> 
				</div>
			</form>
		</div>
	</div>
</div>


