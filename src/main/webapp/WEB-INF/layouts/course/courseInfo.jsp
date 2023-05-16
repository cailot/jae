<script>

var academicYear;
var academicWeek;

$(document).ready(
	function() {
		// make an AJAX call on page load
		// to get the academic year and week
		$.ajax({
		  url : '${pageContext.request.contextPath}/class/academy',
	      method: "GET",
	      success: function(response) {
	        // save the response into the variable
	        academicYear = response[0];
	        academicWeek = response[1];
			// console.log(response);
	      },
	      error: function(jqXHR, textStatus, errorThrown) {
	        // handle error
	      }
	    });


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

		// remove records from basket when click on delete icon
		$('#basketTable').on('click', 'a', function(e) {
			e.preventDefault();
			$(this).closest('tr').remove();
		});



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
				row.append($("<td onclick='addElearningToBasket(" + cleaned + ")''>").html('<a href="javascript:void(0)" title="Add eLearning"><i class="fa fa-plus-circle"></i></a>'));
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
				// var row = $("<tr onclick='displayInfo(" + cleaned + ")''>");
				var row = $('<tr>');
				row.append($('<td>').addClass('hidden-column').text(value.id));
				row.append($('<td>').text(value.description));
				row.append($('<td>').text(value.subjects));
				row.append($('<td>').text(value.fee));
				row.append($("<td onclick='addClassToBasket(" + cleaned + ")''>").html('<a href="javascript:void(0)" title="Add Class"><i class="fa fa-plus-circle"></i></a>'));
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
				var row = $('<tr>');
				row.append($('<td>').addClass('hidden-column').text(value.id));
				row.append($('<td>').text(value.name));
				row.append($('<td>').text(value.subjects));
				row.append($('<td>').text(value.price));
				row.append($("<td onclick='addBookToBasket(" + cleaned + ")''>").html('<a href="javascript:void(0)" title="Add Book"><i class="fa fa-plus-circle"></i></a>'));
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
				var row = $('<tr>');
				row.append($('<td>').addClass('hidden-column').text(value.id));
				row.append($('<td>').text(value.name));
				row.append($('<td>').text(value.price));
				row.append($("<td onclick='addEtcToBasket(" + cleaned + ")''>").html('<a href="javascript:void(0)" title="Add Etc"><i class="fa fa-plus-circle"></i></a>'));
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


// add elearning to basket
function addElearningToBasket(value){
	console.log(value);
	var row = $("<tr>");
	row.append($('<td>').addClass('hidden-column').text(value.id));
	row.append($('<td>').text('[' + value.grade.toUpperCase() + '] ' + value.name));
		row.append($('<td>').text('eLearning'));
	row.append($('<td>').text(academicYear));
	row.append($('<td>').text(academicWeek));
	row.append($('<td>').text(0));
	row.append($('<td>').text(0));
	row.append($("<td>").html('<a href="javascript:void(0)" title="Delete eLearning"><i class="fa fa-trash"></i></a>'));
	$('#basketTable > tbody').append(row);
}

// add class to basket
function addClassToBasket(value){
	console.log(value);
	var row = $("<tr>");
	row.append($('<td>').addClass('hidden-column').text(value.id));
	row.append($('<td>').text('[' + value.grade.toUpperCase() + '] ' + value.description));
	row.append($('<td>').text('Class'));
	row.append($('<td>').text(academicYear));
	row.append($('<td>').text(academicWeek));
	row.append($('<td>').text(0));
	row.append($('<td>').text(value.fee));
	row.append($("<td>").html('<a href="javascript:void(0)" title="Delete Class"><i class="fa fa-trash"></i></a>'));
	$('#basketTable > tbody').append(row);
}

// add book to basket
function addBookToBasket(value){
	console.log(value);
	var row = $("<tr>");
	row.append($('<td>').addClass('hidden-column').text(value.id));
	row.append($('<td>').text('[' + value.grade.toUpperCase() + '] ' + value.name));
	row.append($('<td>').text('Book'));
	row.append($('<td>').text(academicYear));
	row.append($('<td>').text(academicWeek));
	row.append($('<td>').text(0));
	row.append($('<td>').text(value.price));
	row.append($("<td>").html('<a href="javascript:void(0)" title="Delete Book"><i class="fa fa-trash"></i></a>'));
	$('#basketTable > tbody').append(row);
}

// add etc to basket
function addEtcToBasket(value){
	console.log(value);
	var row = $("<tr>");
	row.append($('<td>').addClass('hidden-column').text(value.id));
	row.append($('<td>').text(value.name));
	row.append($('<td>').text('Etc'));
	row.append($('<td>').text(academicYear));
	row.append($('<td>').text(academicWeek));
	row.append($('<td>').text(0));
	row.append($('<td>').text(value.price));
	row.append($("<td>").html('<a href="javascript:void(0)" title="Delete Etc"><i class="fa fa-trash"></i></a>'));
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
										<th>Description</th>
										<th>Item</th>
										<th>Year</th>
										<th>Start</th>
										<th>End</th>
										<th>Fee</th>
										<th>Action</th>
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
										  <th>Add</th>
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
										  <th class="hidden-column"></th>
										  <th>Description</th>
                                          <th>Subjects</th>
                                          <th>Price</th>
										  <th>Add</th>
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
										  <th class="hidden-column"></th>
										  <th>Description</th>
                                          <th>Price</th>
										  <th>Add</th>
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
			