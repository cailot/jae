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
				row.append($('<td class="col-1"><i class="fa fa-laptop" title="e-learning"></i></td>'));
				row.append($('<td class="smaller-table-font text-center col-1">').text(value.grade.toUpperCase()));
				row.append($('<td class="smaller-table-font col-9" style="padding-left: 20px;">').text(value.name));
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
//		Search Course based on Grade	
//////////////////////////////////////////////////////////////////////////////////////////////////////
function listCourses(grade) {
	// clear 'courseFeeTable' table body
	$('#courseFeeTable tbody').empty();
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
				row.append($('<td class="col-1"><i class="fa fa-graduation-cap" title="class"></i></td>'));
				row.append($('<td class="smaller-table-font col-5" style="padding-left: 20px;">').text(value.description));
				row.append($('<td class="smaller-table-font col-4">').text(addSpace(JSON.stringify(value.subjects))));
				row.append($('<td class="smaller-table-font col-1 text-right pr-1">').text(Number(value.price).toFixed(2)));
				row.append($("<td class='col-1' onclick='addClassToBasket(" + cleaned + ")''>").html('<a href="javascript:void(0)" title="Add Class"><i class="fa fa-plus-circle"></i></a>'));
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
				console.log(cleaned);
				var row = $('<tr class="d-flex">');
				row.append($('<td>').addClass('hidden-column').text(value.id));
				row.append($('<td class="col-1"><i class="fa fa-book" title="book"></i></td>'));
				row.append($('<td class="smaller-table-font col-5">').text(value.name));
				row.append($('<td class="smaller-table-font col-4">').text(addSpace(JSON.stringify(value.subjects))));
				row.append($('<td class="smaller-table-font col-1 text-right pr-1">').text(Number(value.price).toFixed(2)));
				// row.append($("<td class='col-1' onclick='addBookToInvoice(" + cleaned + ")''>").html('<a href="javascript:void(0)" title="Add Book"><i class="fa fa-plus-circle"></i></a>'));
				row.append($("<td class='col-1' onclick='addBookToBasket(" + cleaned + ")''>").html('<a href="javascript:void(0)" title="Add Book"><i class="fa fa-plus-circle"></i></a>'));
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
// function listEtcs(grade) {
// 	// clear 'courseEtcTable' table body
// 	$('#courseEtcTable tbody').empty();
// 	$.ajax({
// 		url : '${pageContext.request.contextPath}/courseEtc/list',
// 		type : 'GET',
// 		data : {
// 			grade : grade,
// 		},
// 		success : function(data) {
// 			$.each(data, function(index, value) {
// 				const cleaned = cleanUpJson(value);
// 				var row = $('<tr class="d-flex">');
// 				row.append($('<td>').addClass('hidden-column').text(value.id));
// 				row.append($('<td class="col-1"><i class="fa fa-ellipsis-h" title="etc"></i></td>'));
// 				row.append($('<td class="smaller-table-font col-8" style="padding-left: 20px;">').text(value.name));
// 				row.append($('<td class="smaller-table-font col-2 text-right pr-4">').text(Number(value.price).toFixed(2)));
// 				// row.append($("<td class='col-1' onclick='addEtcToInvoice(" + cleaned + ")''>").html('<a href="javascript:void(0)" title="Add Etc"><i class="fa fa-plus-circle"></i></a>'));
// 				row.append($("<td class='col-1' onclick='addEtcToBasket(" + cleaned + ")''>").html('<a href="javascript:void(0)" title="Add Etc"><i class="fa fa-plus-circle"></i></a>'));
// 				$('#courseEtcTable > tbody').append(row);
// 			});
// 		},
// 		error : function(xhr, status, error) {
// 			console.log('Error : ' + error);
// 		}
// 	});
// }

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

	$('#basketTable tbody tr').each(function() {
		// in case of update, enrolId is not null
		var enrolId = null;
		var hiddens = $(this).find('.hidden-column').text();
		if(hiddens.indexOf('|') !== -1){
			var hiddenValues = hiddens.split('|');
			// if hiddenValues[0] is ELEARNING, push hiddenValues[1] to elearnings array
			if(hiddenValues[0] === ELEARNING){
				elearnings.push(hiddenValues[1]);
				// how to jump to next <tr>
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
	});

	var elearningData = elearnings.map(function(id) {
    	return parseInt(id);
	});

	// Make the AJAX request for eLearning
	// if(elearningData.length > 0){
		$.ajax({
			url: '${pageContext.request.contextPath}/student/associateElearning/' + studentId,
			method: 'POST',
			data: JSON.stringify(elearningData),
			contentType: 'application/json',
			success: function(response) {
				// Handle the response
				console.log(response);
			},
			error: function(xhr, status, error) {
				// Handle the error
				console.error(error);
			}
		});
	// }

	// Make the AJAX request for class
	$.ajax({
		url: '${pageContext.request.contextPath}/student/associateClazz/' + studentId,
		method: 'POST',
		data: JSON.stringify(enrolData),
		contentType: 'application/json',
		success: function(response) {
			// Handle the response
			console.log(response);
			$('#success-alert .modal-body').html('ID : <b>' + studentId + '</b> enrolment saved successfully');
			$('#success-alert').modal('toggle');
		},
		error: function(xhr, status, error) {
			// Handle the error
			console.error(error);
		}
	});
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Add elearning to basket
//////////////////////////////////////////////////////////////////////////////////////////////////////
function addElearningToBasket(value){
	// console.log(value);
	var row = $("<tr class='d-flex'>");
	row.append($('<td>').addClass('hidden-column').text(ELEARNING + '|' + value.id));
	row.append($('<td class="col-1"><i class="fa fa-laptop" title="e-learning"></i></td>'));
	row.append($('<td class="smaller-table-font col-10" colspan="6">').text('[' + value.grade.toUpperCase() + '] ' + value.name));
	row.append($("<td class='col-1'>").html('<a href="javascript:void(0)" title="Delete eLearning"><i class="fa fa-trash"></i></a>'));
	$('#basketTable > tbody').append(row);

	// Automatically dismiss the alert after 2 seconds
	showAlertMessage('addAlert', '<center><i class="fa fa-laptop"></i> &nbsp;&nbsp' + value.name +' added to My Lecture</center>');
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Add class to basket
//////////////////////////////////////////////////////////////////////////////////////////////////////
function addClassToBasket(value){
	$.ajax({
		url: '${pageContext.request.contextPath}/class/classesByCourse',
		type: 'GET',
		data: {
			courseId: value.id,
			year: value.year
		},
		success: function(data) {
			if(value.year == academicYear){
				// var start_week = academicWeek;
				// var end_week = academicWeek + 10;
				var start_week = parseInt(academicWeek);
				var end_week = parseInt(academicWeek) + 9;

				if(end_week >= 49){
					end_week = 49;
				}
				var weeks = (end_week - start_week)+1;
			}else{
				var start_week = 1;
				var end_week = 10;
				var weeks = (end_week - start_week)+1;
			}
			var row = $('<tr class="d-flex">');
			row.append($('<td class="col-1"><i class="fa fa-graduation-cap" title="class"></i></td>'));
			row.append($('<td class="smaller-table-font col-4">').text('[' + value.grade.toUpperCase() + '] '+ value.description));
			// Create a dropdown list for value.day and id is option value
			var dropdown = $('<select class="clazzChoice">');
			$.each(data, function(index, clazz) {
				dropdown.append($('<option>').text(clazz.day).val(clazz.id));
			});
			row.append($('<td class="smaller-table-font col-2">').append(dropdown));
			row.append($('<td class="smaller-table-font col-1">').text(value.year));
			row.append($('<td class="start-week smaller-table-font col-1 text-center" contenteditable="true">').text(start_week));
			row.append($('<td class="end-week smaller-table-font col-1 text-center" contenteditable="true">').text(end_week));
			row.append($('<td class="smaller-table-font col-1 text-center" contenteditable="true">').text(weeks));
			row.append($('<td class="col-1">').html('<a href="javascript:void(0)" title="Delete Class"><i class="fa fa-trash"></i></a>'));
			$('#basketTable > tbody').append(row);
		},
		error: function(xhr, status, error) {
			console.log('Error: ' + error);
		}
	});


}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Add book to basket
//////////////////////////////////////////////////////////////////////////////////////////////////////
function addBookToBasket(value){
	var row = $('<tr class="d-flex">');
	row.append($('<td>').addClass('hidden-column').text(BOOK + '|' + value.id)); // 0
	row.append($('<td class="col-1"><i class="fa fa-book" title="book"></i></td>')); // item
	row.append($('<td class="smaller-table-font col-10" colspan="6">').text(value.name)); // description
	row.append($("<td class='col-1'>").html('<a href="javascript:void(0)" title="Delete Class"><i class="fa fa-trash"></i></a>')); // Action
	$('#basketTable > tbody').append(row);
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Add book to invoice
//////////////////////////////////////////////////////////////////////////////////////////////////////
function addBookToInvoice(value){
	var row = $('<tr>');
	row.append($('<td>').addClass('hidden-column').text(BOOK + '|' + value.id)); // 0
	row.append($('<td class="text-center"><i class="fa fa-book" title="book"></i></td>')); // item
	row.append($('<td class="smaller-table-font">').text('[' + value.grade.toUpperCase() +'] ' + value.name)); // description
	row.append($('<td class="smaller-table-font">').text(0)); // year
	row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('start-week').text(0)); // start week
	row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('end-week').text(0)); // end week
	row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('weeks').text(1)); // weeks
	row.append($('<td class="smaller-table-font">').addClass('fee').text(Number(value.price).toFixed(2)));// price
	row.append($('<td class="smaller-table-font">').text(0));// credit	
	// row.append($('<td class="smaller-table-font">').text('0'));// credit date
	row.append($('<td class="smaller-table-font">').text('0'));// DC %
	row.append($('<td class="smaller-table-font">').text('0'));// DC $
	row.append($('<td class="smaller-table-font text-center" contenteditable="true">').text(Number(value.price).toFixed(2)));// Total
	row.append($('<td class="smaller-table-font">').text('0'));// Date
	row.append($("<td class='col-1'>").html('<a href="javascript:void(0)" title="Delete Class"><i class="fa fa-trash"></i></a>')); // Action
	$('#invoiceListTable > tbody').append(row);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Add etc to basket
//////////////////////////////////////////////////////////////////////////////////////////////////////
// function addEtcToBasket(value){
// 	var row = $('<tr class="d-flex">');
// 	row.append($('<td>').addClass('hidden-column').text(ETC  + '|' + value.id));
// 	row.append($('<td class="col-1">').text('Etc'));
// 	row.append($('<td>').text(value.name));
// 	row.append($('<td>').text(academicYear));
// 	row.append($('<td>').text(academicWeek));
// 	row.append($('<td>').text(0));
// 	row.append($('<td>').text(value.price));
// 	row.append($("<td>").html('<a href="javascript:void(0)" title="Delete Etc"><i class="fa fa-trash"></i></a>'));
// 	$('#basketTable > tbody').append(row);
// }

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Add etc to Invoice
//////////////////////////////////////////////////////////////////////////////////////////////////////
// function addEtcToInvoice(value){
// 	var row = $('<tr>');
// 	row.append($('<td>').addClass('hidden-column').text(ETC + '|' + value.id)); // 0
// 	row.append($('<td class="text-center"><i class="fa fa-ellipsis-h" title="etc"></i></td>')); // item
// 	row.append($('<td class="smaller-table-font">').text(value.name)); // description
// 	row.append($('<td class="smaller-table-font">').text(0)); // year
// 	row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('start-week').text(0)); // start week
// 	row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('end-week').text(0)); // end week
// 	row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('weeks').text(1)); // weeks
// 	row.append($('<td class="smaller-table-font">').addClass('fee').text(Number(value.price).toFixed(2)));// price
// 	row.append($('<td class="smaller-table-font">').text(0));// credit	
// 	// row.append($('<td class="smaller-table-font">').text('0'));// credit date
// 	row.append($('<td class="smaller-table-font">').text('0'));// DC %
// 	row.append($('<td class="smaller-table-font">').text('0'));// DC $
// 	row.append($('<td class="smaller-table-font text-center" contenteditable="true">').text(Number(value.price).toFixed(2)));// Total
// 	row.append($('<td class="smaller-table-font">').text('0'));// Date
// 	row.append($("<td class='col-1'>").html('<a href="javascript:void(0)" title="Delete Class"><i class="fa fa-trash"></i></a>')); // Action
// 	$('#invoiceListTable > tbody').append(row);

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
				// console.log('--- ' + value);	
				var row = $('<tr class="d-flex">');
				row.append($('<td>').addClass('hidden-column').text(CLASS + '|' + value.id));
				row.append($('<td class="col-1"><i class="fa fa-graduation-cap" title="class"></i></td>'));
				row.append($('<td class="smaller-table-font col-4">').text('[' + value.grade.toUpperCase() +'] ' + value.name));
				row.append($('<td class="smaller-table-font col-2">').text(value.day));
				row.append($('<td class="smaller-table-font col-1">').text(value.year));
				row.append($('<td class="smaller-table-font col-1 text-center" contenteditable="true">').addClass('start-week').text(value.startWeek));
				row.append($('<td class="smaller-table-font col-1 text-center" contenteditable="true">').addClass('end-week').text(value.endWeek));
				row.append($('<td class="smaller-table-font col-1 text-center" contenteditable="true">').text(value.endWeek - value.startWeek + 1));
				row.append($("<td class='col-1'>").html('<a href="javascript:void(0)" title="Delete Class"><i class="fa fa-trash"></i></a>'));
				$('#basketTable > tbody').append(row);	

				// update the invoice table
				retrieveInvoiceListTable(value);


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
				row.append($('<td>').addClass('hidden-column').text(ELEARNING + '|' + value.id));
				row.append($('<td class="col-1"><i class="fa fa-laptop" title="e-learning"></i></td>'));
				row.append($('<td class="smaller-table-font col-10" colspan="6">').text('[' + value.grade.toUpperCase() +'] ' + value.name));
				// row.append($('<td class="smaller-table-font">').text(''));
				// row.append($('<td class="smaller-table-font">').text(''));
				// row.append($('<td class="smaller-table-font">').text(''));
				row.append($("<td class='col-1'>").html('<a href="javascript:void(0)" title="Delete Class"><i class="fa fa-trash"></i></a>'));
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
	<form id="">
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
					<p class="text-truncate text-center">To apply, please click on the Enrollment button</p>
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
                              <table class="table" id="courseFeeTable" name="courseFeeTable">
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
                              <table class="table" cellspacing="0" id="courseBookTable" name="courseBookTable">
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
						  <!-- Etc -->
                          <!-- <div class="tab-pane fade" id="nav-etc" role="tabpanel" aria-labelledby="nav-etc-tab">
                              <table class="table" cellspacing="0" id="courseEtcTable" name="courseEtcTable">
								<thead>
                                      <tr class="d-flex">
										  <th class="hidden-column"></th>
										  <th class="smaller-table-font col-1">Item</th>
										  <th class="smaller-table-font col-8" style="padding-left: 20px;">Description</th>
                                          <th class="smaller-table-font col-2 text-right pr-4">Price</th>
										  <th class="smaller-table-font col-1"></th>
                                      </tr>
                                  </thead>
                                  <tbody>
                                  </tbody>                                  
                              </table>
                          </div> -->
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
    
		