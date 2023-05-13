<script>
$(document).ready(
	function() {
		$('#registerGrade').on('change',function() {
			var grade = $(this).val()
			listElearns(grade);
			listClasses(grade);
			listBooks(grade);
			listEtcs(grade);
		});
		// when page loads, search course fees for grade 'p2' as first entry
		listElearns('p2');
		listClasses('p2');
		listBooks('p2');
		listEtcs('p2');
	}
);

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Search e-Learning based on Grade	
//////////////////////////////////////////////////////////////////////////////////////////////////////
function listElearns(grade) {
	// clear 'elearnTable' table body
	$('#elearnTable tbody').empty();
	$.ajax({
		url : '${pageContext.request.contextPath}/elearning/grade',
		type : 'GET',
		data : {
			grade : grade,
		},
		success : function(data) {
			$.each(data, function(index, value) {
				const cleaned = cleanUpJson(value);
				// console.log(cleaned);
				var row = $("<tr>");
				row.append($('<td>').addClass('hidden-column').text(value.id));
				row.append($('<td>').text(value.grade.toUpperCase()));
				row.append($('<td>').text(value.name));
				row.append($("<td onclick='addToBasket(" + cleaned + ")''>").html('<a href="javascript:void(0)" title="Delete eLearning"><i class="fa fa-trash"></i></a>'));
				$('#elearnTable > tbody').append(row);
			});
		},
		error : function(xhr, status, error) {
			console.log('Error : ' + error);
		}
	});
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Search Fees based on Grade	
//////////////////////////////////////////////////////////////////////////////////////////////////////
function listClasses(grade) {
	// clear 'courseFeeTable' table body
	$('#courseFeeTable tbody').empty();
	$.ajax({
		url : '${pageContext.request.contextPath}/class/search',
		type : 'GET',
		data : {
			grade : grade,
		},
		success : function(data) {
			$.each(data, function(index, value) {
				const cleaned = cleanUpJson(value);
				//console.log(cleaned);
				var row = $("<tr onclick='displayInfo(" + cleaned + ")''>");
				var row = $('<tr>');
				row.append($('<td>').addClass('hidden-column').text(value.id));
				row.append($('<td>').text(value.description));
				row.append($('<td>').text(value.subjects));
				row.append($('<td>').text(value.fee));				
				$('#courseFeeTable > tbody').append(row);
			});
		},
		error : function(xhr, status, error) {
			console.log('Error : ' + error);
		}
	});
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Search Book based on Grade	
//////////////////////////////////////////////////////////////////////////////////////////////////////
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
//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Search Etc based on Grade	
//////////////////////////////////////////////////////////////////////////////////////////////////////
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
			$.each(data, function(index, value) {
				const cleaned = cleanUpJson(value);
				var row = $("<tr onclick='displayInfo(" + cleaned + ")''>");
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

function displayInfo(id){
	console.log(id);
}

function addToBasket(value){
	console.log(value);
	var row = $("<tr>");
	row.append($('<td>').addClass('hidden-column').text(value.id));
	row.append($('<td>').text(value.grade.toUpperCase()));
	row.append($('<td>').text(value.name));
							
				
	$('#basketTable > tbody').append(row);

	
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
								<a class="nav-item nav-link active" id="nav-basket-tab" data-toggle="tab" href="#nav-basket" role="tab" aria-controls="nav-basket" aria-selected="true">My Lecture</a>
								<a class="nav-item nav-link" id="nav-elearn-tab" data-toggle="tab" href="#nav-elearn" role="tab" aria-controls="nav-elearn" aria-selected="true">e-Learning</a>
                            	<a class="nav-item nav-link" id="nav-fee-tab" data-toggle="tab" href="#nav-fee" role="tab" aria-controls="nav-fee" aria-selected="true">Class</a>
                              	<a class="nav-item nav-link" id="nav-book-tab" data-toggle="tab" href="#nav-book" role="tab" aria-controls="nav-book" aria-selected="false">Books</a>
                              	<a class="nav-item nav-link" id="nav-etc-tab" data-toggle="tab" href="#nav-etc" role="tab" aria-controls="nav-etc" aria-selected="false">Etc</a>
                          </div>
                      </nav>
					  
                      <div class="tab-content" id="nav-tabContent">
						<!-- Lecture List -->
						<div class="tab-pane fade show active" id="nav-basket" role="tabpanel" aria-labelledby="nav-basket-tab">
							<table class="table" id="basketTable" name="basketTable">
								<thead>
									<tr>
										<th class="hidden-column"></th>
										<th>Grade</th>
										<th>Subjects</th>
										<th>Delete</th>
									</tr>
								</thead>
								<tbody>
									
								</tbody>
							</table>
						</div>
						<!-- e-Learning -->
						<div class="tab-pane fade" id="nav-elearn" role="tabpanel" aria-labelledby="nav-elearn-tab">
							<table class="table" id="elearnTable" name="elearnTable">
								<thead>
									<tr>
										<th class="hidden-column"></th>
										<th>Grade</th>
										<th>Subjects</th>
										<th>Add</th>
									</tr>
								</thead>
								<tbody>
									
								</tbody>
							</table>
						</div>
						<!-- Class -->
						<div class="tab-pane fade" id="nav-fee" role="tabpanel" aria-labelledby="nav-fee-tab">
                              <table class="table" id="courseFeeTable" name="courseFeeTable">
                                  <thead>
                                      <tr>
										  <th class="hidden-column"></th>
                                          <th>Description</th>
                                          <th>Subjects</th>
                                          <th>Price</th>
                                      </tr>
                                  </thead>
                                  <tbody>
                                      
                                  </tbody>
                              </table>
                          </div>
						  <!-- Book -->
                          <div class="tab-pane fade" id="nav-book" role="tabpanel" aria-labelledby="nav-book-tab">
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
						  <!-- Etc -->
                          <div class="tab-pane fade" id="nav-etc" role="tabpanel" aria-labelledby="nav-etc-tab">
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
			