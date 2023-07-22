<script>

var academicYear;
var academicWeek;

const ENROLMENT = 'enrolment';
const ELEARNING = 'eLearning';
const CLASS = 'class';
const BOOK = 'book';
const ETC = 'etc';

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
			var grade = $(this).val();
			//console.log(grade);
			listElearns(grade);
			listCourses(grade);
			listBooks(grade);
			// listEtcs(grade);
		});
		
		// when page loads, search course fees for grade 'p2' as first entry --> No need as there is no student selected yet
		// listElearns('p2');
		// listCourses('p2');
		// listBooks('p2');
		// listEtcs('p2');

		// remove records from basket when click on delete icon
		$('#basketTable').on('click', 'a', function(e) {
			e.preventDefault();
			$(this).closest('tr').remove();
			showAlertMessage('deleteAlert', '<center><i class="bi bi-trash"></i> &nbsp;&nbsp Item is now removed from My Lecture</center>');
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
				var row = $("<tr class='d-flex'>");
				row.append($('<td>').addClass('hidden-column').text(value.id));
				row.append($('<td class="col-1"><i class="bi bi-laptop" title="e-learning"></i></td>'));
				row.append($('<td class="smaller-table-font text-center col-1">').text(value.grade.toUpperCase()));
				row.append($('<td class="smaller-table-font col-9" style="padding-left: 20px;">').text(value.name));
				row.append($("<td onclick='addElearningToBasket(" + cleaned + ")''>").html('<a href="javascript:void(0)" title="Add eLearning"><i class="bi bi-plus-circle"></i></a>'));
				$('#elearnTable > tbody').append(row);
			});
		},
		error : function(xhr, status, error) {
			console.log('Error : ' + error);
		}
	});
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Search Course based on Grade	
//////////////////////////////////////////////////////////////////////////////////////////////////////
function listCourses(grade) {
	// clear 'courseTable' table body
	$('#courseTable tbody').empty();
	$.ajax({
		url : '${pageContext.request.contextPath}/class/coursesByGrade',
		type : 'GET',
		data : {
			grade : grade,
		},
		success : function(data) {
			$.each(data, function(index, value) {
				const cleaned = cleanUpJson(value);
				// console.log(cleaned);
				var row = $('<tr class="d-flex">');
				row.append($('<td>').addClass('hidden-column').text(value.id));
				row.append($('<td class="col-1"><i class="bi bi-mortarboard" title="class"></i></td>'));
				row.append($('<td class="smaller-table-font col-5" style="padding-left: 20px;">').text(value.description));
				row.append($('<td class="smaller-table-font col-4">').text(addSpace(JSON.stringify(value.subjects))));
				row.append($('<td class="smaller-table-font col-1 text-right pr-1">').text(Number(value.price).toFixed(2)));
				row.append($("<td class='col-1' onclick='addClassToBasket(" + cleaned + ")''>").html('<a href="javascript:void(0)" title="Add Class"><i class="bi bi-plus-circle"></i></a>'));
				$('#courseTable > tbody').append(row);
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
	// clear 'bookTable' table body
	$('#bookTable tbody').empty();
	$.ajax({
		url : '${pageContext.request.contextPath}/book/listGrade',
		type : 'GET',
		data : {
			grade : grade,
		},
		success : function(data) {
			$.each(data, function(index, value) {
				const cleaned = cleanUpJson(value);
				// console.log(cleaned);
				var row = $('<tr class="d-flex">');
				row.append($('<td>').addClass('hidden-column').text(value.id));
				row.append($('<td class="col-1"><i class="bi bi-book" title="book"></i></td>'));
				row.append($('<td class="smaller-table-font col-5">').text(value.name));
				row.append($('<td class="smaller-table-font col-4">').text(addSpace(JSON.stringify(value.subjects))));
				row.append($('<td class="smaller-table-font col-1 text-right pr-1">').text(Number(value.price).toFixed(2)));
				//row.append($("<td class='col-1' onclick='addBookToInvoice(" + cleaned + ")''>").html('<a href="javascript:void(0)" title="Add Book"><i class="bi bi-plus-circle"></i></a>'));
				row.append($("<td class='col-1' onclick='addBookToBasket(" + cleaned + ")''>").html('<a href="javascript:void(0)" title="Add Book"><i class="bi bi-plus-circle"></i></a>'));
				$('#bookTable > tbody').append(row);
			});
		},
		error : function(xhr, status, error) {
			console.log('Error : ' + error);
		}
	});
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Associate eLearnings with Student	
//////////////////////////////////////////////////////////////////////////////////////////////////////
function associateOnline(){
	// get id from 'formId'
	const studentId = $('#formId').val();
	// if id is null, show alert and return
	if (studentId == null || studentId == '') {
		//warn if student id  is empty
		$('#warning-alert .modal-body').text('Please search student before apply');
		$('#warning-alert').modal('toggle');
		return;	
	}

	var elearnings = [];
	var enrolData = [];
	var books = [];

	$('#basketTable tbody tr').each(function() {
		// in case of update, enrolId is not null
		//debugger;
		var enrolId = null;
		var bookId = null;
		var hiddens = $(this).find('.data-type').text();
		if(hiddens.indexOf('|') !== -1){
			var hiddenValues = hiddens.split('|');
			// if hiddenValues[0] is ELEARNING, push hiddenValues[1] to elearnings array
			if(hiddenValues[0] === ELEARNING){
				elearnings.push(hiddenValues[1]);
				// how to jump to next <tr>
				return true;
			}else if(hiddenValues[0] === BOOK){
				books.push(hiddenValues[1]);
				return true;
			}else if(hiddenValues[0] === CLASS){
				enrolId = hiddenValues[1];
			}
		}
		enrolData.clazzId =  $(this).find('.clazzChoice').val();
		// find value of next td whose class is 'start-year'
		enrolData.startWeek = $(this).find('.start-week').text();
		enrolData.endWeek = $(this).find('.end-week').text();
		var clazz = {
			"id" : enrolId,
			"startWeek" : enrolData.startWeek,
			"endWeek" : enrolData.endWeek,
			"clazzId" : enrolData.clazzId
		};
		enrolData.push(clazz);
		// how to jump to next <tr>				
		return true;	
	});

	var elearningData = elearnings.map(function(id) {
    	return parseInt(id);
	});
	var bookData = books.map(function(id){
		return parseInt(id);
	});


	// Make the AJAX enrolment for eLearning
	$.ajax({
		url: '${pageContext.request.contextPath}/student/associateElearning/' + studentId,
		method: 'POST',
		data: JSON.stringify(elearningData),
		contentType: 'application/json',
		success: function(response) {
			// Handle the response
			// console.log(response);
		},
		error: function(xhr, status, error) {
			// Handle the error
			console.error(error);
		}
	});

	// Make the AJAX enrolment for class
	$.ajax({
		url: '${pageContext.request.contextPath}/student/associateClazz/' + studentId,
		method: 'POST',
		data: JSON.stringify(enrolData),
		contentType: 'application/json',
		success: function(response) {

			$.each(response, function(index, value){
				// update the invoice table
				// console.log(value);
				retrieveInvoiceListTable(value);
			});
	

			// nested ajax for book after creating or updating invoice
			// Make the AJAX enrolment for book
			$.ajax({
				url: '${pageContext.request.contextPath}/student/associateBook/' + studentId,
				method: 'POST',
				data: JSON.stringify(bookData),
				contentType: 'application/json',
				success: function(response) {
					// Handle the response
					$.each(response, function(index, value){
						//addBookToInvoice(value);
						addBookToInvoiceListTable(value);
					});
				},
				error: function(xhr, status, error) {
					// Handle the error
					console.error(error);
				}
			});

			// Handle the response
			// console.log(response);
			$('#success-alert .modal-body').html('ID : <b>' + studentId + '</b> enrolment saved successfully');
			$('#success-alert').modal('toggle');
		},
		error: function(xhr, status, error) {
			// Handle the error
			console.error(error);
		}
	});

	
	// // Make the AJAX enrolment for book
	// $.ajax({
	// 	url: '${pageContext.request.contextPath}/student/associateBook/' + studentId,
	// 	method: 'POST',
	// 	data: JSON.stringify(bookData),
	// 	contentType: 'application/json',
	// 	success: function(response) {
	// 		// Handle the response
	// 		console.log(response);
	// 	},
	// 	error: function(xhr, status, error) {
	// 		// Handle the error
	// 		console.error(error);
	// 	}
	// });


}


//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Add elearning to basket
//////////////////////////////////////////////////////////////////////////////////////////////////////
function addElearningToBasket(value){
	// console.log(value);
	var row = $("<tr class='d-flex'>");
	row.append($('<td>').addClass('hidden-column').addClass('data-type').text(ELEARNING + '|' + value.id));
	row.append($('<td class="col-1"><i class="bi bi-laptop" title="e-learning"></i></td>'));
	row.append($('<td class="smaller-table-font col-10" colspan="6">').text('[' + value.grade.toUpperCase() + '] ' + value.name));
	row.append($("<td class='col-1'>").html('<a href="javascript:void(0)" title="Delete eLearning"><i class="bi bi-trash"></i></a>'));
	// $('#basketTable > tbody').append(row);
	$('#basketTable > tbody').prepend(row);

	// Automatically dismiss the alert after 2 seconds
	showAlertMessage('addAlert', '<center><i class="bi bi-laptop"></i> &nbsp;&nbsp' + value.name +' added to My Lecture</center>');
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Add class to basket
//////////////////////////////////////////////////////////////////////////////////////////////////////
function addClassToBasket(value) {
  $.ajax({
    url: '${pageContext.request.contextPath}/class/classesByCourse',
    type: 'GET',
    data: {
      courseId: value.id,
      year: value.year
    },
    success: function(data) {
		var start_week, end_week, weeks;
		
		if (value.year == academicYear) {
			start_week = parseInt(academicWeek);
			end_week = parseInt(academicWeek) + 9;

			if (end_week >= 49) {
			end_week = 49;
			}
			weeks = (end_week - start_week) + 1;
		} else {
			start_week = 1;
			end_week = 10;
			weeks = (end_week - start_week) + 1;
		}
      
		var row = $('<tr class="d-flex">');
		row.append($('<td class="col-1"><i class="bi bi-mortarboard" title="class"></i></td>'));
		row.append($('<td class="smaller-table-font col-4">').text('[' + value.grade.toUpperCase() + '] '+ value.description));
		// Create a dropdown list for value.day and id is option value
		var dropdown = $('<select class="clazzChoice">');
		$.each(data, function(index, clazz) {
			dropdown.append($('<option>').text(clazz.day).val(clazz.id));
		});
		row.append($('<td class="smaller-table-font col-2">').append(dropdown));
		row.append($('<td class="smaller-table-font col-1">').text(value.year));
		row.append($('<td class="smaller-table-font col-1 text-center" contenteditable="true">').addClass('start-week').text(start_week));
		row.append($('<td class="smaller-table-font col-1 text-center" contenteditable="true">').addClass('end-week').text(end_week));
		row.append($('<td class="smaller-table-font col-1 text-center" contenteditable="true">').addClass('weeks').text(weeks));
		row.append($('<td class="col-1">').html('<a href="javascript:void(0)" title="Delete Class"><i class="bi bi-trash"></i></a>'));
		
		var startWeekCell = row.find('.start-week');
		var endWeekCell = row.find('.end-week');
		var weeksCell = row.find('.weeks');
		
		function updateWeeks() {
		start_week = parseInt(startWeekCell.text());
		end_week = parseInt(endWeekCell.text());
		weeks = (end_week - start_week) + 1;
		weeksCell.text(weeks);
		}
		
		function updateEndWeek() {
		start_week = parseInt(startWeekCell.text());
		weeks = parseInt(weeksCell.text());
		end_week = start_week + weeks - 1;
		endWeekCell.text(end_week);
		}
		
		startWeekCell.on('input', function() {updateWeeks();});
		endWeekCell.on('input', function() {updateWeeks();});
		weeksCell.on('input', function() {updateEndWeek();});
		
		// $('#basketTable > tbody').append(row);
		$('#basketTable > tbody').prepend(row);
		
		showAlertMessage('addAlert', '<center><i class="bi bi-mortarboard"></i> &nbsp;&nbsp' + value.description + ' added to My Lecture</center>');
    }
  });
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Add book to basket
//////////////////////////////////////////////////////////////////////////////////////////////////////
function addBookToBasket(value){
	var row = $('<tr class="d-flex">');
	row.append($('<td>').addClass('hidden-column').addClass('data-type').text(BOOK + '|' + value.id)); // 0
	row.append($('<td class="col-1"><i class="bi bi-book" title="book"></i></td>')); // item
	row.append($('<td class="smaller-table-font col-10 name" colspan="6">').text(value.name)); // description
	row.append($('<td class="smaller-table-font">').addClass('hidden-column').addClass('fee').text(value.price)); // price
	row.append($("<td class='col-1'>").html('<a href="javascript:void(0)" title="Delete Class"><i class="bi bi-trash"></i></a>')); // Action
	//$('#basketTable > tbody').append(row);
	$('#basketTable > tbody').prepend(row);
	// Automatically dismiss the alert after 2 seconds
	showAlertMessage('addAlert', '<center><i class="bi bi-book"></i> &nbsp;&nbsp' + value.name +' added to My Lecture</center>');
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Add book to invoice
//////////////////////////////////////////////////////////////////////////////////////////////////////
// function addBookToInvoice(value){
// 	var row = $('<tr>');
// 	row.append($('<td>').addClass('hidden-column').addClass('data-type').text(BOOK + '|' + value.id)); // 0
// 	row.append($('<td class="text-center"><i class="bi bi-book" title="book"></i></td>')); // item
// 	row.append($('<td class="smaller-table-font" colspan="5">').text(value.name)); // description
// 	row.append($('<td class="smaller-table-font" colspan="4">').addClass('fee').text(Number(value.price).toFixed(2)));// price
// 	row.append($('<td class="smaller-table-font text-center">').addClass('amount').text(Number(value.price).toFixed(2)));// Total
// 	row.append($('<td class="smaller-table-font">').text('0'));// Date
// 	row.append($("<td class='col-1'>").html('<a href="javascript:void(0)" title="Delete Class"><i class="bi bi-trash"></i></a>')); // Action
// 	//$('#invoiceListTable > tbody').append(row);
// 	$('#invoiceListTable > tbody').prepend(row);

// 	// Automatically dismiss the alert after 2 seconds
// 	showAlertMessage('addAlert', '<center><i class="bi bi-book"></i> &nbsp;&nbsp' + value.name +' added to My Lecture</center>');
// }

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Retrieve Enroloment & Update Invoice Table
//////////////////////////////////////////////////////////////////////////////////////////////////////
function retrieveEnrolment(studentId){
	// get the enrolment
	$.ajax({
		url: '${pageContext.request.contextPath}/enrolment/search/student/' + studentId,
		method: 'GET',
		success: function(response) {
			// Handle the response
			$.each(response, function(index, value){
				
				//debugger;
				// It is an EnrolmentDTO object		
				if (value.hasOwnProperty('extra')) {
					// update my lecture table
					var row = $('<tr class="d-flex">');
					row.append($('<td>').addClass('hidden-column').addClass('data-type').text(CLASS + '|' + value.id));
					row.append($('<td class="col-1"><i class="bi bi-mortarboard" title="class"></i></td>'));
					row.append($('<td class="smaller-table-font col-4">').text('[' + value.grade.toUpperCase() +'] ' + value.name));
					row.append($('<td class="smaller-table-font col-2">').text(value.day));
					row.append($('<td class="smaller-table-font col-1">').text(value.year));
					row.append($('<td class="smaller-table-font col-1 text-center" contenteditable="true">').addClass('start-week').text(value.startWeek));
					row.append($('<td class="smaller-table-font col-1 text-center" contenteditable="true">').addClass('end-week').text(value.endWeek));
					row.append($('<td class="smaller-table-font col-1 text-center" contenteditable="true">').text(value.endWeek - value.startWeek + 1));
					row.append($("<td class='col-1'>").html('<a href="javascript:void(0)" title="Delete Class"><i class="bi bi-trash"></i></a>'));
					$('#basketTable > tbody').append(row);	
					// update invoice table with Enrolment
					retrieveInvoiceListTable(value);
				} else if (value.hasOwnProperty('remaining')) { // It is an OutstandingDTO object
					// update invoice table with Outstanding
					addOutstandingToInvoiceListTable(value);
				}else{  // Book
					// update my lecture table
					var row = $('<tr class="d-flex">');
					row.append($('<td>').addClass('hidden-column').addClass('data-type').text(BOOK + '|' + value.id)); // 0
					row.append($('<td class="col-1"><i class="bi bi-book" title="book"></i></td>')); // item
					row.append($('<td class="smaller-table-font col-10">').text(value.name)); // description
					row.append($("<td class='col-1'>").html('<a href="javascript:void(0)" title="Delete Class"><i class="bi bi-trash"></i></a>')); // Action
					$('#basketTable > tbody').append(row);
					// update invoice table with Book
					addBookToInvoiceListTable(value);
				}
			});
		},
		error: function(xhr, status, error) {
			// Handle the error
			console.error(error);
		}
	});
	// get the elearning
	$.ajax({
		url: '${pageContext.request.contextPath}/elearning/search/student/' + studentId,
		method: 'GET',
		success: function(response) {
			// Handle the response
			$.each(response, function(index, value){
				// console.log(value);	
				var row = $("<tr class='d-flex'>");
				row.append($('<td>').addClass('hidden-column').addClass('data-type').text(ELEARNING + '|' + value.id));
				row.append($('<td class="col-1"><i class="bi bi-laptop" title="e-learning"></i></td>'));
				row.append($('<td class="smaller-table-font col-10" colspan="6">').text('[' + value.grade.toUpperCase() +'] ' + value.name));
				// row.append($('<td class="smaller-table-font">').text(''));
				// row.append($('<td class="smaller-table-font">').text(''));
				// row.append($('<td class="smaller-table-font">').text(''));
				row.append($("<td class='col-1'>").html('<a href="javascript:void(0)" title="Delete Class"><i class="bi bi-trash"></i></a>'));
				$('#basketTable > tbody').append(row);	

			});
		},
		error: function(xhr, status, error) {
			// Handle the error
			console.error(error);
		}
	});
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Clean basketTable
//////////////////////////////////////////////////////////////////////////////////////////////////////
function clearEnrolmentBasket(){
	$('#basketTable > tbody').empty();
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Display Subject List
//////////////////////////////////////////////////////////////////////////////////////////////////////
function addSpace(str) {
  if(!str.match(/[\[\]"]/gi)) { // check if str contains '[', ']', or "
    return str; // if not, return original str
  } else {
    str = str.replace(/[\[\]"]/gi, ''); // remove '[', ']', "" from JSON.stringify
    return str.replace(/,/g, ', '); // Use regex expression to replace commas with commas and space
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Pop-up simple toast message
//////////////////////////////////////////////////////////////////////////////////////////////////////
function showAlertMessage(elementId, message) { 
	document.getElementById(elementId).innerHTML = message; 
	$("#" + elementId).fadeTo(2000, 500).slideUp(500, 
		function(){ 
			$("#" + elementId).slideUp(500); 
		}
	);
}
</script>

<div class="modal-body">
	<form id="courseRegister">
		<div class="form-group">
			<div class="form-row">
				<div class="col-md-2">
					<select class="form-control form-control-sm" id="registerGrade" name="registerGrade">
						<option>Grade</option>
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
				<div class="col-md-8">
					<p class="text-truncate text-center">To apply, please click on the Enrolment button</p>
				</div>
				<div class="col-md-2">
					<button type="button" class="btn btn-block btn-primary btn-sm" data-toggle="modal" onclick="associateOnline()">Enrolment</button>
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
                            	<a class="nav-item nav-link" id="nav-fee-tab" data-toggle="tab" href="#nav-fee" role="tab" aria-controls="nav-fee" aria-selected="true">Course</a>
                              	<a class="nav-item nav-link" id="nav-book-tab" data-toggle="tab" href="#nav-book" role="tab" aria-controls="nav-book" aria-selected="false">Books</a>
                              	<!-- <a class="nav-item nav-link" id="nav-etc-tab" data-toggle="tab" href="#nav-etc" role="tab" aria-controls="nav-etc" aria-selected="false">Etc</a> -->
                          </div>
                      </nav>
					  
                      <div class="tab-content" id="nav-tabContent">
						<!-- Lecture List -->
						<div class="tab-pane fade show active" id="nav-basket" role="tabpanel" aria-labelledby="nav-basket-tab">
							<table class="table" id="basketTable" name="basketTable">
								<thead>
									<tr class="d-flex">
										<th class="hidden-column"></th>
										<th class="smaller-table-font col-1">Item</th>
										<th class="smaller-table-font col-4">Description</th>
										<th class="smaller-table-font col-2">Day</th>
										<th class="smaller-table-font col-1">Year</th>
										<th class="smaller-table-font col-1">Start</th>
										<th class="smaller-table-font col-1">End</th>
										<th class="smaller-table-font col-1">Week</th>
										<th class="smaller-table-font col-1"></th>
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
									<tr class="d-flex">
										<th class="hidden-column"></th>
										<th class="smaller-table-font col-1">Item</th>
										<th class="smaller-table-font col-1">Grade</th>
										<th class="smaller-table-font col-9" style="padding-left: 20px;">Subjects</th>
										<th class="col-1"></th>
									</tr>
								</thead>
								<tbody>
									
								</tbody>
							</table>
						</div>
						<!-- Course -->
						<div class="tab-pane fade" id="nav-fee" role="tabpanel" aria-labelledby="nav-fee-tab">
                              <table class="table" id="courseTable" name="courseTable">
                                  <thead>
                                      <tr class="d-flex">
										  <th class="hidden-column"></th>
										  <th class="smaller-table-font col-1">Item</th>
                                          <th class="smaller-table-font col-5" style="padding-left: 20px;">Name</th>
                                          <th class="smaller-table-font col-4" style="padding-left: 20px;">Subjects</th>
										  <th class="smaller-table-font col-1">Price</th>
										  <th class="smaller-table-font col-1"></th>
                                      </tr>
                                  </thead>
                                  <tbody>
                                      
                                  </tbody>
                              </table>
                          </div>
						  <!-- Book -->
                          <div class="tab-pane fade" id="nav-book" role="tabpanel" aria-labelledby="nav-book-tab">
                              <table class="table" cellspacing="0" id="bookTable" name="bookTable">
                                  <thead>
                                      <tr class="d-flex">
										  <th class="hidden-column"></th>
										  <th class="smaller-table-font col-1">Item</th>
										  <th class="smaller-table-font col-5" style="padding-left: 20px;">Description</th>
                                          <th class="smaller-table-font col-4" style="padding-left: 20px;">Subjects</th>
                                          <th class="smaller-table-font col-1">Price</th>
										  <th class="smaller-table-font col-1"></th>
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





<!-- Bootstrap Alert (Hidden by default) -->
<div id="addAlert" class="alert alert-info alert-dismissible fade" role="alert">
	This is an alert that pops up when the user clicks the 'OK' button.
</div>
<div id="deleteAlert" class="alert alert-danger alert-dismissible fade" role="alert">
	This is an alert that pops up when the user clicks the 'OK' button.
</div>


<!-- Bootstrap Editable Table JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.21.4/bootstrap-table.min.js"></script>
    
		