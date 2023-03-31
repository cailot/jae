<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="hyung.jin.seo.jae.model.StudentDTO"%>

<script>
	$(document).ready(function() {

		// Set default date format
		$.fn.datepicker.defaults.format = 'dd/mm/yyyy';

		$('.datepicker').datepicker({
			//format: 'dd/mm/yyyy',
			autoclose : true,
			todayHighlight : true
		});
	});

	function submitForm() {
		// Get from form data
		var formData = $('#studentRegister').serialize();
		console.log(formData);
		// Send AJAX to server
		$.ajax({
			url : 'register',
			type : 'POST',
			data : formData,
			success : function(student) {
				console.log('Success : ' + student);
				// Display the success alert
				$('#success-alert').modal('show');
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
				$("#formGrade").val(student.grade);
				// Set date value
				var date = new Date(student.enrolmentDate); // Replace with your date value
				$("#formEnrolment").datepicker('setDate', date);

			},
			error : function(xhr, status, error) {
				console.log('Error : ' + error);
			}
		});
		$('#registerModal').modal('hide');
	}
	
	function clearForm(){
		document.getElementById("studentInfo").reset();
	}
</script>
<!-- Success Modal -->
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
			<div class="modal-body">Your action has been completed
				successfully.</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>


<div class="row">

	<div class="modal-body">
		<form id="studentInfo">
			<div class="form-group">
				<div class="form-row">
					<div class="col-md-4">
						<input type="text" class="form-control" id="formKeyword"
							name="formKeyword" placeholder="ID or Name" />
					</div>
					<div class="col-md-2">
						<button type="button" class="btn btn-primary" data-toggle="modal"
							data-target="#myModal">Search</button>
					</div>
					<div class="col-md-2">
						<button type="button" class="btn btn-primary" data-toggle="modal"
							data-target="#myModal">Update</button>
					</div>
					<div class="col-md-2">
						<button type="button" class="btn btn-primary" data-toggle="modal"
							data-target="#registerModal">New</button>
					</div>
					<div class="col-md-2">
						<button type="button" class="btn btn-primary" onclick="clearForm()">Clear</button>
					</div>
				</div>
			</div>


			<div class="form-group">
				<div class="form-row">
					<div class="col-md-4">
						<label for="selectOption">State</label>
						<select class="form-control" id="formState" name="formState">
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
							class="form-control" id="formBranch" name="formBranch">
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
						<label for="datepicker">Enrolment</label> <input type="text"
							class="form-control datepicker" id="formEnrolment"
							name="formEnrolment" placeholder="Select a date" required>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="form-row">

					<div class="col-md-2">
						<label for="name">ID</label> <input type="text"
							class="form-control" id="formId" name="formId" readonly>
					</div>
					<div class="col-md-4">
						<label for="name">First Name:</label> <input type="text"
							class="form-control" id="formFirstName" name="formFirstName">
					</div>
					<div class="col-md-4">
						<label for="name">Last Name:</label> <input type="text"
							class="form-control" id="formLastName" name="formLastName">
					</div>
					<div class="col-md-2">
						<label for="selectOption">Grade</label> <select
							class="form-control" id="formGrade" name="formGrade">
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
							<option value="vce">VCE</option>
							<option value="tt6">TT6</option>
							<option value="tt8">TT8</option>
							<option value="tt8e">TT8E</option>
							<option value="jmss">JMSS</option>
						</select>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="form-row">
					<div class="col-md-5">
						<label for="name">Email</label> <input type="text"
							class="form-control" id="formEmail" name="formEmail">
					</div>
					<div class="col-md-7">
						<label for="name">Address</label> <input type="text"
							class="form-control" id="formAddress" name="formAddress">
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="form-row">
					<div class="col-md-6">
						<label for="name">Contact No 1</label> <input type="text"
							class="form-control" id="formContact1" name="formContact1">
					</div>
					<div class="col-md-6">
						<label for="name">Contact No 2</label> <input type="text"
							class="form-control" id="formContact2" name="formContact2">
					</div>
				</div>
			</div>

			<div class="form-group">
				<div class="form-row">
					<label for="message">Memo</label>
					<textarea class="form-control" id="formMemo" name="formMemo"></textarea>
				</div>
			</div>
		</form>
	</div>
</div>




<!-- Form Dialogue -->
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">Student Enrolment</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form id="studentRegister">
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-4">
								<label for="selectOption">State</label> 
								<select class="form-control" id="state" name="state">
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
									class="form-control" id="branch" name="branch">
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
								<label for="datepicker">Enrolment</label> <input type="text"
									class="form-control datepicker" id="enrolment" name="enrolment"
									placeholder="dd/mm/yyyy">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-5">
								<label for="name">First Name:</label> <input type="text"
									class="form-control" id="firstName" name="firstName">
							</div>
							<div class="col-md-5">
								<label for="name">Last Name:</label> <input type="text"
									class="form-control" id="lastName" name="lastName">
							</div>
							<div class="col-md-2">
								<label for="selectOption">Grade</label> <select
									class="form-control" id="grade" name="grade">
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
									<option value="vce">VCE</option>
									<option value="tt6">TT6</option>
									<option value="tt8">TT8</option>
									<option value="tt8e">TT8E</option>
									<option value="jmss">JMSS</option>
								</select>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-5">
								<label for="name">Email</label> <input type="text"
									class="form-control" id="email" name="email">
							</div>
							<div class="col-md-7">
								<label for="name">Address</label> <input type="text"
									class="form-control" id="address" name="address">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="name">Contact No 1</label> <input type="text"
									class="form-control" id="contact1" name="contact1">
							</div>
							<div class="col-md-6">
								<label for="name">Contact No 2</label> <input type="text"
									class="form-control" id="contact2" name=contact2">
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="form-row">
							<label for="message">Memo</label>
							<textarea class="form-control" id="memo" name="memo"></textarea>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="submit" class="btn btn-primary" onclick="submitForm()">Register</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->



