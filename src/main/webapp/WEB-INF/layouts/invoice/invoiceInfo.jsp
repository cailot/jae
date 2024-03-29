<%@ page import="hyung.jin.seo.jae.dto.EnrolmentDTO" %>
<%@ page import="hyung.jin.seo.jae.dto.OutstandingDTO" %>

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
function addEnrolmentToInvoiceList(data) {
	// console.log(data);
	// set invoiceId into hiddenId
	$('#hiddenId').val(data.invoiceId);

    var row = $('<tr>');
	
	// display the row in red if the amount is not fully paid 
	var needPay = (data.amount - data.paid > 0) ? true : false;
	// (needPay) ? row.addClass('text-danger') : row.addClass('');

    row.append($('<td>').addClass('hidden-column').addClass('enrolment-match').text(ENROLMENT + '|' + data.id));
    row.append($('<td class="text-center"><i class="bi bi-mortarboard" title="class"></i></td>'));
    row.append($('<td class="smaller-table-font">').text('[' + data.grade.toUpperCase() +'] ' + data.name));
    row.append($('<td class="smaller-table-font text-center">').text(data.year));
    
	// set editable attribute to true if the amount is not fully paid	
	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('start-week').text(data.startWeek)) : row.append($('<td class="smaller-table-font text-center">').addClass('start-week').text(data.startWeek));
	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('end-week').text(data.endWeek)) : row.append($('<td class="smaller-table-font text-center">').addClass('end-week').text(data.endWeek));
	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('weeks').text(data.endWeek - data.startWeek + 1)) : row.append($('<td class="smaller-table-font text-center" >').addClass('weeks').text(data.endWeek - data.startWeek + 1));
    row.append($('<td class="smaller-table-font text-right">').addClass('price').text((data.price).toFixed(2)));
	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('credit').text(data.credit)) : row.append($('<td class="smaller-table-font text-center">').addClass('credit').text(data.credit));
	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').text('0 %')) : row.append($('<td class="smaller-table-font text-center">').text('0 %'));
	(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('discount').text(data.discount)) : row.append($('<td class="smaller-table-font text-center">').addClass('discount').text(data.discount));
	//(needPay) ? row.append($('<td class="smaller-table-font text-center" contenteditable="true">').addClass('amount').text((data.amount).toFixed(2)).attr("id", "amountCell")) : row.append($('<td class="smaller-table-font text-center">').addClass('amount').text((data.amount).toFixed(2)).attr("id", "amountCell"));
	var amount = (data.endWeek - data.startWeek + 1) * data.price;
	(needPay) ? row.append($('<td class="smaller-table-font text-right" contenteditable="true">').addClass('amount').text(amount.toFixed(2)).attr("id", "amountCell")) : row.append($('<td class="smaller-table-font text-right">').addClass('amount').text(amount.toFixed(2)).attr("id", "amountCell"));

	row.append($('<td class="smaller-table-font paid-date text-center">').text(data.paymentDate));
	row.append($('<td>').addClass('hidden-column paid').text(data.paid));
	// if data.info is not empty, then display filled icon, otherwise display empty icon
	isNotBlank(data.info) ? row.append($("<td class='col-1 memo text-center'>").html('<i class="bi bi-chat-square-text-fill text-primary" title="Internal Memo" onclick="displayAddInfo(' + 'ENROLMENT' + ', ' +  data.id + ', \'' + data.info + '\')"></i>')) : row.append($("<td class='col-1 memo text-center'>").html('<i class="bi bi-chat-square-text text-primary" title="Internal Memo" onclick="displayAddInfo(' + 'ENROLMENT' + ', ' +  data.id + ', \'\')"></i>'));

	// if any existing row's invoice-match value is same as the new row's invoice-match value, then remove the existing row
	$('#invoiceListTable > tbody > tr').each(function() {
		if ($(this).find('.enrolment-match').text() === row.find('.enrolment-match').text()) {
			$(this).remove();
		}
	});
	
	// add new row at first row
	$('#invoiceListTable > tbody').prepend(row);
    // $('#invoiceListTable > tbody').append(row);

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

        // var amount = price * (weeks-credit);
        // amountCell.text(rxAmount.toFixed(2));
    }

    startWeekCell.on('input', updateWeeks);
    endWeekCell.on('input', updateWeeks);
    creditCell.on('input', updateWeeks);
	// update Receivable Amount
	updateReceivableAmount();
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Add Outstanding to invoiceListTable
//////////////////////////////////////////////////////////////////////////////////////////////////////
function addOutstandingToInvoiceList(data) {
	// console.log('addOutstandingToInvoiceListTable - ' + JSON.stringify(data));
	// set invoiceId into hiddenId
	$('#hiddenId').val(data.invoiceId);
	// debugger;
	var newOS = $('<tr>');
	newOS.append($('<td>').addClass('hidden-column').addClass('outstanding-match').text(OUTSTANDING + '|' + data.id));
	newOS.append($('<td class="text-center"><i class="bi bi-exclamation-circle" title="outstanding"></i></td>'));
	newOS.append($('<td class="smaller-table-font">').text('Outstanding'));
	newOS.append($('<td>'));
	newOS.append($('<td>'));
	newOS.append($('<td>'));
	newOS.append($('<td>'));
		
	// newOS.append($('<td colspan="4" class="smaller-table-font">').text(data.paid + ' Paid'));
	newOS.append($('<td class="smaller-table-font text-right">').html(data.paid + ' <i class="bi bi-check2-circle text-danger" title="paid"></i>'));
	newOS.append($('<td>'));
	newOS.append($('<td>'));
	newOS.append($('<td>'));
	
	// set editable attribute to true if the amount is not fully paid	
	newOS.append($('<td class="smaller-table-font text-right text-primary">').addClass('amount').text((data.remaining).toFixed(2)));
	// newOS.append($('<td class="smaller-table-font text-center">')
    // .addClass('amount')
    // .css('color', data.remaining > 0 ? 'red' : '')
    // .css('font-weight', data.remaining > 0 ? 'bold' : '')
    // .text((data.remaining).toFixed(2)));

	newOS.append($('<td class="smaller-table-font text-center paid-date">').text(data.registerDate));
	newOS.append($('<td>').addClass('hidden-column paid').text(data.paid));
	// if data.info is not empty, then display filled icon, otherwise display empty icon
	isNotBlank(data.info) ? newOS.append($("<td class='col-1 memo text-center'>").html('<i class="bi bi-chat-square-text-fill text-primary" title="Internal Memo" onclick="displayAddInfo(' + 'OUTSTANDING' + ', ' +  data.id + ', \'' + data.info + '\')"></i>')) : newOS.append($("<td class='col-1 memo text-center'>").html('<i class="bi bi-chat-square-text text-primary" title="Internal Memo" onclick="displayAddInfo(' + 'OUTSTANDING' + ', ' +  data.id + ', \'\')"></i>'));
		
	// if any existing row's invoice-match value is same as the new row's invoice-match value, then remove the existing row
	$('#invoiceListTable > tbody > tr').each(function() {
		if ($(this).find('.outstanding-match').text() === newOS.find('.outstanding-match').text()) {
			$(this).remove();
		}
	});

	$('#invoiceListTable > tbody').prepend(newOS);

	// update Outstanding Amount
	updateOutstandingAmount();
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Add Book to invoiceListTable
//////////////////////////////////////////////////////////////////////////////////////////////////////
function addBookToInvoiceList(data) {
	// console.log(data);
	$('#hiddenId').val(data.invoiceId);
	var row = $('<tr>');
	row.append($('<td>').addClass('hidden-column').addClass('book-match').text(BOOK + '|' + data.bookId)); // 0
	row.append($('<td class="text-center"><i class="bi bi-book" title="book"></i></td>')); // item
	row.append($('<td class="smaller-table-font">').text(data.name)); // description
	row.append($('<td>'));
	row.append($('<td>'));
	row.append($('<td>'));
	row.append($('<td>'));
	row.append($('<td class="smaller-table-font text-right">').addClass('fee').text(Number(data.price).toFixed(2)));// price
	row.append($('<td>'));
	row.append($('<td>'));
	row.append($('<td>'));
	
	row.append($('<td class="smaller-table-font text-right">').addClass('amount').text(Number(data.price).toFixed(2)));// Total	
	row.append($('<td>').addClass('hidden-column paid').text(0)); // 0	
	row.append($('<td class="smaller-table-font text-center">').text(data.paymentDate));// payment date

	// if data.info is not empty, then display filled icon, otherwise display empty icon	
	isNotBlank(data.info) ? row.append($("<td class='col-1 memo text-center'>").html('<i class="bi bi-chat-square-text-fill text-primary" title="Internal Memo" onclick="displayAddInfo(' + 'BOOK' + ', ' +  data.id + ', \'' + data.info + '\')"></i>')) : row.append($("<td class='col-1 memo text-center'>").html('<i class="bi bi-chat-square-text text-primary" title="Internal Memo" onclick="displayAddInfo(' + 'BOOK' + ', ' +  data.id + ', \'\')"></i>'));	
	// if any existing row's invoice-match value is same as the new row's invoice-match value, then remove the existing row
	$('#invoiceListTable > tbody > tr').each(function() {
		if ($(this).find('.book-match').text() === row.find('.book-match').text()) {
			$(this).remove();
		}
	});

	$('#invoiceListTable > tbody').prepend(row);
	// update Receivable Amount
	updateReceivableAmount();
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Remove Enrolemnts from invoiceListTable
//////////////////////////////////////////////////////////////////////////////////////////////////////
function removeEnrolmentFromInvoiceList() {
	$('#invoiceListTable > tbody > tr').each(function() {
		var hiddens = $(this).find('.enrolment-match').text();
		if(hiddens.indexOf('|') !== -1){
			var hiddenValues = hiddens.split('|');
			//console.log(hiddenValues[1]);
			if(hiddenValues[0] === ENROLMENT){
				$(this).remove();
			}
		}
	});
	// update Receivable Amount
	updateReceivableAmount();
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Remove Books from invoiceListTable
//////////////////////////////////////////////////////////////////////////////////////////////////////
function removeBookFromInvoiceList() {
	$('#invoiceListTable > tbody > tr').each(function() {
		var hiddens = $(this).find('.book-match').text();
		if(hiddens.indexOf('|') !== -1){
			var hiddenValues = hiddens.split('|');
			//console.log(hiddenValues[1]);
			if(hiddenValues[0] === BOOK){
				$(this).remove();
			}
		}
	});
	// update Receivable Amount
	updateReceivableAmount();
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Update Outstanding Amount
//////////////////////////////////////////////////////////////////////////////////////////////////////
function updateOutstandingAmount(){
	//debugger;
	// reset rxAmount
	$("#rxAmount").text('0.00');
	// find the value of amount in the first row
	var amountValue = $('#invoiceListTable > tbody > tr:first').find('.amount').text();
	// set the value of outstanding amount
	$("#rxAmount").text(parseFloat(amountValue).toFixed(2));
	var rxAmount = parseFloat($("#rxAmount").text());
	if (rxAmount <= 0) {
		$('#paymentBtn').prop('disabled', true);
	}else{
		$('#paymentBtn').prop('disabled', false);
	}

}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Update Receivable Amount
//////////////////////////////////////////////////////////////////////////////////////////////////////
function updateReceivableAmount(){
	//debugger;
	var totalAmount = 0;
	var totalPaid = 0;
	// find the value of all amount cells
	$('#invoiceListTable > tbody > tr').each(function() {
		var amount = parseFloat($(this).find('.amount').text());
		var paid = parseFloat($(this).find('.paid').text());
		totalAmount += amount;
		totalPaid += paid;
	});
	var difference = (totalAmount - totalPaid).toFixed(2);	
	// if amount - paid < 0, then amount is 0
	if (difference <= 0) {	
		// full paid so nothing to add
		$('#paymentBtn').prop('disabled', true);
	}else{
		totalAmount = parseFloat(difference);
		$('#paymentBtn').prop('disabled', false);
	}
	$("#rxAmount").text(difference);
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
	$("#payRxAmount").val(parseFloat(rxAmount));
	$("#payAmount").val($("#payRxAmount").val());
  
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
function displayPaymentInfoInNewTab(paymentType){
  var invoiceId = $('#hiddenId').val();
  var studentId = $('#formId').val();
  var firstName = $('#formFirstName').val();
  var lastName = $('#formLastName').val();
  var url = '/' + paymentType + '?invoiceId=' + invoiceId + '&studentId=' + studentId + '&firstName=' + firstName + '&lastName=' + lastName;  
  var win = window.open(url, '_blank');
  win.focus();
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Make Payment
//////////////////////////////////////////////////////////////////////////////////////////////////////
function makePayment(){
	var studentId = $('#formId').val();
	
	var payment = {
		amount: $('#payAmount').val(),
		method: $('#payItem').val(),
		registerDate: $('#payDate').val(),
		info: $('#payInfo').val()
	};
	
	$.ajax({
		url : '${pageContext.request.contextPath}/invoice/payment/' + studentId,
		type : 'POST',
		dataType : 'json',
		data : JSON.stringify(payment),
		contentType : 'application/json',
		success : function(response) {
			$.each(response, function(index, value){
				// debugger;
				if (value.hasOwnProperty('extra')) {
					// It is an EnrolmentDTO object
					addEnrolmentToInvoiceList(value);
				}else if (value.hasOwnProperty('remaining')) {
					// It is an OutstandingDTO object
					addOutstandingToInvoiceList(value);
				}else{
					// It is a BookDTO object
					addBookToInvoiceList(value);
				}
			});
			// reset payment dialogue info
			document.getElementById('makePayment').reset();
			$('#paymentModal').modal('toggle');	
			// display receipt
			displayPaymentInfoInNewTab('receipt');
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
	// console.log('create invoice hidden : ' + hidden);

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
			$("#invoiceTotal").val(invoice.amount);
			$("#invoiceRegisterDate").val(invoice.registerDate);
            $('#invoiceModal').modal('toggle');		
		},
		error : function(xhr, status, error) {
			console.log('Error : ' + error);
		}
	});	
					
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Display Invoice Dialogue With Information
//////////////////////////////////////////////////////////////////////////////////////////////////////
function displayInvoiceInformation(){
	var studentId = $('#formId').val();
	$.ajax({
		url : '${pageContext.request.contextPath}/invoice/getInfo/' + studentId,
		type : 'GET',
		success : function(response) {
			// assign info into invoiceInfo
			// console.log(response);
			document.getElementById('invoiceInfo').value = response;
			// show invoice dialogue
			$('#invoiceModal').modal('toggle');
		},
		error : function(xhr, status, error) {
			console.log('Error : ' + error);
		}
	});	
				
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Issue Latest Invoice
//////////////////////////////////////////////////////////////////////////////////////////////////////
function issueInvoice(){
	var studentId = $('#formId').val();
	var info = $('#invoiceInfo').val();
	let encodeInfo = encodeDecodeString(info).encoded;

	$.ajax({
		url : '${pageContext.request.contextPath}/invoice/issue/' + studentId,
		type : 'POST',
		data : encodeInfo,
		contentType : 'application/json',
		success : function(response) {
			// flush old data in the dialogue
			document.getElementById('showInvoice').reset();
			// disappear invoice dialogue
			$('#invoiceModal').modal('toggle');
			// show invoice in another tab
			displayPaymentInfoInNewTab('invoice');
		},
		error : function(xhr, status, error) {
			console.log('Error : ' + error);
		}
	});	
				
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Display Add Modal
//////////////////////////////////////////////////////////////////////////////////////////////////////
function displayAddInfo(dataType, dataId, dataInfo){
    // console.log('displayAddInfo dataType : ' + dataType + ', dataId : ' + dataId);
	document.getElementById("infoDataType").value = dataType;
	document.getElementById("infoDataId").value = dataId;
	document.getElementById("information").value = dataInfo;
	// display Receivable amount
    $('#infoModal').modal('toggle');
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
//		Add Information
//////////////////////////////////////////////////////////////////////////////////////////////////////
function addInformation(){
	var dataType = $('#infoDataType').val();
	var dataId = $('#infoDataId').val();
	var info = $('#information').val();
	
	let encodeInfo = encodeDecodeString(info).encoded;
	// console.log('addInformation check : ' + encodeInfo);

	$.ajax({
		url : '${pageContext.request.contextPath}/invoice/updateInfo/' + dataType + '/' + dataId,
		type : 'POST',
		data : encodeInfo,
		contentType : 'application/json',
		success : function(response) {
			// console.log('addInformation response : ' + response);
			// flush old data in the dialogue
			document.getElementById('showInformation').reset();
			// disappear information dialogue
			$('#infoModal').modal('toggle');
			//debugger;
			// update memo <td> in invoiceListTable 
			$('#invoiceListTable > tbody > tr').each(function() {
					if(dataType === ENROLMENT){
						if ($(this).find('.enrolment-match').text() === (dataType + '|' + dataId)) {
							(isNotBlank(info)) ? $(this).find('.memo').html('<i class="bi bi-chat-square-text-fill text-primary" title="Internal Memo" onclick="displayAddInfo(ENROLMENT, ' + dataId + ', \'' + encodeInfo + '\')"></i>') : $(this).find('.memo').html('<i class="bi bi-chat-square-text text-primary" title="Internal Memo" onclick="displayAddInfo(ENROLMENT, ' + dataId + ', \'\')"></i>');		
						}
					}else if(dataType === OUTSTANDING){
						if ($(this).find('.outstanding-match').text() === (dataType + '|' + dataId)) {
							(isNotBlank(info)) ? $(this).find('.memo').html('<i class="bi bi-chat-square-text-fill text-primary" title="Internal Memo" onclick="displayAddInfo(OUTSTANDING, ' + dataId + ', \'' + encodeInfo + '\')"></i>') : $(this).find('.memo').html('<i class="bi bi-chat-square-text text-primary" title="Internal Memo" onclick="displayAddInfo(OUTSTANDING, ' + dataId + ', \'\')"></i>');
						}
					}else if(dataType === BOOK){
						if ($(this).find('.book-match').text() === (dataType + '|' + dataId)) {
							(isNotBlank(info)) ? $(this).find('.memo').html('<i class="bi bi-chat-square-text-fill text-primary" title="Internal Memo" onclick="displayAddInfo(BOOK, ' + dataId + ', \'' + encodeInfo + '\')"></i>') : $(this).find('.memo').html('<i class="bi bi-chat-square-text text-primary" title="Internal Memo" onclick="displayAddInfo(BOOK, ' + dataId + ', \'\')"></i>');
						}
					}
				}
			);
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
							<p>Balance :</p>
						</div>
						<div class="col-md-2">
							<p><mark><strong class="text-danger" id="rxAmount" name="rxAmount">0.00</strong></mark></p>
						</div>
					</div>
				</div>
				<div class="col md-auto">
					<!-- <button type="button" class="btn btn-block btn-primary btn-sm"  data-toggle="modal" data-target="#paymentModal">Payment</button> -->
					<button type="button" class="btn btn-block btn-primary btn-sm" id="paymentBtn" onclick="displayPayment()">Payment</button>
				</div>
				<div class="col md-auto">
					<!-- <button type="button" class="btn btn-block btn-primary btn-sm"  data-toggle="modal" data-target="#invoiceModal">Invoice</button>  -->
					<button type="button" class="btn btn-block btn-primary btn-sm" id="invoiceBtn" onclick="displayInvoiceInformation()">Invoice</button>
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
									<th class="smaller-table-font text-center">Item</th>
									<th class="smaller-table-font text-center">Description</th>
									<th class="smaller-table-font text-center">Year</th>
									<th class="smaller-table-font text-center">Start</th>
									<th class="smaller-table-font text-center">End</th>
									<th class="smaller-table-font text-center">Wks</th>
									<th class="smaller-table-font text-center">Price</th>
									<th class="smaller-table-font text-center">Credit</th>
									<th class="smaller-table-font text-center">DC%</th>
									<th class="smaller-table-font text-center">DC$</th>
									<th class="smaller-table-font text-center">Amount</th>
									<th class="smaller-table-font text-center">Date</th>
									<th class="smaller-table-font text-center" data-orderable="false">Note</th>
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
				<header class="text-primary font-weight-bold">Invoice</header>
				<br>
				The following message will appear on the invoice.
				<form id="showInvoice">
					<div class="form-row mt-4">
						<div class="col-md-12">
							<textarea class="form-control" id="invoiceInfo" name="invoiceInfo" style="height: 8rem;"></textarea>
						</div>
					</div>
					<!-- <input type="hidden" id="invoId" name="invoId"></input> -->
					<div class="d-flex justify-content-end mt-4">
						<button type="button" class="btn btn-primary" onclick="issueInvoice()">OK</button>&nbsp;&nbsp;
						<button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="document.getElementById('showInvoice').reset();">Cancel</button>
					</div>
				</form>	
				</section>
			</div>
		</div>
	</div>
</div>

<!-- Info Dialogue -->
<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<section class="fieldset rounded border-primary">
				<header class="text-primary font-weight-bold">Information</header>
				<br>
				Please Add Internal Information
				<form id="showInformation">
					<div class="form-row mt-4">
						<div class="col-md-12">
							<textarea class="form-control" id="information" name="information" style="height: 8rem;"></textarea>
						</div>
					</div>
					<input type="hidden" id="infoDataType" name="infoDataType"></input>
					<input type="hidden" id="infoDataId" name="infoDataId"></input>
					<div class="d-flex justify-content-end mt-4">
						<button type="button" class="btn btn-primary" onclick="addInformation()">Save</button>&nbsp;&nbsp;
						<button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="document.getElementById('showInformation').reset();">Cancel</button>
					</div>
				</form>	
				</section>
			</div>
		</div>
	</div>
</div>


<!-- Bootstrap Editable Table JavaScript -->
<script src="${pageContext.request.contextPath}/js/bootstrap-table.min.js"></script>
		