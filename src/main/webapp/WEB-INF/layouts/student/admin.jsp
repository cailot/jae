<script>
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
				console.log('Success : ' + student);
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

	// Search Student with Keyword	
	function searchStudent() {
		//warn if keyword is empty
		if ($("#formKeyword").val() == '') {
			$('#warning-alert .modal-body').text(
					'Please fill in keyword before search');
			$('#warning-alert').modal('show');
			return;
		}

		// send query to controller
		$('#studentListResultTable tbody').empty();
		$.ajax({
			url : 'student/search',
			type : 'GET',
			data : {
				keyword : $("#formKeyword").val()
			},
			success : function(data) {
				//console.log('search - ' + data);
				if (data == '') {
					$('#warning-alert .modal-body').text(
							'No record found with ' + $("#formKeyword").val());
					$('#warning-alert').modal('show');
					clearStudentForm();
					return;
				}
				$.each(data, function(index, value) {
					var row = $("<tr onclick='displayStudentInfo("
							+ JSON.stringify(value) + ")''>");
					row.append($('<td>').text(value.id));
					row.append($('<td>').text(value.firstName));
					row.append($('<td>').text(value.lastName));
					row.append($('<td>').text(value.grade));
					row.append($('<td>').text(value.registerDate));
					row.append($('<td>').text(value.endDate));
					row.append($('<td>').text(value.email));
					row.append($('<td>').text(value.contactNo1));
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

	// Display selected student in student search
	function displayStudentInfo(value) {
		clearStudentForm();
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
		$("#formGrade").val(value['grade']);
		// Set date value
		var date = new Date(value['enrolmentDate']); // Replace with your date value
		$("#formEnrolment").datepicker('setDate', date);

		// dispose modal
		$('#studentListResult').modal('hide');
		// clear search keyword
		$("#formKeyword").val('');
	}

	// Update existing student
	function updateStudentInfo() {
		//warn if Id is empty
		if ($("#formId").val() == '') {
			$('#warning-alert .modal-body').text(
					'Please search student record before update');
			$('#warning-alert').modal('show');
			return;
		}

		// get from formData
		var std = {
			id : $('#formId').val(),
			firstName : $("#formFirstName").val(),
			lastName : $("#formLastName").val(),
			email : $("#formEmail").val(),
			address : $("#formAddress").val(),
			contactNo1 : $("#formContact1").val(),
			contactNo2 : $("#formContact2").val(),
			memo : $("#formMemo").val(),
			state : $("#formState").val(),
			branch : $("#formBranch").val(),
			grade : $("#formGrade").val(),
			enrolmentDate : $("#formEnrolment").val()
		}
		// send query to controller
		$.ajax({
			url : 'student/update',
			type : 'PUT',
			dataType : 'json',
			data : JSON.stringify(std),
			contentType : 'application/json',
			success : function(value) {
				// Display success alert
				$('#success-alert .modal-body').text(
						'ID : ' + value.id + ' is updated successfully.');
				$('#success-alert').modal('show');

				// Update display info
				clearStudentForm();
				$("#formId").val(value.id);
				$("#formFirstName").val(value.firstName);
				$("#formLastName").val(value.lastName);
				$("#formEmail").val(value.email);
				$("#formAddress").val(value.address);
				$("#formContact1").val(value.contactNo1);
				$("#formContact2").val(value.contactNo2);
				$("#formMemo").val(value.memo);
				$("#formState").val(value.state);
				$("#formBranch").val(value.branch);
				$("#formGrade").val(value.grade);
				// Set date value
				var date = new Date(value.enrolmentDate); // Replace with your date value
				$("#formEnrolment").datepicker('setDate', date);
				// clear search keyword
				$("#formKeyword").val('');

			},
			error : function(xhr, status, error) {
				console.log('Error : ' + error);
			}
		});
	}

	function inactivateStudent() {

		var id = $("#formId").val();

		//warn if Id is empty
		if (id == '') {
			$('#warning-alert .modal-body').text(
					'Please search student record before inactivate');
			$('#warning-alert').modal('show');
			return;
		}
		// send query to controller
		$.ajax({
			url : 'student/inactivate/' + id,
			type : 'PUT',
			success : function(data) {
				// clear existing form
				$('#success-alert .modal-body').text(
						'ID : ' + id + ' is now inactivated');
				$('#success-alert').modal('show');
				clearStudentForm();
			},
			error : function(xhr, status, error) {
				console.log('Error : ' + error);
			}
		});
	}

	// Clear all form
	function clearStudentForm() {
		document.getElementById("studentInfo").reset();
	}
</script>


<!-- Administration Body -->
<div class="row">
	<div class="modal-body">
		<form id="studentInfo">
			<div class="form-group">
				<div class="form-row">
					<div class="col-md-8">
						<input type="text" class="form-control form-control-sm"
							style="background-color: #FCF7CA;" id="formKeyword"
							name="formKeyword" placeholder="ID or Name" />
					</div>
					<div class="col-md-4">
						<button type="button" class="btn btn-block btn-primary btn-sm"
							onclick="searchStudent()">Search</button>
					</div>
				</div>
			</div>

			<div class="form-group">
				<div class="form-row">
					<div class="col mx-auto">
						<button type="button" class="btn btn-block btn-primary btn-sm"
							data-toggle="modal" data-target="#registerModal">New</button>
					</div>
					<div class="col mx-auto">
						<button type="button" class="btn btn-block btn-primary btn-sm"
							onclick="updateStudentInfo()">Update</button>
					</div>
					<div class="col mx-auto">
						<button type="button" class="btn btn-block btn-primary btn-sm"
							onclick="inactivateStudent()">Suspend</button>
					</div>

					<div class="col mx-auto">
						<button type="button" class="btn btn-block btn-primary btn-sm"
							onclick="clearStudentForm()">Clear</button>
					</div>
				</div>
			</div>

			<div class="form-group">
				<div class="form-row">
					<div class="col-md-6">
						<label for="formState" class="label-form">State</label> <select class="form-control form-control-sm"
							id="formState" name="formState">
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
						<label for="formBranch" class="label-form">Branch</label> <select
							class="form-control form-control-sm" id="formBranch" name="formBranch">
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

				</div>
			</div>

			<div class="form-group">
				<div class="form-row">
					<div class="col-md-3">
						<label for="formId" class="label-form">ID</label>
						<input type="text"
							class="form-control form-control-sm" id="formId" name="formId" readonly>
					</div>

					<div class="col-md-3">
						<label for="formGrade" class="label-form">Grade</label> <select
							class="form-control form-control-sm" id="formGrade" name="formGrade">
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
					<div class="col-md-6">
						<label for="datepicker" class="label-form">Enrolment</label> <input type="text"
							class="form-control form-control-sm datepicker" id="formEnrolment"
							name="formEnrolment" placeholder="Select a date" required>
					</div>
				</div>
			</div>

			<div class="form-group">
				<div class="form-row">

					<div class="col-md-6">
						<input type="text"
							class="form-control form-control-sm" id="formFirstName" name="formFirstName" placeholder="First Name">
					</div>
					<div class="col-md-6">
						<input type="text"
							class="form-control form-control-sm" id="formLastName" name="formLastName" placeholder="Last Name">
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="form-row">
					<div class="col-md-12">
						<input type="text"
							class="form-control form-control-sm" id="formEmail" name="formEmail" placeholder="Email">
					</div>

				</div>
			</div>
			<div class="form-group">
				<div class="form-row">
					<div class="col-md-12">
						<input type="text"
							class="form-control form-control-sm" id="formAddress" name="formAddress" placeholder="Address">
					</div>
				</div>
			</div>

			<div class="form-group">
				<div class="form-row">
					<div class="col-md-6">
						<input type="text"
							class="form-control form-control-sm" id="formContact1" name="formContact1" placeholder="Contact No 1">
					</div>
					<div class="col-md-6">
						<input type="text"
							class="form-control form-control-sm" id="formContact2" name="formContact2" placeholder="Contact No 2">
					</div>
				</div>
			</div>

			<div class="form-group">
				<div class="form-row">
					<textarea class="form-control form-control-sm" id="formMemo" name="formMemo" placeholder="Memo"></textarea>
				</div>
			</div>
		</form>
	</div>
</div>







