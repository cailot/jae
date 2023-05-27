<script>
	///////////////////////////////////////////////////////////////////////////
	// 		Add Student
	///////////////////////////////////////////////////////////////////////////
	function addStudent() {
		// Get from form data
		var std = {
			firstName : $("#addFirstName").val(),
			lastName : $("#addLastName").val(),
			address : $("#addAddress").val(),
			email1 : $("#addEmail1").val(),
			email2 : $("#addEmail2").val(),
			relation1 : $("#addRelation1").val(),
			relation2 : $("#addRelation2").val(),
			contactNo1 : $("#addContact1").val(),
			contactNo2 : $("#addContact2").val(),
			memo : $("#addMemo").val(),
			state : $("#addState").val(),
			branch : $("#addBranch").val(),
			grade : $("#addGrade").val(),
			registerDate : $("#addRegisterDate").val(),
		}
		// Send AJAX to server
		$.ajax({
			url : '${pageContext.request.contextPath}/student/register',
			type : 'POST',
			dataType : 'json',
			data : JSON.stringify(std),
			contentType : 'application/json',
			success : function(student) {
				//debugger;
				// Display the success alert
				$('#success-alert .modal-body').html('New student is registered successfully.');
				$('#success-alert').modal('toggle');
				// Update display info
				$("#formId").val(student.id);
				$("#formFirstName").val(student.firstName);
				$("#formLastName").val(student.lastName);
				$("#formEmail1").val(student.email1);
				$("#formEmail2").val(student.email2);
				$("#formRelation1").val(student.relation1);
				$("#formRelation2").val(student.relation2);
				$("#formGrade").val(student.grade);
				$("#formAddress").val(student.address);
				$("#formContact1").val(student.contactNo1);
				$("#formContact2").val(student.contactNo2);
				$("#formMemo").val(student.memo);
				$("#formState").val(student.state);
				$("#formBranch").val(student.branch);
				$('#formActive').prop('checked', true);
				$("#formActive").prop("disabled", true);
				// Set date value
				var date = new Date(student.registerDate); // Replace with your date value
				$("#formRegisterDate").datepicker('setDate', date);
			},
			error : function(xhr, status, error) {
				console.log('Error : ' + error);
			}
		});
		$('#registerModal').modal('hide');
		// flush all registered data
		document.getElementById("studentRegister").reset();		
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 			Deactivate student
	////////////////////////////////////////////////////////////////////////////////////////////////////////
	function inactivateStudent() {
		var id = $("#formId").val();
		//warn if Id is empty
		if (id == '') {
			$('#warning-alert .modal-body').text('Please search student record before suspend');
			$('#warning-alert').modal('toggle');
			return;
		}

		// send query to controller
		$.ajax({
			url : '${pageContext.request.contextPath}/student/inactivate/' + id,
			type : 'PUT',
			success : function(data) {
				$('#deactivateModal').modal('hide');
				$('#success-alert .modal-body').html('ID : <b>' + id + '</b> is now suspended');
				$('#success-alert').modal('toggle');
				clearStudentForm();
			},
			error : function(xhr, status, error) {
				console.log('Error : ' + error);
			}
		}); 
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 			Re-activate student
	////////////////////////////////////////////////////////////////////////////////////////////////////////
	function reactivateStudent() {
		var id = $("#formId").val();
		//warn if Id is empty
		if (id == '') {
			$('#warning-alert .modal-body').text('Please search student record before activate');
			$('#warning-alert').modal('toggle');
			return;
		}
			// send query to controller
		$.ajax({
			url : '${pageContext.request.contextPath}/student/activate/' + id,
			type : 'PUT',
			success : function(data) {
				$('#success-alert .modal-body').html('ID : <b>' + id + '</b> is now activated');
				$('#success-alert').modal('toggle');
				displayStudentInfo(data);
			},
			error : function(xhr, status, error) {
				console.log('Error : ' + error);
			}
		}); 
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	//			Search Student with Keyword	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	function searchStudent() {
		//warn if keyword is empty
		if ($("#formKeyword").val() == '') {
			$('#warning-alert .modal-body').text('Please fill in keyword before search');
			$('#warning-alert').modal('toggle');
			return;
		}
		// send query to controller
		$('#studentListResultTable tbody').empty();
		$.ajax({
			url : '${pageContext.request.contextPath}/student/search',
			type : 'GET',
			data : {
				keyword : $("#formKeyword").val()
			},
			success : function(data) {
				//console.log('search - ' + data);
				if (data == '') {
					$('#warning-alert .modal-body').html('No record found with <b>' + $("#formKeyword").val() + '</b>');
					$('#warning-alert').modal('toggle');
					clearStudentForm();
					return;
				}
				$.each(data, function(index, value) {
					const cleaned = cleanUpJson(value);
					var row = $("<tr onclick='displayStudentInfo(" + cleaned + ")'>");		
					row.append($('<td>').text(value.id));
					row.append($('<td>').text(value.firstName));
					row.append($('<td>').text(value.lastName));
					row.append($('<td>').text(value.grade.toUpperCase()));
					row.append($('<td>').text(formatDate(value.registerDate)));
					row.append($('<td>').text(formatDate(value.endDate)));
					row.append($('<td>').text(value.email1));
					row.append($('<td>').text(value.contactNo1));
					row.append($('<td>').text(value.email2));
					row.append($('<td>').text(value.contactNo2));
					row.append($('<td>').text(value.address));
					$('#studentListResultTable > tbody').append(row);
				});
				$('#studentListResult').modal('show');
			},
			error : function(xhr, status, error) {
				console.log('Error : ' + error);
			}
		});
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	//		Update existing student
	/////////////////////////////////////////////////////////////////////////////////////////////////////////	
	function updateStudentInfo() {
		// if activate process, then call activateStudent()
		if($('#formEndDate').val()!='' && $('#formActive').prop('checked')){
			reactivateStudent();
			return;
		}		
		//warn if Id is empty
		if ($("#formId").val() == '') {
			$('#warning-alert .modal-body').text('Please search student record before update');
			$('#warning-alert').modal('toggle');
			return;
		}
		// get from formData
		var std = {
			id : $('#formId').val(),
			firstName : $("#formFirstName").val(),
			lastName : $("#formLastName").val(),
			email1 : $("#formEmail1").val(),
			email2 : $("#formEmail2").val(),
			relation1 : $("#formRelation1").val(),
			relation2 : $("#formRelation2").val(),
			address : $("#formAddress").val(),
			contactNo1 : $("#formContact1").val(),
			contactNo2 : $("#formContact2").val(),
			memo : $("#formMemo").val(),
			state : $("#formState").val(),
			branch : $("#formBranch").val(),
			grade : $("#formGrade").val(),
			registerDate : $("#formRegisterDate").val(),
		}
			
		// send query to controller
		$.ajax({
			url : '${pageContext.request.contextPath}/student/update',
			type : 'PUT',
			dataType : 'json',
			data : JSON.stringify(std),
			contentType : 'application/json',
			success : function(value) {
				// Display success alert
				$('#success-alert .modal-body').html('ID : <b>' + value.id + '</b> is updated successfully.');
				$('#success-alert').modal('toggle');
			},
			error : function(xhr, status, error) {
				console.log('Error : ' + error);
			}
		});
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	//		Display selected student in student search
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	function displayStudentInfo(value) {
		
		clearStudentForm();
		$("#formId").val(value['id']);
		//debugger;
		if(value['endDate']===''){ // active student
			$("#formFirstName").val(value['firstName']).css("color", "black");
			$("#formLastName").val(value['lastName']).css("color", "black");
			$("#formEmail1").val(value['email1']).css("color", "black");
			$("#formEmail2").val(value['email2']).css("color", "black");
			$("#formRelation1").val(value['relation1']).css("color", "black");
			$("#formRelation2").val(value['relation2']).css("color", "black");
			$("#formGrade").val(value['grade']).css("color", "black");
			$("#formAddress").val(value['address']).css("color", "black");
			$("#formContact1").val(value['contactNo1']).css("color", "black");
			$("#formContact2").val(value['contactNo2']).css("color", "black");
			$("#formMemo").val(value['memo']).css("color", "black");
			$('#formActive').prop('checked', true);
			$("#formActive").prop("disabled", true);
		}else{ // inactive student
			$("#formFirstName").val(value['firstName']).css("color", "red");
			$("#formLastName").val(value['lastName']).css("color", "red");
			$("#formEmail1").val(value['email1']).css("color", "red");
			$("#formEmail2").val(value['email2']).css("color", "red");
			$("#formRelation1").val(value['relation1']).css("color", "red");
			$("#formRelation2").val(value['relation2']).css("color", "red");
			$("#formGrade").val(value['grade']).css("color", "red");
			$("#formAddress").val(value['address']).css("color", "red");
			$("#formContact1").val(value['contactNo1']).css("color", "red");
			$("#formContact2").val(value['contactNo2']).css("color", "red");
			$("#formMemo").val(value['memo']).css("color", "red");
			$('#formActive').prop('checked', false);
			$("#formActive").prop("disabled", false);
		}
		$("#formState").val(value['state']);
		$("#formBranch").val(value['branch']);
		// display same selected grade to Course Register section
		//$("#registerGrade").val(value['grade']);
		$("#formEndDate").val(value['endDate']);
		
		// Set date value
		// const tempDate = formatDate(value['registerDate']);
		// var date = new Date(tempDate); // Replace with your date value
		var date = new Date(value['registerDate']); // Replace with your date value
		$("#formRegisterDate").datepicker('setDate', date);
		
		// dispose modal
		$('#studentListResult').modal('hide');
		// clear search keyword
		$("#formKeyword").val('');
	
	}

	// Clear all form
	function clearStudentForm() {
		document.getElementById("studentInfo").reset();
	}

	// date format for datepicker. it changes date format from yyyy-mm-dd to dd/mm/yyyy
	function formatDate(dateString) {
		if (dateString.includes('-')) {
			const parts = dateString.split('-');
			const formattedDate = parts.reverse().join('/');
			return formattedDate;
		} else {
			return dateString; // Return the original string if it doesn't contain '-'
		}
	}


</script>


<!-- Deactivate Dialogue -->
<div class="modal fade" id="deactivateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header btn-danger">
               <h4 class="modal-title text-white" id="myModalLabel"><i class="fa fa-exclamation-circle"></i>&nbsp;&nbsp;Student Suspend</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <p> Do you want to suspend this student?</p>	
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-danger" onclick="inactivateStudent()"><i class="fa fa-times"></i> Suspend</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal"><i class="fa fa-check"></i> Close</button>
            </div>
    	</div>
	</div>
</div>


<!-- Search Result Dialog -->
<div class="modal fade" id="studentListResult">
	<div class="modal-dialog modal-xl modal-dialog-centered">
	  <div class="modal-content">
		<div class="modal-header bg-primary text-white">
		  <h5 class="modal-title">&nbsp;<i class="fas fa-list"></i>&nbsp;&nbsp; Student List</h5>
		  <button type="button" class="close" data-dismiss="modal">
			<span>&times;</span>
		  </button>
		</div>
		<div class="modal-body table-wrap">
		  <table class="table table-striped table-bordered" id="studentListResultTable" data-header-style="headerStyle" style="font-size: smaller;">
			<thead class="thead-light">
			  <tr>
				<th data-field="id">ID</th>
				<th data-field="firstname">First Name</th>
				<th data-field="lastname">Last Name</th>
				<th data-field="grade">Grade</th>
				<th data-field="startdate">Start Date</th>
				<th data-field="enddate">End Date</th>
				<th data-field="email">Main Email</th>
				<th data-field="contact1">Main Contact</th>
				<th data-field="email">Sub Email</th>
				<th data-field="contact2">Sub Contact</th>
				<th data-field="address">Address</th>
			  </tr>
			</thead>
			<tbody>
			</tbody>
		  </table>
		</div>
		<div class="modal-footer">
		  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		</div>
	  </div>
	</div>
  </div>
  
  <style>
	.table-wrap {
	  overflow-x: auto;
	}
	#studentListResultTable th, #studentListResultTable td { white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
	.form-group{
		margin-bottom: 30px;
	}
  </style>
  
  

<!-- Register Form Dialogue -->
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<section class="fieldset rounded border-primary">
					<header class="text-primary font-weight-bold">Student Registration</header>
				<form id="studentRegister">
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-4">
								<label for="addState" class="label-form">State</label> <select class="form-control" id="addState" name="addState">
									<option value="vic">Victoria</option>
									</select>
							</div>
							<div class="col-md-5">
								<label for="addBranch" class="label-form">Branch</label> <select class="form-control" id="addBranch" name="addBranch">
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
								<label for="addRegisterDate" class="label-form">Registration</label> 
								<input type="text" class="form-control datepicker" id="addRegisterDate" name="addRegisterDate" placeholder="dd/mm/yyyy">
							</div>
							<script>
								var today = new Date();
								var day = today.getDate();
								var month = today.getMonth() + 1; // Note: January is 0
								var year = today.getFullYear();
								var formattedDate = (day < 10 ? '0' : '') + day + '/' + (month < 10 ? '0' : '') + month + '/' + year;
								document.getElementById('addRegisterDate').value = formattedDate;
							</script>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-5">
								<label for="addFirstName" class="label-form">First Name:</label> <input type="text" class="form-control" id="addFirstName" name="addFirstName">
							</div>
							<div class="col-md-4">
								<label for="addLastName" class="label-form">Last Name:</label> <input type="text" class="form-control" id="addLastName" name="addLastName">
							</div>
							<div class="col-md-3">
								<label for="addGrade" class="label-form">Grade</label> <select class="form-control" id="addGrade" name="addGrade">
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
							<div class="col-md-7">
								<label for="addAddress" class="label-form">Address</label> <input type="text" class="form-control" id="addAddress" name="addAddress">
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="form-row admin-form-row">
							<div class="col-md-6">
								<section class="fieldset rounded border-secondary" style="padding: 10px;">
									<header class="text-secondary" style="font-size: 1.1em;">Main Contact</header>
								<div class="row">
									<div class="col-md-8">
										<input type="text" class="form-control" id="addContact1" name="addContact1" placeholder="Contact No">
									</div>
									<div class="col-md-4">
										<select class="form-control" id="addRelation1" name="addRelation1">
											<option value="mother">Mother</option>
											<option value="father">Father</option>
											<option value="other">Other</option>
										</select>
									</div>	
								</div>
								<div class="row">
									<div class="col-md-12">
										<input type="text" class="form-control" id="addEmail1" name="addEmail1" placeholder="Email">
									</div>
								</div>
								</section>
							</div>
							<div class="col-md-6">
								<section class="fieldset rounded border-secondary" style="padding: 10px;">
									<header class="text-secondary" style="font-size: 1.1em;">Sub Contact</header>
								
								<div class="row">
									<div class="col-md-8">
										<input type="text" class="form-control" id="addContact2" name="addContact2" placeholder="Contact No">
									</div>
									<div class="col-md-4">
										<select class="form-control" id="addRelation2" name="addRelation2">
											<option value="mother">Mother</option>
											<option value="father">Father</option>
											<option value="other">Others</option>
										</select>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<input type="text" class="form-control" id="addEmail2" name="addEmail2" placeholder="Email">
									</div>
								</div>
								</section>
							</div>
						</div>
					</div>	



					<div class="form-group">
						<div class="form-row">
							<div class="col-md-12">
								<label for="addMemo" class="label-form">Memo</label>
								<textarea class="form-control" style="height: 200px;" id="addMemo" name="addMemo"></textarea>
							</div>
						</div>
					</div>
				</form>
				<div class="d-flex justify-content-end">
    				<button type="submit" class="btn btn-primary" onclick="addStudent()">Register</button>&nbsp;&nbsp;
    				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>	
				</section>
			</div>
		</div>
	</div>
</div>

<!-- Administration Body -->
<div class="row">
	<div class="modal-body">
		<form id="studentInfo">
			<div class="form-group">
				<div class="form-row admin-form-row">
					<div class="col-md-8">
						<input type="text" class="form-control" style="background-color: #FCF7CA;" id="formKeyword" name="formKeyword" placeholder="ID or Name" />
					</div>
					<div class="col-md-4">
						<button type="button" class="btn btn-block btn-primary" onclick="searchStudent()">Search</button>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="form-row admin-form-row">
					<div class="col mx-auto">
						<button type="button" class="btn btn-block btn-success" data-toggle="modal" data-target="#registerModal">New</button>
					</div>
					<div class="col mx-auto">
						<button type="button" class="btn btn-block btn-warning" onclick="updateStudentInfo()">Save</button>
					</div>
					<div class="col mx-auto">
						<button type="button" class="btn btn-block btn-danger" data-toggle="modal" data-target="#deactivateModal">Suspend</button>
					</div>
					<div class="col mx-auto">
						<button type="button" class="btn btn-block btn-info" onclick="clearStudentForm()">Clear</button>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="form-row admin-form-row">
					<div class="col-md-4">
						<label for="formState" class="label-form">State</label> 
						<select class="form-control" id="formState" name="formState">
							<option value="vic">Victoria</option>
						</select>
					</div>
					<div class="col-md-4">
						<label for="formBranch" class="label-form">Branch</label> <select
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
					<div class="col-md-4">
						<label for="datepicker" class="label-form">Registration Date</label> <input type="text" class="form-control datepicker" id="formRegisterDate" name="formRegisterDate" placeholder=" Select a date" required>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="form-row admin-form-row">
					<div class="col-md-3">
						<input type="text"
							class="form-control" id="formId" name="formId" placeholder="ID" readonly>
					</div>
					<div class="col-md-5">
						<input type="text"
							class="form-control" id="formFirstName" name="formFirstName" placeholder="First Name">
					</div>
					<div class="col-md-4">
						<input type="text" class="form-control" id="formLastName" name="formLastName" placeholder="Last Name">
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="form-row admin-form-row">
					<div class="input-group col-md-4">
					  <div class="input-group-prepend">
					    <div class="input-group-text">
					      <input type="checkbox" id="formActive" name="formActive" disabled>
					    </div>
					  </div>
					  <input type="text" id="formActiveLabel" class="form-control" placeholder="Activated" readonly>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="form-row admin-form-row">
					<div class="col-md-9">
						<input type="text"
							class="form-control" id="formAddress" name="formAddress" placeholder="Address">
					</div>
					<div class="col-md-3">
						<select class="form-control" id="formGrade" name="formGrade">
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
				<div class="form-row admin-form-row">
					<div class="col-md-6">
						<section class="fieldset rounded border-secondary" style="padding: 10px;">
							<header class="text-secondary" style="font-size: 1.1em;">Main Contact</header>
						<div class="row">
							<div class="col-md-8">
								<input type="text" class="form-control" id="formContact1" name="formContact1" placeholder="Contact No">
							</div>
							<div class="col-md-4">
								<select class="form-control" id="formRelation1" name="formRelation1">
									<option value="mother">Mother</option>
									<option value="father">Father</option>
									<option value="other">Other</option>
								</select>
							</div>	
						</div>
						<div class="row">
							<div class="col-md-12">
								<input type="text" class="form-control" id="formEmail1" name="formEmail1" placeholder="Email">
							</div>
						</div>
						</section>
					</div>
					<div class="col-md-6">
						<section class="fieldset rounded border-secondary" style="padding: 10px;">
							<header class="text-secondary" style="font-size: 1.1em;">Sub Contact</header>
						
						<div class="row">
							<div class="col-md-8">
								<input type="text" class="form-control" id="formContact2" name="formContact2" placeholder="Contact No">
							</div>
							<div class="col-md-4">
								<select class="form-control" id="formRelation2" name="formRelation2">
									<option value="mother">Mother</option>
									<option value="father">Father</option>
									<option value="other">Others</option>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<input type="text" class="form-control" id="formEmail2" name="formEmail2" placeholder="Email">
							</div>
						</div>
						</section>
					</div>
				</div>
			</div>

			<div class="form-group">
				<div class="form-row admin-form-row">
					<div class="col-md-12">
						<textarea class="form-control" id="formMemo" name="formMemo" style="height: 200px;" placeholder="Memo"></textarea>
					</div>
				</div>
			</div>
			<input type="hidden" id="formEndDate" name="formEndDate" />
		</form>
	</div>
</div>







