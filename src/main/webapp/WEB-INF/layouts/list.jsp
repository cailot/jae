<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="hyung.jin.seo.jae.model.StudentDTO"%>
<%@page import="hyung.jin.seo.jae.utils.JaeUtils"%>

<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css">
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>

<script>
$(document).ready(function () {
    $('#studentListTable').DataTable();
});

<%-- 
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
						row.append($('<td></td>').text(item.id));
						row.append($('<td></td>').text(item.firstName));
						row.append($('<td></td>').text(item.lastName));
						row.append($('<td></td>').text(item.grade));
						row.append($('<td></td>').text(item.registerDate));
						row.append($('<td></td>').text(<%= JaeUtils.academicWeeks()%>));
						row.append($('<td></td>').text(item.endDate));
						row.append($('<td></td>').text(<%= JaeUtils.academicWeeks()%>));
						row.append($('<td></td>').text(item.email));
						row.append($('<td></td>').text(item.contactNo1));
						body.append(row);
					});
		}
	});

}
 --%>
 function listStudents() {

		var table = $('#student-table').DataTable({
			"destroy": true,
			"searching": false,
			"ordering": true,
			"paging": true,
			"info": true,
			"columns": [
				{ "data": "id" },
				{ "data": "firstName" },
				{ "data": "lastName" },
				{ "data": "grade" },
				{ "data": "registerDate" },
				{ "data": ""},
				{ "data": "endDate" },
				{ "data": ""},
				{ "data": "email" },
				{ "data": "contactNo1" }
			]
		});

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

				table.clear().rows.add(data).draw();
			}
		});

	}
function validate(){
	return true;
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
		<form id="studentList" method="get" action="${pageContext.request.contextPath}/student/list">
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
							<option value="tt6">TT6</option>
							<option value="tt8">TT8</option>
							<option value="tt8e">TT8E</option>
							<option value="jmss">JMSS</option>
							<option value="vce">VCE</option>
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
						<button type="submit" class="btn btn-primary btn-block" onclick="return validate()">Search</button>
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
							<table id="studentListTable" class="table table-striped table-bordered"><thead class="table-primary">
									<tr>
										<%--<th scope="col">No</th>  --%>
										<th data-field="sListid" data-sortable="true">ID</th>
										<th data-field="sListfirstName" data-sortable="true">First Name</th>
										<th data-field="sListlastName" data-sortable="true">Last Name</th>
										<!-- <th data-field="sListgrade" data-sortable="true">Grade</th>
										<th data-field="sListStartDate" data-sortable="true">Start Date</th>
										<th data-field="sListStartWeek" data-sortable="true">Week</th>
										<th data-field="sListEndDate" data-sortable="true">End Date</th>
										<th data-field="sListEndWeek" data-sortable="true">Week</th>
										<th data-field="sListEmail" data-sortable="true">Email</th>
										<th data-field="sListContact" data-sortable="true">Contact</th>
									 --></tr>
								</thead>
								<tbody id="list-student-body">
								<c:choose>
									<c:when test="${sl != null}">No records found
									</c:when>
									<c:otherwise>
									
										<c:forEach items="${sl}" var="details">
											<tr>
												<td class="small ellipsis"><span><c:out value="${details.id}" /></span></td>
												<c:set var="description" scope="session" value="${details.firstName}" />
												<td class="small ellipsis">
													<a href="#" class="text-dark" style="cursor:default;" data-toggle="tooltip" data-placement="auto" data-html="true"
														title="<div class='text-left'><c:out value='${description}' escapeXml='true'/></div>"
													> 
													<span><c:out value="${description}"/></span>
													</a>
												</td>
												<td class="center-cell"><i class="fa fa-envelope-o text-info" onclick="showMessage('${details.lastName}')" style="cursor:hand;" data-target="#layerpopMessage" data-toggle="modal"></i></td>
											</tr>
										</c:forEach>
									
									
									
									</c:otherwise>
								</c:choose>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

		</form>
	</div>
</div>
<script>
  function customSort(sortName, sortOrder, data) {
    var order = sortOrder === 'desc' ? -1 : 1
    data.sort(function (a, b) {
      var aa = +((a[sortName] + '').replace(/[^\d]/g, ''))
      var bb = +((b[sortName] + '').replace(/[^\d]/g, ''))
      if (aa < bb) {
        return order * -1
      }
      if (aa > bb) {
        return order
      }
      return 0
    })
  }
</script>