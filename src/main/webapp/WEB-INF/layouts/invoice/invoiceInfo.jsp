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
    var row = $('<tr>');
    row.append($('<td>').addClass('hidden-column').text(ENROLMENT + '|' + data.id)); // 0
    row.append($('<td class="text-center"><i class="fa fa-graduation-cap" title="class"></i></td>')); // item
    row.append($('<td class="smaller-table-font">').text('[' + data.grade.toUpperCase() +'] ' + data.name)); // description
    row.append($('<td class="smaller-table-font">').text(data.year)); // year
    row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('start-week').text(data.startWeek)); // start week
    row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('end-week').text(data.endWeek)); // end week
    row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('weeks').text(data.endWeek - data.startWeek + 1)); // weeks
    
    row.append($('<td class="smaller-table-font">').addClass('price').text(data.price));// price
    row.append($('<td class="smaller-table-font" contenteditable="true">').addClass('credit').text('0'));// credit   
    row.append($('<td class="smaller-table-font" contenteditable="true">').text('0'));// DC %
    row.append($('<td class="smaller-table-font" contenteditable="true">').addClass('discount').text('0'));// DC $
    row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('amount').text((data.price*(data.endWeek-data.startWeek+1)).toFixed(2)));

    row.append($('<td class="smaller-table-font">').text('0'));// Date
    row.append($("<td class='col-1'>").html('<a href="javascript:void(0)" title="Delete Class"><i class="fa fa-trash"></i></a>')); // Action

    $('#invoiceListTable > tbody').append(row);

    // Calculate and update the weeks, start-week, end-week, and credit columns
    var startWeekCell = row.find('.start-week');
    var endWeekCell = row.find('.end-week');
    var weeksCell = row.find('.weeks');
    var creditCell = row.find('.credit');
    var amountCell = row.find('.amount');
    
    function updateWeeks() {
        var startWeek = parseInt(startWeekCell.text());
        var endWeek = parseInt(endWeekCell.text());
        var weeks = parseInt(weeksCell.text());
        var credit = parseInt(creditCell.text());
        var price = parseFloat(row.find('.price').text());
        
        if (!isNaN(startWeek) && !isNaN(endWeek)) {
            weeks = endWeek - startWeek + 1;
            weeksCell.text(weeks);
        } else if (!isNaN(weeks) && !isNaN(startWeek)) {
            endWeek = startWeek + weeks - 1;
            endWeekCell.text(endWeek);
        } else if (!isNaN(weeks)) {
            endWeek = startWeek + weeks - 1;
            endWeekCell.text(endWeek);
        }
        
        if (!isNaN(weeks) && !isNaN(credit)) {
            weeks += credit;
            weeksCell.text(weeks);
            endWeek = startWeek + weeks - 1;
            endWeekCell.text(endWeek);
        }
        
        var amount = price * (weeks-credit);
        amountCell.text(amount.toFixed(2));
    }
    
    startWeekCell.on('input', updateWeeks);
    endWeekCell.on('input', updateWeeks);
    creditCell.on('input', updateWeeks);
}



//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Clean invoiceTable
//////////////////////////////////////////////////////////////////////////////////////////////////////
function clearInvoiceTable(){
	$('#invoiceListTable > tbody').empty();
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Make Payment
//////////////////////////////////////////////////////////////////////////////////////////////////////
function makePayment(){
	//console.log('makePayment');
	document.getElementById('makePayment').reset();
	$('#paymentModal').modal('toggle');					
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Create Invoice
//////////////////////////////////////////////////////////////////////////////////////////////////////
function createInvoice(){

	var enrols = [];
	var studentId = $('#formId').val();
	
	$('#invoiceListTable tbody tr').each(function() {
		var hiddens = $(this).find('.hidden-column').text();
		if(hiddens.indexOf('|') !== -1){
			var hiddenValues = hiddens.split('|');
			enrolId = hiddenValues[1];	
		}
		// find value of next td whose class is 'start-year'
		startWeek = $(this).find('.start-week').text();
		endWeek = $(this).find('.end-week').text();
		amount = $(this).find('.amount').text();
		credit = $(this).find('.credit').text();
		discount = $(this).find('.discount').text();
		var enrol = {
			"id" : enrolId,
			"startWeek" : startWeek,
			"endWeek" : endWeek,
			"amount" : amount,
			"credit" : credit,
			"discount" : discount
		};
		enrols.push(enrol);	
	});

	console.log(enrols);

	// Send AJAX to server
	$.ajax({
		url : '${pageContext.request.contextPath}/invoice/create/' + studentId,
		type : 'POST',
		dataType : 'json',
		data : JSON.stringify(enrols),
		contentType : 'application/json',
		success : function(invoice) {
			// Display the success alert


			$("#invoiceId").val(invoice.id);
			$("#invoiceCredit").val(invoice.credit);
			$("#invoiceDiscount").val(invoice.discount);
			$("#invoicePaid").val(invoice.paidAmount);
			$("#invoiceTotal").val(invoice.totalAmount);
			$("#invoiceRegisterDate").val(invoice.registerDate);
            $('#invoiceModal').modal('toggle');		
		},
		error : function(xhr, status, error) {
			console.log('Error : ' + error);
		}
	});
	
					
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
					<button type="button" class="btn btn-block btn-primary btn-sm"  data-toggle="modal" data-target="#paymentModal">Payment</button>
				</div>
				<div class="col md-auto">
					<button type="button" class="btn btn-block btn-primary btn-sm" onclick="createInvoice()">Invoice</button>
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
									<!-- <th class="smaller-table-font">Cr.Date</th> -->
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

<!-- Payment Dialogue -->
<div class="modal fade" id="paymentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<section class="fieldset rounded border-primary">
				<header class="text-primary font-weight-bold">Payment</header>
				<form id="makePayment">
					<div class="form-row mt-4">
						<div class="col-md-6">
							<label>Receivable Amount : </label> 
						</div>
						<div class="col-md-6">
							<input type="text" class="form-control" id="payRxAmount" name="payRxAmount">
						</div>						
					</div>
					<div class="form-row mt-2">
						<div class="col-md-6">
							<label>Payment Amount : </label> 
						</div>
						<div class="col-md-6">
							<input type="text" class="form-control" id="payAmount" name="payAmount">
						</div>						
					</div>
					<div class="form-row mt-2">
						<div class="col-md-6">
							<label>Outstanding : </label> 
						</div>
						<div class="col-md-6">
							<input type="text" class="form-control" id="payOutstanding" name="payOutstanding">
						</div>						
					</div>
					<div class="form-row mt-2">
						<div class="col-md-6">
							<label>Receive Item : </label> 
						</div>
						<div class="col-md-6">
							<select class="form-control" id="payItem" name="payItem">
								<option value="p2">Cash</option>
								<option value="p3">Bank</option>
								<option value="p4">Card</option>
								<option value="p5">Cheque</option>
							</select>	
						</div>						
					</div>
					<div class="form-row mt-3">
						<div class="col-md-6">
							<label>Receive Date : </label>
						</div>
						<div class="col-md-6">
							<input type="text" class="form-control datepicker" id="payDate" name="payDate" placeholder="dd/mm/yyyy">
						</div>
						<script>
							var today = new Date();
							var day = today.getDate();
							var month = today.getMonth() + 1; // Note: January is 0
							var year = today.getFullYear();
							var formattedDate = (day < 10 ? '0' : '') + day + '/' + (month < 10 ? '0' : '') + month + '/' + year;
							document.getElementById('payDate').value = formattedDate;
						</script>
					</div>
					<div class="form-row mt-2">
						<div class="col-md-6">
							<label>Other Information : </label> 
						</div>
						<div class="col-md-6">
							<input type="text" class="form-control" id="payInfo" name="payInfo">
						</div>						
					</div>
				</form>
				<div class="d-flex justify-content-end">
    				<button type="submit" class="btn btn-primary" onclick="makePayment()">Save</button>&nbsp;&nbsp;
    				<button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="document.getElementById('makePayment').reset();">Cancel</button>
				</div>	
				</section>
			</div>
		</div>
	</div>
</div>



<!-- Invoice Dialogue -->
<div class="modal fade" id="invoiceModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<section class="fieldset rounded border-primary">
				<header class="text-primary font-weight-bold">Tax Invoice</header>
				<form id="showInvoice">
					<div class="form-row mt-4">
						<div class="col-md-4">
							<input type="text" class="form-control" id="invoiceId" name="invoiceId">
						</div>
						<div class="col-md-4">
							<input type="text" class="form-control" id="invoiceCredit" name="invoiceCredit">
						</div>
						<div class="col-md-4">
							<input type="text" class="form-control" id="invoiceDiscount" name="invoiceDiscount">
						</div>						
					</div>
					<div class="form-row mt-4">
						<div class="col-md-4">
							<input type="text" class="form-control" id="invoicePaid" name="invoicePaid">
						</div>
						<div class="col-md-4">
							<input type="text" class="form-control" id="invoiceTotal" name="invoiceTotal">
						</div>
						<div class="col-md-4">
							<input type="text" class="form-control" id="invoiceRegisterDate" name="invoiceRegisterDate">
						</div>						
					</div>

				<div class="d-flex justify-content-end">
    				<!-- <button type="submit" class="btn btn-primary" onclick="updatePayment()">Save</button>&nbsp;&nbsp; -->
    				<button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="document.getElementById('showInvoice').reset();">Cancel</button>
				</div>	
				</section>
			</div>
		</div>
	</div>
</div>



















<!-- Bootstrap Editable Table JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.21.4/bootstrap-table.min.js"></script>
    
		