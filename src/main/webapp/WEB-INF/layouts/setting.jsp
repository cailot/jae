<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="hyung.jin.seo.jae.model.StudentDTO"%>
<link href="https://unpkg.com/bootstrap-table@1.21.4/dist/bootstrap-table.min.css" rel="stylesheet">

<script src="https://unpkg.com/bootstrap-table@1.21.4/dist/bootstrap-table.min.js"></script>
<script>
	// sorting
	$(document).ready(
			function() {
				$('#studentListTable th').click(
						function() {
							var table = $(this).parents('table').eq(0);
							var rows = table.find('tr:gt(0)').toArray().sort(
									compare($(this).index()));
							this.asc = !this.asc;
							if (!this.asc) {
								rows = rows.reverse();
							}
							for (var i = 0; i < rows.length; i++) {
								table.append(rows[i]);
							}
						});
				function compare(index) {
					return function(a, b) {
						var valA = getCellValue(a, index), valB = getCellValue(
								b, index);
						return $.isNumeric(valA) && $.isNumeric(valB) ? valA
								- valB : valA.toString().localeCompare(valB);
					};
				}
				function getCellValue(row, index) {
					return $(row).children('td').eq(index).text();
				}
			});

	function listStudents() {

		var body = $('#list-student-body');
		body.empty();
		var params = {
			state : $("#listState").val(),
			branch : $("#listBranch").val(),
			grade : $("#listGrade").val(),
			start : $("#listStart").val(),
			active : $("#listActive").val(),

		}

		$.ajax({
			url : "student/list",
			type : 'GET',
			data : params,
			success : function(data) {
				// Display the success alert
				$('#success-alert .modal-body').text(
						data.length + ' student record(s) found.');
				$('#success-alert').modal('show');

				$.each(data,
						function(i, item) {
							var row = $('<tr></tr>');
							//row.append($('<td></td>').text(i+1));
							row.append($('<td></td>').text(item.id));
							row.append($('<td></td>').text(item.firstName));
							row.append($('<td></td>').text(item.lastName));
							row.append($('<td></td>').text(item.grade));
							row.append($('<td></td>').text(item.registerDate));
							row.append($('<td></td>').text(
									getWeek(item.registerDate)));
							row.append($('<td></td>').text(item.endDate));
							row.append($('<td></td>').text(
									getWeek(item.endDate)));
							row.append($('<td></td>').text(item.email));
							row.append($('<td></td>').text(item.contactNo1));
							body.append(row);
						});
			}
		});

	}
	var old = new Date('1970-01-01');
	// return week info based on financial year
	function getWeek(enrol) {
		enrolDate = new Date(enrol);
		// if no date then return ''	
		if (enrolDate.getTime() == old.getTime()) {
			return '';
		}
		if (enrolDate.getMonth() > 5) {
			startDate = new Date(enrolDate.getFullYear(), 5, 30);
		} else {
			startDate = new Date(enrolDate.getFullYear() - 1, 5, 30);
		}
		var days = Math.floor((enrolDate - startDate) / (24 * 60 * 60 * 1000));

		var weekNumber = Math.ceil(days / 7);
		//console.log("Week number of " + enrolDate + " is :   " + weekNumber);
		return weekNumber;
	}
	function exportTableToExcel(tableId) {
		var downloadLink;
		var dataType = 'application/vnd.ms-excel';
		var tableSelect = document.getElementById(tableId);

		var tableHTML = tableSelect.outerHTML.replace(/ /g, '%20');
		// Specify the filename
		filename = 'Student_List.xls';
		// Create download link element
		downloadLink = document.createElement("a");
		document.body.appendChild(downloadLink);
		if (navigator.msSaveOrOpenBlob) {
			var blob = new Blob([ '\ufeff', tableHTML ], {
				type : dataType
			});
			navigator.msSaveOrOpenBlob(blob, filename);
		} else {
			// Create a link to the file
			downloadLink.href = 'data:' + dataType + ', ' + tableHTML;
			// Setting the file name
			downloadLink.download = filename;
			//triggering the function
			downloadLink.click();
		}
	}
	function printTable() {
		$("#studentListTable").printThis({
			importCSS : true,
			printContainer : true,
			header : "<center><h3>Student List</h3></center>"
		});
	}
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




<!-- List Body -->
<div class="row">
	<div class="modal-body">
		<form id="studentList">
			<div class="form-group">
				<div class="form-row">
					<div class="col-md-2">
						<select class="form-control" id="listState" name="listState">
							<option value="All">All State</option>
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
					<div class="col-md-2">
						<select class="form-control" id="listBranch" name="listBranch">
							<option value="All">All Branch</option>
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
					<div class="col-md-1">
						<select class="form-control" id="listGrade" name="listGrade">
							<option value="All">All</option>
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
					<div class="col-md-2">
						<select class="form-control" id="listActive" name="listActive">
							<option value="All">All Students</option>
							<option value="Current">Current Students</option>
							<option value="Stopped">Stopped Students</option>
						</select>
					</div>
					<div class="col-md-2">
						<input type="text" class="form-control datepicker" id="listStart"
							name="listStart" placeholder="Start Date" required>
					</div>
					<div class="col mx-auto">
						<button type="button" class="btn btn-primary btn-block"
							onclick="listStudents()">Search</button>
					</div>
					<div class="col mx-auto">
						<button type="button" class="btn btn-primary btn-block"
							onclick="exportTableToExcel('studentListTable')">Download</button>
					</div>
					<div class="col mx-auto">
						<button type="button" class="btn btn-primary btn-block"
							onclick="printTable()">Print</button>
					</div>
				</div>
			</div>


			<div class="form-group">
				<div class="form-row">
					<div class="col-md-12">
						<div class="table-wrap">
							<table id="studentListTable" data-toggle="table">
								
								<thead class="table-primary">
									<tr>
										<%--<th scope="col">No</th>  --%>
										<th data-width="5" data-width-unit="%">ID</th>
										<th data-width="10" data-width-unit="%">First Name</th>
										<th data-width="10" data-width-unit="%">Last Name</th>
										<th data-width="5" data-width-unit="%">Grade</th>
										<th data-width="10" data-width-unit="%">Start Date</th>
										<th data-width="10" data-width-unit="%">Week</th>
										<th data-width="10" data-width-unit="%">End Date</th>
										<th data-width="10" data-width-unit="%">Week</th>
										<th data-width="10" data-width-unit="%">Email</th>
										<th data-width="20" data-width-unit="%">Contact</th>
									</tr>
								</thead>
								<tbody id="list-student-body">
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

		</form>
	</div>
</div>
