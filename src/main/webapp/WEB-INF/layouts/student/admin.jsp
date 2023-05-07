<script>
	$(document).ready(
		function() {
			$('#elearingDropdown').on('change',function() {
				var selectedOptionText = $(this).find(
						'option:selected').text();
				// add new row into table
				var table = document.getElementById(
						"gradeAssociateElearningTable")
						.getElementsByTagName('tbody')[0];
				var row = table.insertRow(0);
				row.style.height="35px"; // set the height of the row
				var cell0 = row.insertCell(0);
				cell0.innerHTML = $(this).find('option:selected').val();
				$(cell0).addClass('hidden-column');
				var val = selectedOptionText.split("] ");
				var cell1 = row.insertCell(1);
				cell1.innerHTML = val[0].substring(1);
				$(cell1).addClass('small');
				var cell2 = row.insertCell(2);
				cell2.innerHTML = val[1];
				$(cell2).addClass('small');
				var cell3 = row.insertCell(3);
				cell3.innerHTML = '<a href="javascript:void(0)" title="Delete eLearning"><i class="fa fa-trash"></i></a>';
				//cell3.innerHTML = '<span class="elearningRemoveConfirm" title="Delete eLearning"><i class="fa fa-trash"></i></span>';
			});
			
		///////////////////////////////////////////////////////////////////////////////	
		// 				Register Form
		///////////////////////////////////////////////////////////////////////////////	
		// When register modal is shown, make an AJAX request to get list of elearnings
		$('#registerModal').on('shown.bs.modal', function() {
			// erase previous selected elearning course
			//$('#add-elearning-body').empty();
			
			//const dropdown = document.getElementById("addElearingDropdown");
			// remove all options before fetching new list
			// while (dropdown.options.length > 0) {
			// 	dropdown.remove(0);
			// }

			$.ajax({
			url: '${pageContext.request.contextPath}/elearning/available',
			type: 'GET',
			dataType: 'json',
			success: function(data) {
				// add elearning list to dropdown menu
				$.each(data, function(i, item) {
					const dropdown = document.getElementById("addElearingDropdown");
					const option = document.createElement("option");
					option.value = item.id;
					option.textContent = "[" + item.grade.toUpperCase() + "] "
							+ item.name;
					dropdown.appendChild(option);
				});
			},
			error: function(xhr, textStatus, errorThrown) {
				// Handle errors
				console.log(xhr.status);
				console.log(errorThrown);
			}
			});
		});

		// When users select elearning in register modal, table shows selected elearning.
		$('#addElearingDropdown').on('change',function() {
			var selectedOptionText = $(this).find('option:selected').text();
			// add new row into table
			var table = document.getElementById("addElearningTable").getElementsByTagName('tbody')[0];
			var row = table.insertRow(0);
			row.style.height="35px"; // set the height of the row
			var cell0 = row.insertCell(0);
			cell0.innerHTML = $(this).find('option:selected').val();
			$(cell0).addClass('hidden-column');
			var val = selectedOptionText.split("] ");
			var cell1 = row.insertCell(1);
			cell1.innerHTML = val[0].substring(1); // remove '[' 
			//$(cell1).addClass('small');
			var cell2 = row.insertCell(2);
			cell2.innerHTML = val[1];
			//$(cell2).addClass('small');
			var cell3 = row.insertCell(3);
			cell3.innerHTML = '<a href="javascript:void(0)" title="Delete eLearning"><i class="fa fa-trash"></i></a>';
			//cell3.innerHTML = '<span class="elearningRemoveConfirm" title="Delete eLearning"><i class="fa fa-trash"></i></span>';
		});

		// remove selected elearning in register dialog
		$('#addElearningTable').on('click', 'a', function() {
			var row = $(this).closest('tr');
			var name = row.find('td:eq(1)').text();
			if(confirm('Are you sure you want to remove ' + name +'?')){
				row.remove();
			}
		});
	});














		
	///////////////////////////////////////////////////////////////////////////
	// 		Add Student
	///////////////////////////////////////////////////////////////////////////
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
			enrolmentDate : $("#addEnrolment").val(),
			elearnings : []
		}
		// associate course info
		var cId = [];
		$("#addElearningTable tbody tr").each(function() {
		  cId.push($(this).find("td").eq(0).text());
		  var crs = {
				  id : $(this).find("td").eq(0).text()
		  };
		  std.elearnings.push(crs);
		});
		
		// Send AJAX to server
		$.ajax({
			url : '${pageContext.request.contextPath}/student/register',
			type : 'POST',
			dataType : 'json',
			data : JSON.stringify(std),
			contentType : 'application/json',
			success : function(student) {
				// Display the success alert
				$('#success-alert .modal-body').html('New student is registered successfully.');
				$('#success-alert').modal('toggle');
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
				$("#elearningGrade").val(student.grade);
				// Set date value
				var date = new Date(student.enrolmentDate); // Replace with your date value
				$("#formEnrolment").datepicker('setDate', date);
					// eLearning Info
				const crss = student.elearnings;
				if(crss != null){
					var body = $('#list-grade-associate-body');
					body.empty();
					for(let i=0; i<crss.length; i++){
						var row = $('<tr></tr>');
						row.append($('<td class="hidden-column"></td>').text(crss[i].id));
						row.append($('<td class="small"></td>')
								.text(crss[i].grade.toUpperCase()));
						row.append($('<td class="small"></td>').text(crss[i].name));
						row.append($('<td><a href="javascript:void(0)" title="Delete eLearning"><i class="fa fa-trash"></i></a></td>'));
						body.append(row);
					}
				}
			},
			error : function(xhr, status, error) {
				console.log('Error : ' + error);
			}
		});
		$('#registerModal').modal('hide');
		// flush all registered data
		document.getElementById("studentRegister").reset();
		clearElearningOnRegister();
		availableElearnings();
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
				//$('#ReactivateModal').modal('hide');
				$('#success-alert .modal-body').html('ID : <b>' + id + '</b> is now activated');
				$('#success-alert').modal('toggle');
				clearStudentForm();
			},
			error : function(xhr, status, error) {
				console.log('Error : ' + error);
			}
		}); 
	}
	


	// clean old elearning on Register form
	function clearElearningOnRegister(){
		// erase previous selected elearning course
		$('#add-elearning-body').empty();
		const dropdown = document.getElementById("addElearingDropdown");
		// remove all options before fetching new list
		while (dropdown.options.length > 0) {
			dropdown.remove(0);
		}
	}
	// Search Student with Keyword	
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
					var escapedValue = JSON.stringify(value).replace(/'/g, '&#39;');
					var row = $("<tr onclick='displayStudentInfo(" + escapedValue + ")'>");		
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
		
		if(value['endDate']===''){ // active student
			$("#formFirstName").val(value['firstName']).css("color", "black");
			$("#formLastName").val(value['lastName']).css("color", "black");
			$("#formEmail").val(value['email']).css("color", "black");
			$("#formAddress").val(value['address']).css("color", "black");
			$("#formContact1").val(value['contactNo1']).css("color", "black");
			$("#formContact2").val(value['contactNo2']).css("color", "black");
			$("#formMemo").val(value['memo']).css("color", "black");
			$('#formActive').prop('checked', true);
			$("#formActive").prop("disabled", true);
		}else{ // inactive student
			$("#formFirstName").val(value['firstName']).css("color", "red");
			$("#formLastName").val(value['lastName']).css("color", "red");
			$("#formEmail").val(value['email']).css("color", "red");
			$("#formAddress").val(value['address']).css("color", "red");
			$("#formContact1").val(value['contactNo1']).css("color", "red");
			$("#formContact2").val(value['contactNo2']).css("color", "red");
			$("#formMemo").val(value['memo']).css("color", "red");
			$('#formActive').prop('checked', false);
			$("#formActive").prop("disabled", false);
		}
		$("#formState").val(value['state']);
		$("#formBranch").val(value['branch']);
		$("#elearningGrade").val(value['grade']);
		// display same selected grade to Course Register section
		$("#registerGrade").val(value['grade']);
		$("#formEndDate").val(value['endDate']);
		
		// Set date value
		var date = new Date(value['enrolmentDate']); // Replace with your date value
		$("#formEnrolment").datepicker('setDate', date);
		
		// dispose modal
		$('#studentListResult').modal('hide');
		// clear search keyword
		$("#formKeyword").val('');
		
		// eLearning Info
		const crss = value.elearnings;
		if(crss != null){
			var body = $('#list-grade-associate-body');
			for(let i=0; i<crss.length; i++){
				var row = $('<tr style="height: 35px;"></tr>');
				row.append($('<td class="hidden-column"></td>').text(crss[i].id));
				row.append($('<td class="small"></td>')
						.text(crss[i].grade.toUpperCase()));
				row.append($('<td class="small"></td>').text(crss[i].name));
				row.append($('<td><a href="javascript:void(0)" title="Delete eLearning"><i class="fa fa-trash"></i></a></td>'));
				body.append(row);
			}
		}
	}

	// Update existing student
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
			email : $("#formEmail").val(),
			address : $("#formAddress").val(),
			contactNo1 : $("#formContact1").val(),
			contactNo2 : $("#formContact2").val(),
			memo : $("#formMemo").val(),
			state : $("#formState").val(),
			branch : $("#formBranch").val(),
			grade : $("#elearningGrade").val(),
			enrolmentDate : $("#formEnrolment").val(),
			elearnings : []
		}
		
		// associate course info
		var cId = [];
		$("#gradeAssociateElearningTable tbody tr").each(function() {
		  cId.push($(this).find("td").eq(0).text());
		  var crs = {
				  id : $(this).find("td").eq(0).text()
		  };
		  std.elearnings.push(crs);
		});
		
		// send query to controller
		$.ajax({
			url : '${pageContext.request.contextPath}/student/update',
			type : 'PUT',
			dataType : 'json',
			//data : JSON.stringify(std, cId),
			
			data : JSON.stringify(std),
			contentType : 'application/json',
			success : function(value) {
				// Display success alert
				$('#success-alert .modal-body').html('ID : <b>' + value.id + '</b> is updated successfully.');
				$('#success-alert').modal('toggle');
				// Display returned result
				displayStudentInfo(value);
			},
			error : function(xhr, status, error) {
				console.log('Error : ' + error);
			}
		});
	}

	
	
	

	
	
	
	
	
	

	
	// Clear all form
	function clearStudentForm() {
		document.getElementById("studentInfo").reset();
		$('#list-grade-associate-body').empty();
		// flush courses and re-list all
		availableElearnings();
		//////////////////////////////////////////////////////////////////////////
		// clear grade info on Course Registration section
		
	}
	
	
	// Course Info
	// Get list of courses by grade
	// function listElearnings(grade) {
	// 	var body = $('#list-grade-associate-body');
	// 	//var grade = $("#elearningGrade").val();
	// 	//console.log(grade);
	// 	const dropdown = document.getElementById("elearingDropdown");
	// 	body.empty();
	// 	// remove all options before fetching new list
	// 	while (dropdown.options.length > 0) {
	// 		dropdown.remove(0);
	// 	}
	// 	const title = document.createElement("option");
	// 	title.textContent = "Click to add a subject";
	// 	dropdown.appendChild(title);
	// 	$.ajax({
	// 		url : "${pageContext.request.contextPath}/elearning/list",
	// 		type : 'GET',
	// 		data : grade,
	// 		success : function(data) {
	// 			$.each(data, function(i, item) {
	// 				if (item.grade == grade) {
	// 					var row = $('<tr></tr>');
	// 					row.append($('<td class="hidden-column"></td>').text(item.id));
	// 					row.append($('<td class="small"></td>')
	// 							.text(item.grade.toUpperCase()));
	// 					row.append($('<td class="small"></td>').text(item.name));
	// 					row.append($('<td><a href="javascript:void(0)" title="Delete eLearning"><i class="fa fa-trash"></i></a></td>'));
	// 					body.append(row);
	// 				} else {
	// 					//console.log(item.id);
	// 					const option = document.createElement("option");
	// 					option.value = item.id;
	// 					option.textContent = "[" + item.grade.toUpperCase() + "] " + item.name;
	// 					dropdown.appendChild(option);
	// 				}
	// 			});
	// 		}
	// 	});
	// }
	
	// Get list of available courses
	function availableElearnings() {
		var body = $('#list-grade-associate-body');
		const dropdown = document.getElementById("elearingDropdown");
		body.empty();
		// remove all options before fetching new list
		while (dropdown.options.length > 0) {
			dropdown.remove(0);
		}
		const title = document.createElement("option");
		title.textContent = "Click to add a subject";
		dropdown.appendChild(title);
		$.ajax({
			url : "${pageContext.request.contextPath}/elearning/available",
			type : 'GET',
			success : function(data) {
				$.each(data, function(i, item) {
						//console.log(item.id);
					const option = document.createElement("option");
					option.value = item.id;
					option.textContent = "[" + item.grade.toUpperCase() + "] " + item.name;
					dropdown.appendChild(option);
				});
			}
		});
	}
</script>




<!-- Deactivate Dialogue -->
<div class="modal fade" id="deactivateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">Student Suspend</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				Do you want to suspend this student ?	
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-danger" onclick="inactivateStudent()">Deactivate</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
	</div>
	<!-- /.modal-content -->
</div>
<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<!-- Reactivate Dialogue -->
<!-- <div class="modal fade" id="reactivateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">Student Re-activate</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				Do you want to re-activate this student ?	
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-success" onclick="reactivateStudent()">Re-activate</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
	</div>
</div>
</div> -->
<!-- /.modal -->



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
							<div class="col-md-12">
								<label for="message">Memo</label>
								<textarea class="form-control" id="addMemo" name="addMemo"></textarea>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-12">
								<!-- <label>Select to add subject</label>  -->
								<select class="form-control" id="addElearingDropdown" name="addElearingDropdown">
									<option value="p2">Click to add a subject</option>
								</select>
							</div>	
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-12">
								<table id="addElearningTable" style="width: 100%;" class="table-bordered table-sm">
									<thead class="table-primary">
										<tr class="small" style="height: 35px;">
											<th class="hidden-column"></th>
											<th>Grade</th>
											<th>eLearning Subject</th>
											<th>Delete</th>
										</tr>
									</thead>
									<tbody id="add-elearning-body">
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-primary" onclick="addStudent()">Register</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="clearElearningOnRegister()">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->























<!-- Administration Body -->
<div class="row">
	<div class="modal-body">
		<form id="studentInfo">
			<div class="form-group">
				<div class="form-row">
					<div class="col-md-8">
						<input type="text" class="form-control form-control-sm" style="background-color: #FCF7CA;" id="formKeyword" name="formKeyword" placeholder="ID or Name" />
					</div>
					<div class="col-md-4">
						<button type="button" class="btn btn-block btn-primary btn-sm" onclick="searchStudent()">Search</button>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="form-row">
					<div class="col mx-auto">
						<button type="button" class="btn btn-block btn-success btn-sm" data-toggle="modal" data-target="#registerModal">New</button>
					</div>
					<div class="col mx-auto">
						<button type="button" class="btn btn-block btn-warning btn-sm" onclick="updateStudentInfo()">Save</button>
					</div>
					<div class="col mx-auto">
						<button type="button" class="btn btn-block btn-danger btn-sm" data-toggle="modal" data-target="#deactivateModal">Suspend</button>
					</div>
					<div class="col mx-auto">
						<button type="button" class="btn btn-block btn-info btn-sm" onclick="clearStudentForm()">Clear</button>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="form-row">
					<div class="col-md-4">
						<label for="formState" class="label-form">State</label> <select class="form-control form-control-sm"
							id="formState" name="formState">
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
					<div class="col-md-4">
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
					<div class="col-md-4">
						<label for="datepicker" class="label-form">Enrolment</label> <input type="text" class="form-control form-control-sm datepicker" id="formEnrolment" name="formEnrolment" placeholder="Select a date" required>
					</div>

				</div>
			</div>


			<div class="form-group">
				<div class="form-row">
					<div class="col-md-3">
						<input type="text"
							class="form-control form-control-sm" id="formId" name="formId" placeholder="ID" readonly>
					</div>
					<div class="col-md-5">
						<input type="text"
							class="form-control form-control-sm" id="formFirstName" name="formFirstName" placeholder="First Name">
					</div>
					<div class="col-md-4">
						<input type="text"
							class="form-control form-control-sm" id="formLastName" name="formLastName" placeholder="Last Name">
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="form-row">
					<div class="col-md-9">
						<input type="text"
							class="form-control form-control-sm" id="formEmail" name="formEmail" placeholder="Email">
					</div>
					<div class="input-group col-md-3">
					  <div class="input-group-prepend">
					    <div class="input-group-text">
					      <input type="checkbox" id="formActive" name="formActive" disabled>
					    </div>
					  </div>
					  <input type="text" class="form-control form-control-sm" placeholder="Activate" readonly>
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
					<div class="col-md-12">
						<textarea class="form-control form-control-sm" id="formMemo" name="formMemo" placeholder="Memo"></textarea>
					</div>
				</div>
			</div>
			<!-- eLearning List -->
			<div class="form-group">
				<div class="form-row">
					<div class="col-md-3">
						<label for="elearningGrade" class="label-form">Grade</label> 
						<select class="form-control form-control-sm" id="elearningGrade" name="elearningGrade">
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
						<label for="" class="label-form">Select to add subject</label> <select
							class="form-control form-control-sm" id="elearingDropdown" name="elearingDropdown">
							<option value="p2">Click to add a subject</option>
						</select>
					</div>
				</div>
			</div>
			
			<div class="form-group">
				<div class="form-row">
					<div class="col-md-12">
						<table id="gradeAssociateElearningTable" style="width: 100%;" class="table-bordered table-sm">
							<thead class="table-primary">
								<tr class="small" style="height: 35px;">
									<th class="hidden-column"></th>
									<th>Grade</th>
									<th>eLearning Subject</th>
									<th>Delete</th>
								</tr>
							</thead>
							<tbody id="list-grade-associate-body">
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<input type="hidden" id="formEndDate" name="formEndDate" />
		</form>
	</div>
</div>







