<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.List" %>
<%@ page import="hyung.jin.seo.jae.dto.EnrolmentDTO" %>
<%@ page import="hyung.jin.seo.jae.utils.JaeConstants" %>

<%
   String invoiceId = request.getParameter("invoiceId");
   String studentId = request.getParameter("studentId");
   String grade = request.getParameter("grade");
   String firstName = request.getParameter("firstName");
   String lastName = request.getParameter("lastName");
%>



<style type="text/css" media="print">
    * {
        -webkit-print-color-adjust: exact !important; /* Chrome, Safari */
        color-adjust: exact !important; /*Firefox*/
    }

    @page {
        /* 크롬등 인쇄시 페이지번호, 주소 숨김*/
        size: auto;
        margin: 0mm;
    }

    @media print {

        .no-print, .no-print * {
            display: none !important;
        }

        body {
            padding-top: 30mm;
        }

        table {
            page-break-after: auto
        }

        tr {
            page-break-inside: avoid;
            page-break-after: auto
        }

        td {
            page-break-inside: avoid;
            page-break-after: auto
        }

        thead {
            display: table-header-group
        }

        tfoot {
            display: table-footer-group
        }
    }
</style>
<!-- <link href="/Content/assets/james/spinner.css" rel="stylesheet" /> -->
<div class="toolbar no-print">
    <div class="text-right pt-3">

<form action="/ADM/InvoicePdfV2" id="InvoiceForm" method="post" name="InvoiceForm"><input id="InvoiceType" name="InvoiceType" type="hidden" value="D" /><input id="StudentNo" name="StudentNo" type="hidden" value="990088" /><input id="FromDate" name="FromDate" type="hidden" value="" /><input id="ToDate" name="ToDate" type="hidden" value="" /><input id="Grade" name="Grade" type="hidden" value="" /><input id="Head" name="Head" type="hidden" value="Victoria" /><input id="BranchCode" name="BranchCode" type="hidden" value="99" /><input data-val="true" data-val-number="The field JobIdx must be a number." data-val-required="The JobIdx field is required." id="JobIdx" name="JobIdx" type="hidden" value="0" /><input id="InvoiceNumber" name="InvoiceNumber" type="hidden" value="98994" /><input id="Desc" name="Desc" type="hidden" value="" />                
            <button id="emailInvoice" class="btn btn-primary" type="button"><i class="fa fa-envelope"></i> Email</button>
            <button id="printInvoice" class="btn btn-success" type="button"><i class="fa fa-print"></i> Print</button>
            <button class="btn btn-warning" type="button" id="btnPdf"><i class="fa fa-file-pdf-o"></i> Export as PDF</button>
            <button class="btn btn-info" type="button" id="btnDocx"><i class="fa fa-file-word-o"></i> Export as DOCX</button>
</form>    </div>
 
</div>
<div class="loading" id="lySpinner" style="display:none;">Loading&#8230;</div>

<div id="invoice">
    <style>
        /* Style Definitions */
        p.MsoNormal, li.MsoNormal, div.MsoNormal {
            margin: 0cm;
            margin-bottom: .0001pt;
            font-size: 10.0pt;
            font-family: "Times New Roman",serif;
        }

        h1 {
            margin-top: 0cm;
            margin-right: -37.95pt;
            margin-bottom: 0cm;
            margin-left: 0cm;
            margin-bottom: .0001pt;
            text-align: center;
            page-break-after: avoid;
            background: black;
            font-size: 18.0pt;
            font-family: "Times New Roman",serif;
        }

        h2 {
            margin: 0cm;
            margin-bottom: .0001pt;
            page-break-after: avoid;
            border: none;
            padding: 0cm;
            font-size: 16.0pt;
            font-family: "Arial Rounded MT Bold",sans-serif;
            font-weight: normal;
        }

        h3 {
            margin-top: 0cm;
            margin-right: 4.2pt;
            margin-bottom: 0cm;
            margin-left: 0cm;
            margin-bottom: .0001pt;
            text-align: center;
            page-break-after: avoid;
            font-size: 18.0pt;
            font-family: "Times New Roman",serif;
        }

        h4 {
            margin-top: 4.0pt;
            margin-right: 4.25pt;
            margin-bottom: 4.0pt;
            margin-left: -2.85pt;
            text-align: center;
            line-height: 13.0pt;
            page-break-after: avoid;
            font-size: 12.0pt;
            font-family: "Arial",sans-serif;
        }

        h5 {
            margin-top: 2.0pt;
            margin-right: 4.25pt;
            margin-bottom: 2.0pt;
            margin-left: 0cm;
            text-align: justify;
            text-justify: inter-ideograph;
            line-height: 13.0pt;
            page-break-after: avoid;
            font-size: 10.0pt;
            font-family: "Arial",sans-serif;
        }

        h6 {
            margin-top: 0cm;
            margin-right: -37.95pt;
            margin-bottom: 0cm;
            margin-left: 0cm;
            margin-bottom: .0001pt;
            text-align: justify;
            text-justify: inter-ideograph;
            page-break-after: avoid;
            font-size: 11.0pt;
            font-family: "Times New Roman",serif;
        }

        p.MsoHeading7, li.MsoHeading7, div.MsoHeading7 {
            margin-top: 0cm;
            margin-right: 14.2pt;
            margin-bottom: 10.0pt;
            margin-left: 0cm;
            text-align: justify;
            text-justify: inter-ideograph;
            page-break-after: avoid;
            font-size: 14.0pt;
            font-family: "Arial",sans-serif;
            font-weight: bold;
        }

        p.MsoHeading8, li.MsoHeading8, div.MsoHeading8 {
            margin-top: 0cm;
            margin-right: 14.2pt;
            margin-bottom: 10.0pt;
            margin-left: 0cm;
            text-align: justify;
            text-justify: inter-ideograph;
            page-break-after: avoid;
            font-size: 12.0pt;
            font-family: "Arial",sans-serif;
        }

        p.MsoHeading9, li.MsoHeading9, div.MsoHeading9 {
            margin-top: 0cm;
            margin-right: 2.15pt;
            margin-bottom: 10.0pt;
            margin-left: 0cm;
            text-align: right;
            page-break-after: avoid;
            font-size: 12.0pt;
            font-family: "Arial",sans-serif;
        }

        p.MsoNormalIndent, li.MsoNormalIndent, div.MsoNormalIndent {
            margin-top: 0cm;
            margin-right: 0cm;
            margin-bottom: 0cm;
            margin-left: 42.55pt;
            margin-bottom: .0001pt;
            font-size: 10.0pt;
            font-family: "Times New Roman",serif;
        }

        p.MsoCaption, li.MsoCaption, div.MsoCaption {
            margin: 0cm;
            margin-bottom: .0001pt;
            text-align: center;
            font-size: 14.0pt;
            font-family: "Book Antiqua",serif;
            font-weight: bold;
        }

        p.MsoDocumentMap, li.MsoDocumentMap, div.MsoDocumentMap {
            margin: 0cm;
            margin-bottom: .0001pt;
            background: navy;
            font-size: 10.0pt;
            font-family: "Tahoma",sans-serif;
        }

        div.WordSection1 {
            page: WordSection1;
        }

        ol {
            margin-bottom: 0cm;
        }

        ul {
            margin-bottom: 0cm;
        }

        td {
            font-family: "Arial",sans-serif;
            font-size: 13px;
        }

        body {
            overflow-x: hidden;
        }

        table {
            width: 100%;
            border: 0.5px solid #444444;
            border-collapse: collapse;
        }

        th, td {
            border: 0.5px solid #444444;
        }
    </style>


    <div class="invoice WordSection1" style="min-width: 1080px; padding-top: 35px; padding-bottom: 35px; font-family: 'arial',sans-serif;">
        <table style="width: 90%; margin: 0 auto; border-collapse: collapse; table-layout: fixed; border: 0; color: #444;">
            <tr>
                <td style="vertical-align: middle; padding: 35px 0; text-align: left; font-family: 'arial', sans-serif; font-size: 35px; color:#3f4254; font-weight: 700 !important;background: none; border: 0;">RECEIPT</td>
                <td style="width: 450px; padding: 35px 0; vertical-align: middle; border: 0;">
                    <img style="width:450px; vertical-align: top;" src="https://jacelearning.com/Content/invoicelogo.jpg" alt="JAC" />
                    <p style="margin-top: 8px; font-size: 13px;font-weight:600;line-height:1.5">
                        0393610051
                        <br />16c 77-79 Ashley St
                        <br /><span style="font-weight:900;font-size:14px;">ABN ABN 123123123</span>
                    </p>
                </td>
            </tr>
        </table>

        <table style="width: 90%; margin: 0 auto 10px; border-collapse: collapse; table-layout: fixed; border: 0; color: #444;">
            <tr>
                <td style="width: 100px; font-size: 16px; line-height: 2; vertical-align: middle; text-align: left; font-family: 'arial', sans-serif; font-weight: bold; background: none; border: 0;">Date : </td>
                <td style="font-size: 16px; line-height: 2; vertical-align: middle; text-align: left; font-family: 'arial', sans-serif; background: none; border: 0;font-weight: 600 !important;">03/07/2023</td>
                <td style="width: 100px; font-size: 16px; line-height: 2; vertical-align: middle; text-align: left; font-family: 'arial', sans-serif; font-weight: bold; background: none; border: 0;">Due Date : </td>
                <td style="font-size: 16px; line-height: 2; vertical-align: middle; text-align: left; font-family: 'arial', sans-serif; background: none; border: 0;font-weight: 600 !important;">03/07/2023</td>
            </tr>
            <tr>
                <td style="width: 100px; font-size: 16px; line-height: 2; vertical-align: middle; text-align: left; font-family: 'arial', sans-serif; font-weight: bold; background: none; border: 0;">Name : </td>
                <td style="font-size: 16px; line-height: 2; vertical-align: middle; text-align: left; font-family: 'arial', sans-serif; background: none; border: 0;font-weight: 600 !important;"><strong><%= firstName %> <%= lastName %></strong></td>
                <td style="width: 100px; font-size: 16px; line-height: 2; vertical-align: middle; text-align: left; font-family: 'arial', sans-serif; font-weight: bold; background: none; border: 0;">Grade : </td>
                <td style="font-size: 16px; line-height: 2; vertical-align: middle; text-align: left; font-family: 'arial', sans-serif; background: none; border: 0;font-weight: 600 !important;"><%= grade.toUpperCase() %></td>
            </tr>
            <tr>
                <td style="width: 100px; font-size: 16px; line-height: 2; vertical-align: middle; text-align: left; font-family: 'arial', sans-serif; font-weight: bold; background: none; border: 0;">Student ID : </td>
                <td style="font-size: 16px; line-height: 2; vertical-align: middle; text-align: left; font-family: 'arial', sans-serif; background: none; color:#a1a5b7;border: 0;font-weight: 600 !important;"><%= studentId %></td>
                <td style="width: 100px; font-size: 16px; line-height: 2; vertical-align: middle; text-align: left; font-family: 'arial', sans-serif; font-weight: bold; background: none; border: 0;">Invoice No : </td>
                <td style="font-size: 16px; line-height: 2; vertical-align: middle; text-align: left; font-family: 'arial', sans-serif; background: none; border: 0;font-weight: 600 !important;"><%= invoiceId %></td>
            </tr>
        </table>

        <table style="width: 90%; margin: 0 auto; padding: 0; border-collapse: collapse; table-layout: fixed; border: 2px solid #444; color: #444;">
            <colgroup>
                <col style="width:25%;">
                <col style="width:auto">
                <col style="width:10%;">
                <col style="width:15%;">
                <col style="width:10%;">
                <col style="width:15%;">
            </colgroup>
            <thead>
                <tr>
                    <th rowspan="2" style="width:25%; height: 40px; padding: 10px 5px; text-align: center; font-size: 14px; font-weight: normal; border: 1px solid #444; border-bottom-style:double;border: 1px solid #444;">Course and book</th>
                    <th rowspan="2" style="width: auto; height: 40px; padding: 10px 5px; text-align: center; font-size: 14px; font-weight: normal; border: 1px solid #444;border-bottom-style:double;">Period</th>
                    <th colspan="2" style="height: 40px; width:25%; padding: 10px 5px; text-align: center; font-size: 14px; font-weight: normal; border: 1px solid #444;">Fee (Incl.GST)</th>
                    <th rowspan="2" style="width:10%; height: 40px; padding: 10px 5px; text-align: center; font-size: 14px; font-weight: normal; border: 1px solid #444;border-bottom-style:double;">Discount</th>
                    <th rowspan="2" style="width:15%; height: 40px; padding: 10px 5px; text-align: center; font-size: 14px; font-weight: normal; border: 1px solid #444;border-bottom-style:double;">Subtotal<br />(Incl.GST)</th>
                </tr>
                <tr>
                    <th style="width:12%; height: 40px; padding: 10px 5px; text-align: center; font-size: 14px; font-weight: normal; border: 1px solid #444;border-bottom-style:double;">Weeks<br>(Qty)</th>
                    <th style="width:12%; height: 40px; padding: 10px 5px; text-align: center; font-size: 14px; font-weight: normal; border: 1px solid #444;border-bottom-style:double;">Weekly fee<br>(Unit price)</th>
                </tr>
            </thead>
            <tbody>
               
                <%-- Check if payments attribute exists in session --%>
                <c:if test="${not empty sessionScope.payments}">
                    <%-- Retrieve the payments from session --%>
                    <c:set var="payments" value="${sessionScope.payments}" />
                    <c:forEach items="${payments}" var="payment">
                        <tr>
                            <td style='height: 40px; padding: 10px 5px; text-align: center; font-size: 14px; font-weight: bold; border: 1px solid #444;'>[ <c:out value="${fn:toUpperCase(payment.grade)}" /> ] <c:out value="${payment.name}" /></td>
                            <td style='height: 40px; padding: 10px 5px; text-align: center; font-size: 14px; font-weight: bold; border: 1px solid #444;'><c:out value="${payment.grade}" /></td>
                            <td style='height: 40px; padding: 10px 5px; font-size: 14px; font-weight: bold; border: 1px solid #444; text-align: right;'><c:out value="${payment.endWeek-payment.startWeek}" /></td>
                            <td style='height: 40px; padding: 10px 5px; font-size: 14px; font-weight: bold; border: 1px solid #444; text-align: right;'><c:out value="${payment.price}" /></td>
                            <td style='height: 40px; padding: 10px 5px; font-size: 14px; font-weight: bold; border: 1px solid #444; text-align: right;'><c:out value="${payment.discount}" /></td>
                            <td style='height: 40px; padding: 10px 5px; font-size: 14px; font-weight: bold; border: 1px solid #444; text-align: right;'><c:out value="${payment.amount}" /></td>
                        </tr>
                    </c:forEach>
                </c:if>

                <tr><td colspan='5' style='height: 40px; padding: 10px 5px; font-size: 14px; font-weight: bold; border: 1px solid #444; text-align: left;'>OS(692.00)</td><td style='height: 40px; padding: 10px 5px; font-size: 14px; font-weight: bold; border: 1px solid #444; text-align: right;'>692.00</td></tr>
                <tr>
                    <td colspan='6' style='height: 40px; padding: 10px 5px; font-size: 14px; font-weight: bold; border: 1px solid #444; text-align: left;'><b>Other Information</b>, Paid Date :  02/07/2023</td>
                </tr>
                <tr>
                    <td colspan='6' style='height: 40px; padding: 10px 5px; font-size: 14px; font-weight: bold; border: 1px solid #444; text-align: left;'></td>
                </tr>

            </tbody>
        </table>

        <table style="width: 90%; margin: 50px auto 0; text-align: right; border-collapse: collapse; table-layout: fixed; border: 0; color: #444;">
            <tr>
                <td style="height: 32px; font-size: 15px; line-height: 1.5; vertical-align: top; text-align: right; font-weight: bold; font-family: 'arial', sans-serif; border: 0;font-weight: 600 !important;">FINAL TOTAL</td>
                <td style="height: 32px; width: 100px; font-size: 15px; line-height: 1.5; vertical-align: top; text-align: center; color: #bdbdbd; font-style: normal; font-family: 'arial', sans-serif; border: 0;">$</td>
                <td style="height: 32px; width: 130px; font-size: 15px; line-height: 1.5; vertical-align: top; text-align: right; font-family: 'arial', sans-serif; border: 0;"><strong>692.00</strong></td>
            </tr>
            <!--<tr>
                <td style="height: 32px; font-size: 15px; line-height: 1.5; vertical-align: top; text-align: right; font-weight: bold; font-family: 'arial', sans-serif; border: 0;font-style: italic;">D.S Count</td>
                <td style="height: 32px; width: 100px; font-size: 15px; line-height: 1.5; vertical-align: top; text-align: center; color: #bdbdbd; font-style: normal; font-family: 'arial', sans-serif; border: 0;">$</td>
                <td style="height: 32px; width: 130px; font-size: 15px; line-height: 1.5; vertical-align: top; text-align: right; font-family: 'arial', sans-serif; border: 0;"><strong>{{ICT_DC}}</strong></td>
            </tr>-->
            <tr>
                <td style="height: 32px; font-size: 15px; line-height: 1.5; vertical-align: top; text-align: right; font-weight: bold; font-family: 'arial', sans-serif; border: 0;font-weight: 600 !important;">FEE PAID</td>
                <td style="height: 32px; width: 100px; font-size: 15px; line-height: 1.5; vertical-align: top; text-align: center; color: #bdbdbd; font-style: normal; font-family: 'arial', sans-serif; border: 0;">$</td>
                <td style="height: 32px; width: 130px; font-size: 15px; line-height: 1.5; vertical-align: top; text-align: right; font-family: 'arial', sans-serif; border: 0;">9.00</td>
            </tr>
            <tr>
                <td style="height: 32px; font-size: 15px; line-height: 1.5; vertical-align: top; text-align: right; font-weight: bold; font-family: 'arial', sans-serif; border: 0;font-weight: 600 !important;">BALANCE</td>
                <td style="height: 32px; width: 100px; font-size: 15px; line-height: 1.5; vertical-align: top; text-align: center; color: #bdbdbd; font-style: normal; font-family: 'arial', sans-serif; border: 0;">$</td>
                <td style="height: 32px; width: 130px; font-size: 15px; line-height: 1.5; vertical-align: top; text-align: right; font-family: 'arial', sans-serif; border: 0;">683.00</td>
            </tr>
        </table>

        <table style="width: 90%; margin: 150px auto 10px; text-align: left; border-collapse: collapse; table-layout: fixed; border: 0; color: #444;">
            <!--<tr>
                <td style="font-size: 14px; line-height: 1.6; font-weight: bold; border: 0;">
                    <p style="margin: 0; padding: 0; line-height: 1.8;">• Payment Options : CASH / EFTPOS (50 cents Surcharge) / CREDIT CARD (1.5% Surcharge) / Bank Transfer</p>
                    <p style="margin: 0; padding: 0; line-height: 1.8;">• Bank Details : {{ICT_BANKDETAILS}}</p>
                </td>
            </tr>-->
        </table>
        <table style="width: 90%; margin: 0 auto; text-align: left; border-collapse: collapse; table-layout: fixed; border: 1px solid #444; color: #444;">
            <tr>
                <td style=" padding: 10px 10px 0; border: 0;"><strong style="font-size: 16px;font-style: italic;">Note : </strong></td>
            </tr>

            <tr>
                <td style="font-size: 15px; line-height: 1.6; border: 0; padding: 0 10px 10px;">
                    <p style="margin: 0; padding: 0; line-height: 1.8;">1.5% surcharge on credit card payment<br />0.5% surcharge on EFTPOS payment<br /><br />Test test test<br />Bank transfer<br />123-456<br />1234 5678</p>
                </td>
            </tr>
        </table>
    </div>
</div>

<script>
    $('#printInvoice').click(function () {
        var html = $('.invoice')[0].outerHTML;
        var htmljac = html.replace('TAX INVOICE', 'TAX INVOICE(JAC)');
        var htmlstudent = html.replace('TAX INVOICE', 'TAX INVOICE Receipt(Student)');

        Popup(htmljac);

        //Popup(htmljac +"<div style='page-break-before:always;height:150px;'></div>" + htmlstudent);
        function Popup(data) {

            var mywindow = window.open('', 'PRINT', 'height=800,width=900');
            mywindow.document.write(data);

            mywindow.document.close();
            mywindow.focus();

            mywindow.print();
            mywindow.close();

            return true;
        }
    });


    $('#btnPdf').click(function () {
        $('#InvoiceForm').attr('action', '/ADM/InvoicePdfV2');
        $('#InvoiceForm').submit();
    });

    $('#btnDocx').click(function () {
        $('#InvoiceForm').attr('action', '/ADM/InvoiceWordV2');
        $('#InvoiceForm').submit();
    });

    $('#emailInvoice').click(function () {
        $("#lySpinner").show();
        $.ajax({
            type: "POST",
            url: "/ADM/InvoiceSendEmail",
            data: $('#InvoiceForm').serialize(),
            //contentType: "application/json; charset=utf-8",
            //dataType: "json",
            success: function (response) {
                if (response.success === true) {
                    alert('Transfer Completed');
                    $("#lySpinner").hide();
                }
                else {
                    alert(response.msg);
                    $("#lySpinner").hide();
                }
            },
            error: function (xhr) {
                alert('Transfer Failed.');
                $("#lySpinner").hide();
                //jqxAlert.alert("Something seems Wrong in Deleting your data.");
            }
        });
    });

</script>