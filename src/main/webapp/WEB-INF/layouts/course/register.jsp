<script>
$(document).ready(
	function() {
		$('#registerGrade').on('change',function() {
			var grade = $(this).val()
			//listFees(grade);
			listBooks(grade);
			//listEtcs(grade);
		});
		
		// $('#gradeAssociateElearningTable').on('click', 'a', function() {
	    // 	var row = $(this).closest('tr');
	    // 	var name = row.find('td:eq(1)').text();
	    //   	if (confirm('Are you sure you want to remove ' + name + '?')) {
	    //     row.remove();
      	// }
    	// });
});
	
//Search Fees based on Grade	
function listFees(grade) {
	// clear 'courseFeeTable' table body
	$('#courseFeeTable tbody').empty();
	$.ajax({
		url : '${pageContext.request.contextPath}/courseFee/listGrade',
		type : 'GET',
		data : {
			grade : grade,
		},
		success : function(data) {
			/* console.log('search - ' + data + ' , ' + grade);
			if (data == '') {
				$('#warning-alert .modal-body').text(
						'No fee found with ' + $("#formKeyword").val());
				$('#warning-alert').modal('show');
				return;
			} */
			$.each(data, function(index, value) {
				//var row = $("<tr onclick='displayStudentInfo(" + JSON.stringify(value) + ")''>");
				var row = $('<tr>');
				row.append($('<td>').text(value.name));
				row.append($('<td>').text(value.subjects));
				row.append($('<td>').text(value.price));				
				$('#courseFeeTable > tbody').append(row);
			});
			//$('#studentListResult').modal('show');
 
		},
		error : function(xhr, status, error) {
			console.log('Error : ' + error);
		}
	});
}

//Search Book based on Grade	
function listBooks(grade) {
	// clear 'courseBookTable' table body
	$('#courseBookTable tbody').empty();
	$.ajax({
		url : '${pageContext.request.contextPath}/book/listGrade',
		type : 'GET',
		data : {
			grade : grade,
		},
		success : function(data) {
			$.each(data, function(index, value) {
				const cleaned = cleanUpJson(value);
				var row = $("<tr onclick='displayInfo(" + cleaned + ")''>");
				row.append($('<td>').text(value.name));
				row.append($('<td>').text(value.subjects));
				row.append($('<td>').text(value.price));
				$('#courseBookTable > tbody').append(row);
			});
		},
		error : function(xhr, status, error) {
			console.log('Error : ' + error);
		}
	});
}

//Search Etc based on Grade	
function listEtcs(grade) {
	// clear 'courseEtcTable' table body
	$('#courseEtcTable tbody').empty();
	$.ajax({
		url : '${pageContext.request.contextPath}/courseEtc/list',
		type : 'GET',
		data : {
			grade : grade,
		},
		success : function(data) {
			/* console.log('search - ' + data + ' , ' + grade);
			if (data == '') {
				$('#warning-alert .modal-body').text(
						'No fee found with ' + $("#formKeyword").val());
				$('#warning-alert').modal('show');
				return;
			} */
			$.each(data, function(index, value) {
				//var row = $("<tr onclick='popup(" + value.id + ")''>");
				//row.append($('<td>').text(value.id));
				//row.append($('<td>').text(value.grade.toUpperCase()));
				var row = $('<tr>');
				row.append($('<td>').text(value.name));
				row.append($('<td>').text(value.price));				
				
				$('#courseEtcTable > tbody').append(row);
			});
		},
		error : function(xhr, status, error) {
			console.log('Error : ' + error);
		}
	});
}

// clean up any single quote escape charater in Json
function cleanUpJson(obj){
	const jsonString = JSON.stringify(obj, (key, value) => {
  		// If the value is a string, remove escape characters from it
  		if (typeof value === 'string') {
    		return value.replace(/\\/g, '');
  		}
  			return value;
	});
	return jsonString;
}

function displayInfo(id){
	console.log(id);
}


</script>

<h5>Course Registration</h5>
<div class="modal-body">
	<form id="">
		<div class="form-group">
			<div class="form-row">
				<div class="col-md-3">
					<select class="form-control form-control-sm" id="registerGrade" name="registerGrade">
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
				<div class="col-md-7">
					<p class="text-truncate">Class change is possible after changing Please click
						Apply button</p>
				</div>
				<div class="col-md-2">
					<button type="button" class="btn btn-block btn-primary btn-sm"
						data-toggle="modal" data-target="#registerModal">Apply</button>
				</div>
			</div>
		</div>
		<div class="form-group">
			<div class="form-row">
				<div class="col-md-12">
					<nav>
                          <div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
                              <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Fees</a>
                              <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">Books</a>
                              <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">Etc</a>
                          </div>
                      </nav>
                      <div class="tab-content" id="nav-tabContent">
                          <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                              <table class="table" id="courseFeeTable" name="courseFeeTable">
                                  <thead>
                                      <tr>
                                          <!-- <th>Abb.</th> -->
                                          <th>Description</th>
                                          <th>Subjects</th>
                                          <th>Price</th>
                                      </tr>
                                  </thead>
                                  <tbody>
                                      
                                  </tbody>
                              </table>
                          </div>
                          <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                              <table class="table" cellspacing="0" id="courseBookTable" name="courseBookTable">
                                  <thead>
                                      <tr>
                                          <th>Description</th>
                                          <th>Subjects</th>
                                          <th>Price</th>
                                      </tr>
                                  </thead>
                                  <tbody>
                                  </tbody>
                              </table>
                          </div>
                          <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
                              <table class="table" cellspacing="0" id="courseEtcTable" name="courseEtcTable">
								<thead>
                                      <tr>
                                          <th>Description</th>
                                          <th>Price</th>
                                      </tr>
                                  </thead>
                                  <tbody>
                                  </tbody>                                  
                              </table>
                          </div>
                      </div>
                   				
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
				</div>
			</div>
		</div>
	</form>
</div>
			