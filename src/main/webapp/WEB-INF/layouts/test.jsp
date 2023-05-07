<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="hyung.jin.seo.jae.dto.StudentDTO"%>
<!-- <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.21.4/dist/bootstrap-table.min.css">
<script src="https://unpkg.com/bootstrap-table@1.21.4/dist/bootstrap-table.min.js"></script> -->
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


<!-- Success Alert -->
<div id="success-alert" class="modal fade">
	<div class="modal-dialog">
		<div class="alert alert-block alert-success alert-dialog-display">
			<i class="fa fa-check-circle fa-2x"></i>&nbsp;&nbsp;<div class="modal-body"></div>
			<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
		</div>
	</div>
</div>

<!-- Warning Alert -->
<div id="warning-alert" class="modal fade">
	<div class="modal-dialog">
		<div class="alert alert-block alert-warning alert-dialog-display">
			<i class="fa fa-exclamation-circle fa-2x"></i>&nbsp;&nbsp;<div class="modal-body"></div>
			<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
		</div>
	</div>
</div>





<!-- Delete Alert -->
<div id="confirm-alert" class="modal fade" >
    <div class="modal-dialog">
    	<div class="alert alert-block alert-danger">
    		<div class="alert-dialog-display">
    			<i class="fa fa-minus-circle fa-2x"></i>&nbsp;&nbsp;<div class="modal-body"></div>
    		</div>
			<div style="text-align: right;">
				<button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Cancel</button>
				<button type="button" class="btn btn-sm btn-danger" id="deactivateAction">Delete</button>
			</div>
		</div>
    </div>
</div>












<div class="modal fade" id="studentListResult">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-body table-wrap">
				<table class="table table-striped" id="studentListResultTable" data-header-style="headerStyle">
					<thead class="table-primary">
						<tr>
							<th data-field="id">ID</th>
							<th data-field="firstname">First Name</th>
							<th data-field="lastname">Last Name</th>
							<th data-field="grade">Grade</th>
							<th data-field="startdate">Start Date</th>
							<th data-field="enddate">End Date</th>
							<th data-field="email">Email</th>
							<th data-field="contact1">Contact No 1</th>
							<th data-field="contact2">Contact No 2</th>
							<th data-field="address">Address</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
			
			
			<style>
			.search-list {
			  font-size : 1.5rem;
			}
			</style>			
			<script>
			  function headerStyle(column) {
			    return {
			      id: {
			        classes : 'search-list'
			      },
			      firstname: {
			    	classes : 'search-list'
			      },
			      lastname: {
			    	classes : 'search-list'
			      },
			      grade: {
			    	classes : 'search-list'
			      },
			      startdate: {
				   	classes : 'search-list'
				  },
			      enddate: {
			    	classes : 'search-list'
			      },
			      email: {
			    	classes : 'search-list'
			      },
			      contact1: {
			    	classes : 'search-list'
			      },
			      contact2: {
			    	classes : 'search-list'
			      },
			      address: {
			      	classes : 'search-list'
			      }
			    }[column.field]
			  }
			</script>			
			
			
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>











<div class="container-fluid">
  <div class="row">
    <div class="col-lg-4">
      <div class="card-body">
      	<h5>Student Information</h5>
				<jsp:include page="student/admin.jsp"></jsp:include>
			</div>
      </div>
	<div class="col-lg-8 bg-warning">
      	<div class="row">
			<div class="col-lg-8 bg-warning">
			<div class="card-body">
				<jsp:include page="course/register.jsp"></jsp:include>
			 </div>
			</div>
			<div class="col-lg-4 bg-success">
			 <div class="card-body">
			 <h5 class="card-title">Attendance</h5>
				<div class="modal-body">
					<form id="">
						<div class="form-group">
							<div class="form-row">
								<textarea class="form-control" rows="15"></textarea>
							</div>
						</div>
					</form>
				</div>
			 </div>
			</div>
      	</div>
      	<div class="row">
      		<div class="col-lg-12 bg-primary">
      		<div class="card-body">
      				<form>
						<div class="form-group">
							<div class="form-row">
								<div class="col-md-6">
									<p>Receivable Amt: 740.00 OUtstanding: 0.00</p>
								</div>
								<div class="col md-auto">
									<button type="button" class="btn btn-block btn-primary btn-sm"
										data-toggle="modal" data-target="#registerModal">Payment</button>
								</div>
								<div class="col md-auto">
									<button type="button" class="btn btn-block btn-primary btn-sm"
										onclick="updateStudentInfo()">Invoice</button>
								</div>
								<div class="col md-auto">
									<button type="button" class="btn btn-block btn-primary btn-sm"
										onclick="inactivateStudent()">Email</button>
								</div>

								<div class="col md-auto">
									<button type="button" class="btn btn-block btn-primary btn-sm"
										onclick="ntForm()">Record</button>
								</div>

							</div>
						</div>
						<div class="form-group">
							<div class="form-row">
								<textarea class="form-control" rows="8"></textarea>
							</div>
						</div>
					</form>
      			</div>
      		</div>
      	</div>     		
    	</div>
    </div>
 </div>








