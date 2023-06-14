<script>
$(document).ready(
	function() {
		// remove records from basket when click on delete icon
		$('#invoiceListTable').on('click', 'a', function(e) {
			e.preventDefault();
			$(this).closest('tr').remove();
		});
	}
);

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Retrieve invoiceListTable
//////////////////////////////////////////////////////////////////////////////////////////////////////
function retrieveInvoiceListTable(data) {
	console.log(data);
	var row = $('<tr>');
	row.append($('<td>').addClass('hidden-column').text(CLASS + '|' + data.id)); // 0
	row.append($('<td class="text-center"><i class="fa fa-graduation-cap" title="class"></i></td>')); // item
	row.append($('<td class="smaller-table-font">').text('[' + data.grade.toUpperCase() +'] ' + data.name)); // description
	row.append($('<td class="smaller-table-font">').text(data.year)); // year
	row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('start-week').text(data.startWeek)); // start week
	row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('end-week').text(data.endWeek)); // end week
	row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('weeks').text(data.endWeek - data.startWeek + 1)); // weeks
	

	row.append($('<td class="smaller-table-font">').addClass('fee').text(data.price));// price
	row.append($('<td class="smaller-table-font">').text('0'));// credit	
	row.append($('<td class="smaller-table-font">').text('0'));// credit date
	row.append($('<td class="smaller-table-font">').text('0'));// DC %
	row.append($('<td class="smaller-table-font">').text('0'));// DC $
	row.append($('<td class="smaller-table-font text-center" contenteditable="true">').text((data.price*(data.endWeek-data.startWeek+1)).toFixed(2)));

	row.append($('<td class="smaller-table-font">').text('0'));// Date
	row.append($("<td class='col-1'>").html('<a href="javascript:void(0)" title="Delete Class"><i class="fa fa-trash"></i></a>')); // Action

	$('#invoiceListTable > tbody').append(row);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Clean invoiceTable
//////////////////////////////////////////////////////////////////////////////////////////////////////
function clearInvoiceTable(){
	$('#invoiceListTable > tbody').empty();
}
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
							<tbody>
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
    
		