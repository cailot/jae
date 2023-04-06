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
			<div class="modal-body"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- No Keyword Modal -->
<div class="modal fade" id="warning-alert" tabindex="-1"
	aria-labelledby="successModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="successModalLabel">Warning</h5>
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




<!-- Students List Modal -->
<div class="modal fade" id="studentListResult" tabindex="-1"
	role="dialog" aria-labelledby="studentListLabel">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="studentListLabel">Student List</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<table class="table table-striped" id="studentListResultTable">
					<thead>
						<tr>
							<th>ID</th>
							<th>First Name</th>
							<th>Last Name</th>
							<th>Grade</th>
							<th>Start Date</th>
							<th>End Date</th>
							<th>Email</th>
							<th>Contact No 1</th>
							<th>Contact No 2</th>
							<th>Address</th>
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






<!-- Register Form Dialogue -->
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
								<label for="datepicker">Enrolment</label> <input type="text"
									class="form-control datepicker" id="addEnrolment"
									name="addEnrolment" placeholder="dd/mm/yyyy">
							</div>
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






<div class="row">
	<div class="col-md-4">
		<div class="card mb-4 shadow-sm">

			<div class="card-body">
				<!-- <h4 class="card-title">Student Information</h4> -->
				<div class="d-flex justify-content-between align-items-center">
					<div>
						<ul class="nav nav-tabs">
							<li class="nav-item"><a class="nav-link active"
								data-toggle="tab" href="#admin">Student Administration</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab"
								href="#list">Student List</a></li>
						</ul>
						<div class="tab-content">
							<div id="admin" class="tab-pane fade show active">
								<jsp:include page="student/admin.jsp"></jsp:include>
							</div>
							<div id="list" class="tab-pane fade">
								<jsp:include page="student/list.jsp"></jsp:include>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
	<div class="col-md-5">
		<div class="card mb-4 shadow-sm">
			<img class="card-img-top" src="https://via.placeholder.com/300x200"
				alt="Card image cap">
			<div class="card-body">
				<h4 class="card-title">Card title</h4>
				<p class="card-text">This is a longer card with supporting text
					below as a natural lead-in to additional content. This content is a
					little bit longer.</p>
				<div class="d-flex justify-content-between align-items-center">
					<div class="btn-group">
						<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
						<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
					</div>
					<small class="text-muted">9 mins</small>
				</div>
			</div>
		</div>
	</div>
	<div class="col-md-3">
		<div class="card mb-4 shadow-sm">
			<img class="card-img-top" src="https://via.placeholder.com/300x200"
				alt="Card image cap">
			<div class="card-body">
				<h4 class="card-title">Card title</h4>
				<p class="card-text">This is a longer card with supporting text
					below as a natural lead-in to additional content. This content is a
					little bit longer.</p>
				<div class="d-flex justify-content-between align-items-center">
					<div class="btn-group">
						<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
						<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
					</div>
					<small class="text-muted">9 mins</small>
				</div>
			</div>
		</div>
	</div>
</div>