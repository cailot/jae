<script>

const FULL_PAID = 'Full';
const OUTSTANDING = 'Outstanding';


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
// function retrieveInvoiceListTable(data) {
// 	// set invoiceId into hiddenId
// 	$('#hiddenId').val(data.invoiceId);

//     var row = $('<tr>');
	
// 	// display the row in red if the amount is not fully paid 
// 	var needPay = (data.amount - data.paid > 0) ? true : false;
// 	(needPay) ? row.addClass('text-danger') : row.addClass('');

//     row.append($('<td>').addClass('hidden-column').text(ENROLMENT + '|' + data.id));
//     row.append($('<td class="text-center"><i class="fa fa-graduation-cap" title="class"></i></td>'));
//     row.append($('<td class="smaller-table-font">').text('[' + data.grade.toUpperCase() +'] ' + data.name));
//     row.append($('<td class="smaller-table-font">').text(data.year));
    
// 	// set editable attribute to true if the amount is not fully paid	
// 	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('start-week').text(data.startWeek)) : row.append($('<td class="smaller-table-font text-center">').addClass('start-week').text(data.startWeek));
// 	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('end-week').text(data.endWeek)) : row.append($('<td class="smaller-table-font text-center">').addClass('end-week').text(data.endWeek));
// 	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('weeks').text(data.endWeek - data.startWeek + 1)) : row.append($('<td class="smaller-table-font text-center" >').addClass('weeks').text(data.endWeek - data.startWeek + 1));
//     row.append($('<td class="smaller-table-font text-center">').addClass('price').text((data.price).toFixed(2)));
// 	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('credit').text(data.credit)) : row.append($('<td class="smaller-table-font text-center">').addClass('credit').text(data.credit));
// 	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').text('0 %')) : row.append($('<td class="smaller-table-font text-center">').text('0 %'));
// 	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('discount').text(data.discount)) : row.append($('<td class="smaller-table-font text-center">').addClass('discount').text(data.discount));
// 	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('amount').text((data.amount).toFixed(2)).attr("id", "amountCell")) : row.append($('<td class="smaller-table-font text-center">').addClass('amount').text((data.amount).toFixed(2)).attr("id", "amountCell"));
// 	row.append($('<td class="smaller-table-font paid-date">').text(data.payCompleteDate));
// 	row.append($('<td>').addClass('hidden-column paid').text(data.paid));
//     row.append($("<td class='col-1'>").html('<a href="javascript:void(0)" title="Delete Class"><i class="fa fa-trash"></i></a>'));

// 	// if any existing row's hidden-column value is same as the new row's hidden-column value, then remove the existing row
// 	$('#invoiceListTable > tbody > tr').each(function() {
// 		if ($(this).find('.hidden-column').text() === row.find('.hidden-column').text()) {
// 			$(this).remove();
// 		}
// 	});
	
// 	// add new row
//     $('#invoiceListTable > tbody').append(row);

//     var startWeekCell = row.find('.start-week');
//     var endWeekCell = row.find('.end-week');
//     var weeksCell = row.find('.weeks');
//     var creditCell = row.find('.credit');
//     var amountCell = row.find('.amount');
//     // var rxAmount = $("#rxAmount");
//     // rxAmount.text((data.price*(data.endWeek-data.startWeek+1)).toFixed(2)); // initial receivable amount

//     function updateWeeks() {
//         var startWeek = parseInt(startWeekCell.text());
//         var endWeek = parseInt(endWeekCell.text());
//         var weeks = parseInt(weeksCell.text());
//         var credit = parseInt(creditCell.text());
//         var price = parseFloat(row.find('.price').text());

//         if (!isNaN(startWeek) && !isNaN(endWeek)) {
//             weeks = endWeek - startWeek + 1;
//             weeksCell.text(weeks);
//         } else if (!isNaN(weeks) && !isNaN(startWeek)) {
//             endWeek = startWeek + weeks - 1;
//             endWeekCell.text(endWeek);
//         } else if (!isNaN(weeks)) {
//             endWeek = startWeek + weeks - 1;
//             endWeekCell.text(endWeek);
//         }

//         if (!isNaN(weeks) && !isNaN(credit)) {
//             weeks += credit;
//             weeksCell.text(weeks);
//             endWeek = startWeek + weeks - 1;
//             endWeekCell.text(endWeek);
//         }

//         var amount = price * (weeks-credit);
//         amountCell.text(rxAmount.toFixed(2));
//     }

//     startWeekCell.on('input', updateWeeks);
//     endWeekCell.on('input', updateWeeks);
//     creditCell.on('input', updateWeeks);
// 	// update Receivable Amount
// 	updateReceivableAmount();
// }
function retrieveInvoiceListTable(data) {
	// set invoiceId into hiddenId
	$('#hiddenId').val(data.invoiceId);

    var row = $('<tr>');
	
	// display the row in red if the amount is not fully paid 
	var needPay = (data.amount - data.paid > 0) ? true : false;
	// (needPay) ? row.addClass('text-danger') : row.addClass('');

    row.append($('<td>').addClass('hidden-column').addClass('inovice-match').text(ENROLMENT + '|' + data.id));
    row.append($('<td class="text-center"><i class="fa fa-graduation-cap" title="class"></i></td>'));
    row.append($('<td class="smaller-table-font">').text('[' + data.grade.toUpperCase() +'] ' + data.name));
    row.append($('<td class="smaller-table-font">').text(data.year));
    
	// set editable attribute to true if the amount is not fully paid	
	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('start-week').text(data.startWeek)) : row.append($('<td class="smaller-table-font text-center">').addClass('start-week').text(data.startWeek));
	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('end-week').text(data.endWeek)) : row.append($('<td class="smaller-table-font text-center">').addClass('end-week').text(data.endWeek));
	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('weeks').text(data.endWeek - data.startWeek + 1)) : row.append($('<td class="smaller-table-font text-center" >').addClass('weeks').text(data.endWeek - data.startWeek + 1));
    row.append($('<td class="smaller-table-font text-center">').addClass('price').text((data.price).toFixed(2)));
	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('credit').text(data.credit)) : row.append($('<td class="smaller-table-font text-center">').addClass('credit').text(data.credit));
	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').text('0 %')) : row.append($('<td class="smaller-table-font text-center">').text('0 %'));
	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('discount').text(data.discount)) : row.append($('<td class="smaller-table-font text-center">').addClass('discount').text(data.discount));
	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('amount').text((data.amount).toFixed(2)).attr("id", "amountCell")) : row.append($('<td class="smaller-table-font text-center">').addClass('amount').text((data.amount).toFixed(2)).attr("id", "amountCell"));
	row.append($('<td class="smaller-table-font paid-date">').text(data.payCompleteDate));
	row.append($('<td>').addClass('hidden-column paid').text(data.paid));
    row.append($("<td class='col-1'>").html('<a href="javascript:void(0)" title="Delete Class"><i class="fa fa-trash"></i></a>'));

	// if any existing row's invoice-match value is same as the new row's invoice-match value, then remove the existing row
	$('#invoiceListTable > tbody > tr').each(function() {
		if ($(this).find('.invoice-match').text() === row.find('.invoice-match').text()) {
			$(this).remove();
		}
	});
	
	// add new row
    $('#invoiceListTable > tbody').append(row);

    var startWeekCell = row.find('.start-week');
    var endWeekCell = row.find('.end-week');
    var weeksCell = row.find('.weeks');
    var creditCell = row.find('.credit');
    var amountCell = row.find('.amount');
    // var rxAmount = $("#rxAmount");
    // rxAmount.text((data.price*(data.endWeek-data.startWeek+1)).toFixed(2)); // initial receivable amount

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
        amountCell.text(rxAmount.toFixed(2));
    }

    startWeekCell.on('input', updateWeeks);
    endWeekCell.on('input', updateWeeks);
    creditCell.on('input', updateWeeks);
	// update Receivable Amount
	updateReceivableAmount();
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Update Receivable Amount
//////////////////////////////////////////////////////////////////////////////////////////////////////
function updateReceivableAmount(){
	var rxAmount = 0;
	// find the value of all amount cells
	$('#invoiceListTable > tbody > tr').each(function() {
		var amount = parseFloat($(this).find('.amount').text());
		var paid = parseFloat($(this).find('.paid').text());
		var difference = (amount - paid).toFixed(2);	
		// if amount - paid < 0, then amount is 0
		if (difference <= 0) {	
			// full paid so nothing to add
		}else{
			rxAmount += parseFloat(difference);
		}
	});
	$("#rxAmount").text((rxAmount).toFixed(2));
	// if rxAmount still remains more than 0, insert OS record at the top of the table
	// var newOS = $('<tr>');
	// newOS.append($('<td>').addClass('hidden-column').text(OUTSTANDING + '|' + 0));
	// newOS.append($('<td class="text-center"><i class="fa fa-exclamation-circle" title="class"></i></td>'));
	// newOS.append($('<td colspan="9" class="smaller-table-font">').text('Outstanding'));
	// // set editable attribute to true if the amount is not fully paid	
	// newOS.append($('<td class="smaller-table-font text-center">').addClass('amount').text((rxAmount).toFixed(2)));
	// newOS.append($('<td class="smaller-table-font paid-date">').text('Today'));
	// newOS.append($('<td>').addClass('hidden-column paid').text(0));
	// newOS.append($("<td class='col-1'>").html('<a href="javascript:void(0)" title="Delete Class"><i class="fa fa-trash"></i></a>'));
	// $('#invoiceListTable > tbody').prepend(newOS);

	// if rxAmount is 0, then disable payment button
	if (rxAmount == 0){
		$('#paymentBtn').prop('disabled', true);
	}else{
		$('#paymentBtn').prop('disabled', false);
	}

}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Clean invoiceTable
//////////////////////////////////////////////////////////////////////////////////////////////////////
function clearInvoiceTable(){
	$('#invoiceListTable > tbody').empty();
	// clear rxAmount in invoice section
	$('#rxAmount').text('0.00');
	// clear stored invoice id
	$('#hiddenId').val('');

}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Display Payment Modal
//////////////////////////////////////////////////////////////////////////////////////////////////////

function displayPayment(){
    // display Receivable amount
    var rxAmount = $("#rxAmount").text();
    $("#payRxAmount").val(rxAmount);
    // payAmount
    $("#payAmount").on('input', function(){
        var payAmount = parseFloat($("#payAmount").val()).toFixed(2);
        var difference = parseFloat($("#payRxAmount").val()) - parseFloat($("#payAmount").val());
		// console.log($("#payRxAmount").val() + '-' + $("#payAmount").val());
		$("#payOutstanding").val(difference.toFixed(2));
    });
    $('#paymentModal').modal('toggle');
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Display Receipt in another tab
//////////////////////////////////////////////////////////////////////////////////////////////////////
function displayReceiptInNewTab(){
  var invoiceId = $('#hiddenId').val();
  var studentId = $('#formId').val();
  var grade = $('#formGrade').val();
  var firstName = $('#formFirstName').val();
  var lastName = $('#formLastName').val();
  var url = '/receipt?invoiceId=' + invoiceId + '&studentId=' + studentId + '&grade=' + grade + '&firstName=' + firstName + '&lastName=' + lastName;
  var win = window.open(url, '_blank');
  win.focus();
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Make Payment
//////////////////////////////////////////////////////////////////////////////////////////////////////
function makePayment(){
	var hidden = $('#hiddenId').val();
	console.log('make payment hidden : ' + hidden);

	var studentId = $('#formId').val();
	
	var payment = {
		amount: $('#payAmount').val(),
		method: $('#payItem').val(),
		registerDate: $('#payDate').val(),
		info: $('#payInfo').val()
	};
	
	// Send AJAX to server
	$.ajax({
		url : '${pageContext.request.contextPath}/invoice/payment/' + studentId,
		type : 'POST',
		dataType : 'json',
		data : JSON.stringify(payment),
		contentType : 'application/json',
		success : function(response) {

			$.each(response, function(index, value){
				// how to set value object into request for next jsp page

				
				// update the invoice table
				retrieveInvoiceListTable(value);
			});

			// reset payment dialogue info
			document.getElementById('makePayment').reset();
			$('#paymentModal').modal('toggle');	

			// display receipt
			displayReceiptInNewTab();
			
		},
		error : function(xhr, status, error) {
			console.log('Error : ' + error);
		}
	});

						
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Create Invoice
//////////////////////////////////////////////////////////////////////////////////////////////////////
function createInvoice(){

	var hidden = $('#hiddenId').val();
	console.log('create invoice hidden : ' + hidden);

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

	// console.log(enrols);

	// Send AJAX to server
	$.ajax({
		url : '${pageContext.request.contextPath}/invoice/create/' + studentId,
		type : 'POST',
		dataType : 'json',
		data : JSON.stringify(enrols),
		contentType : 'application/json',
		success : function(invoice) {

			// update invoiceId to hiddenId
			$("#hiddenId").val(invoice.id);
			
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

function issueInvoice(){

var studentId = $('#formId').val();

// Send AJAX to server
$.ajax({
	url : '${pageContext.request.contextPath}/invoice/issue/' + studentId,
	type : 'POST',
	dataType : 'json',
	data : JSON.stringify(enrols),
	contentType : 'application/json',
	success : function(invoice) {
		// update invoiceId to hiddenId
		$("#hiddenId").val(invoice.id);
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

<!-- Main Body -->
<div class="modal-body" style="padding-top: 0.25rem; padding-left: 0rem; padding-right: 0rem;">
	<form id="">
		<div class="form-group">
			<div class="form-row">
				<div class="col-md-6">
					<div class="row">
						<input type="hidden" id="hiddenId" name="hiddenId" />
						<div class="col-md-4">
							<p>Receivable Amt:</p>
						</div>
						<div class="col-md-2">
							<p><mark><strong class="text-danger" id="rxAmount" name="rxAmount">0.00</strong></mark></p>
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
					<!-- <button type="button" class="btn btn-block btn-primary btn-sm"  data-toggle="modal" data-target="#paymentModal">Payment</button> -->
					<button type="button" class="btn btn-block btn-primary btn-sm" id="paymentBtn" onclick="displayPayment()">Payment</button>
				</div>
				<div class="col md-auto">
					<button type="button" class="btn btn-block btn-primary btn-sm" id="invoiceBtn" onclick="issueInvoice()">Invoice</button>
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
							<input type="text" class="form-control" id="payRxAmount" name="payRxAmount" readonly>
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
							<input type="text" class="form-control" id="payOutstanding" name="payOutstanding" readonly>
						</div>						
					</div>
					<div class="form-row mt-2">
						<div class="col-md-6">
							<label>Receive Item : </label> 
						</div>
						<div class="col-md-6">
							<select class="form-control" id="payItem" name="payItem">
								<option value="cash">Cash</option>
								<option value="bank">Bank</option>
								<option value="card">Card</option>
								<option value="cheque">Cheque</option>
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
    
		