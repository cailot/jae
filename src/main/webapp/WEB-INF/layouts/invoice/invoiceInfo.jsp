<script>

var academicYear;
var academicWeek;

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


		// remove records from basket when click on delete icon
		$('#basketTable').on('click', 'a', function(e) {
			e.preventDefault();
			$(this).closest('tr').remove();
		});
	}
);


</script>

<div class="modal-body" style="padding-top: 0.25rem; padding-left: 0rem; padding-right: 0rem;">
	<form id="">
		<div class="form-group">
			<div class="form-row">
				<div class="col-md-6">
					<div class="row">
					<div class="col-md-4">
						<p>Receivable Amt:</p>
					</div>
					<div class="col-md-2">
						<p><mark><strong class="text-danger">740.00</strong></mark></p>
					</div>
					<div class="col-md-4">
						<p>Outstanding: </p>
					</div>
					<div class="col-md-2">
						<p><strong class="text-primary">0.00</strong></p>
					</div>
					</div>
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
				<div class="col-md-12">
					<div class="table-wrap">
						<table id="invoiceListTable" class="table table-striped table-bordered"><thead class="table-primary">
								<tr>
									<th class="smaller-table-font">Item</th>
									<th class="smaller-table-font">Description</th>
									<th class="smaller-table-font">Year</th>
									<th class="smaller-table-font">Start</th>
									<th class="smaller-table-font">End</th>
									<th class="smaller-table-font">Wks</th>
									<th class="smaller-table-font">Price</th>
									<th class="smaller-table-font">Credit</th>
									<th class="smaller-table-font">Cr.Date</th>
									<th class="smaller-table-font">DC%</th>
									<th class="smaller-table-font">DC$</th>
									<th class="smaller-table-font">Amount</th>
									<th class="smaller-table-font">Date</th>
									<th class="smaller-table-font" data-orderable="false">Action</th>
								</tr>
							</thead>
							<tbody id="list-class-body">
							<c:choose>
								<c:when test="${InvoiceList != null}">
									<c:forEach items="${InvoiceList}" var="invoice">
										<tr>
											<td class="small ellipsis"><span><c:out value="${invoice.name}" /></span></td>
											<td class="small ellipsis"><span><c:out value="${invoice.description}" /></span></td>
											<td class="small ellipsis"><span><c:out value="${invoice.grade}" /></span></td>
											<td class="small ellipsis"><span><c:out value="${invoice.price}" /></span></td>
											<td class="small ellipsis"><span><c:out value="${invoice.name}" /></span></td>
											<td class="small ellipsis"><span><c:out value="${invoice.description}" /></span></td>
											<td class="small ellipsis"><span><c:out value="${invoice.grade}" /></span></td>
											<td class="small ellipsis"><span><c:out value="${invoice.price}" /></span></td>
											<td class="small ellipsis"><span><c:out value="${invoice.name}" /></span></td>
											<td class="small ellipsis"><span><c:out value="${invoice.description}" /></span></td>
											<td class="small ellipsis"><span><c:out value="${invoice.grade}" /></span></td>
											<td class="small ellipsis"><span><c:out value="${invoice.price}" /></span></td>
											<td class="small ellipsis"><span><c:out value="${invoice.price}" /></span></td>
											<td>
												<i class="fa fa-edit text-primary" data-toggle="tooltip" title="Edit" onclick="retrieveCourseInfo('${invoice.id}')"></i>&nbsp;
												<i class="fa fa-sticky-note text-primary" data-toggle="tooltip" title="Note" onclick="retrieveCourseInfo('${invoice.id}')"></i>
											</td>
										</tr>
									</c:forEach>
								
								</c:when>
							</c:choose>
							</tbody>
						</table>
					</div>
                </div>
			</div>
		</div>
	</form>
</div>
<!-- Bootstrap Editable Table JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.21.4/bootstrap-table.min.js"></script>
    
		