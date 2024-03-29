<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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

















<div class="container-fluid">
  <div class="row">
	<!-- Student Info -->
    <div class="col-lg-4">
    	<div class="card-body">
      		<h5>Student Information</h5>
			<jsp:include page="student/studentInfo.jsp"></jsp:include>
		</div>
    </div>
	<div class="col-lg-8">
      	<div class="row">
			<!-- Course Info -->
			<div class="col-lg-8">
				<div class="card-body">
					<h5>Course Registration</h5>
					<jsp:include page="course/courseInfo.jsp"></jsp:include>
				</div>
			</div>
			<div class="col-lg-4 bg-secondary">
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
      		<div class="col-lg-12">
      			<div class="card-body">
					<jsp:include page="invoice/invoiceInfo.jsp"></jsp:include>
      			</div>
      		</div>
      	</div>     		
    	</div>
    </div>
 </div>








