<html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>

<%@page import="org.apache.commons.lang.StringUtils"%>
<head>
<style type="text/css">
.bill-info-td{
color: #fff;
}

</style>

      <!-- END: HEADER -->
      <div id="page-title" style="display: none;">
        <h3>
          <marquee behavior="scroll" direction="left" style="color: #333333;">
          Welcome to Gowthami Handlooms...
          </marquee>
        </h3>
      </div>
    </div>
  </div>
</div>
<div>
  <style type="text/css">
.bill-info-td{
color: #fff;
}

</style>
  <style>
	.highlight {background-color: #F00; color: #FFF;}
	.highlight a {color: #FFF;}
	#thenavigation li {display: inline; padding: 0 10px;}
	#thenavigation li a {text-decoration: none;}
	ul.table-list{background:#ffffff;}
	ul.table-list > li {color:black;}
	.block{font-weight: bold;}
	.table-list-blk{margin-bottom:0%;}	
	.billinfo-table td{color:black; font-weight:bold;}
	#sNoId{color:black;}
</style>
  <link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico">
  <link href="css/billcss.css" rel="stylesheet" type="text/css" media="all">
  <link href="css/printstyle.css" rel="stylesheet" type="text/css" media="all">
  <!-- <script type="text/javascript" src="./eBilling1_files/jquery.min(1).js"></script> 
  <script src="./eBilling1_files/jquery-ui.js"></script>  -->
  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script type="text/javascript">
var billInfo = '${sessionScope.printBillVal}';
var unBill = '${sessionScope.printUnBillVal}';
$(document).ready(function() {
	console.log("unbill: "+ unBill);
	console.log("billInfo: "+ billInfo);
	if(billInfo != ""){
		showBillDetailsData(billInfo);
		showPrintData(billInfo);	
	}
	if(unBill != ""){
		//alert(unBill);
		showUnBillDetailsData(JSON.parse(unBill));
		//showUnBIllPrintData(unBill);
	}
	
});

function showBillDetailsData(response){
	$("#userData ul").remove();
	$("#userData ul li").remove(); 
	serviceUnitArray = {};
	response = jQuery.parseJSON(response);
	var i=0;
	if(response != undefined && response.length > 0){
		var resBillInfo = response[0].listBillingDeteails;
		//purchaseArr = response[0].listPurchase;
		if(resBillInfo != null){
			$.each(resBillInfo,function(i, catObj) {
				serviceUnitArray[catObj.billDetailsId] = catObj;
				 var tblRow ="<ul class=''>"
					 	+ "<li class='five-box' style='width:6%;'>"
						+ (i+1)
						+"</li>"
						+ "<li class='bil-prod-box' style='width:75%;' title='"+catObj.productName+"'>"
						+ catObj.productName.toUpperCase()
						+ "</li>"
						+ "<li class='five-box' style='width:20%;' title='"+catObj.mrp+"'>"
						+ catObj.mrp
						+ "</li>"
						+ "<li class='five-box' style='width:20%;' title='"+catObj.quantity+"'>"
						+ catObj.quantity
						+ "</li>"
						+ "<li class='five-box' style='width:20%;' title='"+catObj.rate+"'>"
						+ catObj.rate
						+ "</li>"
						+ "<li class='five-box' style='width:20%; text-align: right;' title=' title='"+catObj.amount+"'>"
						+ catObj.amount
						+ "</li>"
						+"</ul>";
				$(tblRow).appendTo("#userData"); 
			});
		}
    	 $('#totalMrpDisp').text(response[0].totalMrp);
    	 $('#totalQuantityDisp').text(response[0].totalQuantity);
    	 $('#totalRateDisp').text(response[0].totalRate);
    	 $('#totalAmountDisp').text(response[0].totalAmount);
	}
	//paginationTable(3);
}

function showPrintData(response){
	serviceUnitArray = {};
	response = jQuery.parseJSON(response);
	if(response != undefined && response.length >0){
	$.each(response,function(i, catObj) {
		//alert('catObj.billId=='+catObj.billId);
		$('#billNo').text(catObj.billNo);
		$('#billDate').text(catObj.billDate);
		 $('#lrNo').text(catObj.lrNo);
		 $('#lrDate').text(catObj.lrDate);
		 $('#orderNo').text(catObj.orderNo);
		 $('#orderDate').text(catObj.orderDate);
		 $('#dispatchedBy').text(catObj.dispatchedBy);
		 $('#noOfPacks').text(catObj.noOfPacks);
		 $('#orderBy').text(catObj.orderBy);
		 $('#packSlipNo').text(catObj.packSlipNo);
		 $('#termsOfPayment').text(catObj.termOfPayment);
		 $('#terms').text(catObj.terms);
		 $('#name').text(catObj.name);
		 $('#discount').text(catObj.discount);
		 $('#phone').text("Phone:"+catObj.phone);
		 $('#address').text(catObj.address);
		 $('#advance').text(catObj.advance);
		 $('#netAmount').text(catObj.netAmount+",");
		 $('#purTinNo').text("TIN:"+catObj.tinNo);
	});
	
	
	
	
	var objArr = JSON.parse(billInfo)
	 for(var i=0;i<objArr.length;i++){
		 netAmount= objArr[i].netAmount;
	 }
	
	numToTxt = parseInt(netAmount);
	
	var options = {
			style : "currency",
			currency : "INR"
		};
		var showAmount = numToTxt.toLocaleString("hi-IN", options);
		$('#netAmount').text(showAmount);
	
	var amtWords = number2text(numToTxt);

	$('#amountinwords').text(amtWords);
	function number2text(value) {
		   var fraction = Math.round(frac(value)*100);
		   var f_text  = "";

		   if(fraction > 0) {
		       f_text = "AND "+convert_number(fraction)+" PAISE";
		   }

		   return convert_number(value)+" RUPEE "+f_text+" ONLY";
		}
	}
	
	function frac(f) {
		   return f % 1;
		}

		function convert_number(number)
		{
		   if ((number < 0) || (number > 999999999)) 
		   { 
		       return "NUMBER OUT OF RANGE!";
		   }
		   var Gn = Math.floor(number / 10000000);  / Crore / 
		   number -= Gn * 10000000; 
		   var kn = Math.floor(number / 100000);     / lakhs / 
		   number -= kn * 100000; 
		   var Hn = Math.floor(number / 1000);      / thousand / 
		   number -= Hn * 1000; 
		   var Dn = Math.floor(number / 100);       / Tens (deca) / 
		   number = number % 100;               / Ones / 
		   var tn= Math.floor(number / 10); 
		   var one=Math.floor(number % 10); 
		   var res = ""; 

		   if (Gn>0) 
		   { 
		       res += (convert_number(Gn) + " CRORE"); 
		   } 
		   if (kn>0) 
		   { 
		           res += (((res=="") ? "" : " ") + 
		           convert_number(kn) + " LAKH"); 
		   } 
		   if (Hn>0) 
		   { 
		       res += (((res=="") ? "" : " ") +
		           convert_number(Hn) + " THOUSAND"); 
		   } 

		   if (Dn) 
		   { 
		       res += (((res=="") ? "" : " ") + 
		           convert_number(Dn) + " HUNDRED"); 
		   } 


		   var ones = Array("", "ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX","SEVEN", "EIGHT", "NINE", "TEN", "ELEVEN", "TWELVE", "THIRTEEN","FOURTEEN", "FIFTEEN", "SIXTEEN", "SEVENTEEN", "EIGHTEEN","NINETEEN"); 
		var tens = Array("", "", "TWENTY", "THIRTY", "FOURTY", "FIFTY", "SIXTY","SEVENTY", "EIGHTY", "NINETY"); 

		   if (tn>0 || one>0) 
		   { 
		       if (!(res=="")) 
		       { 
		           res += " AND "; 
		       } 
		       if (tn < 2) 
		       { 
		           res += ones[tn * 10 + one]; 
		       } 
		       else 
		       { 

		           res += tens[tn];
		           if (one>0) 
		           { 
		               res += ("-" + ones[one]); 
		           } 
		       } 
		   }

		   if (res=="")
		   { 
		       res = "zero"; 
		   } 
		   return res;
		}
	
}
function showUnBillDetailsData(response){
	$("#userData ul").remove();
	$("#userData ul li").remove(); 
	serviceUnitArray = {};
	var i=0;
	if(response != undefined){
		var resBillInfo = response.listBillingInfoCart;
		//purchaseArr = response[0].listPurchase;
		if(resBillInfo != null){
			$.each(resBillInfo,function(i, catObj) {
				serviceUnitArray[catObj.billDetailsId] = catObj;
				 var tblRow ="<ul class=''>"
					 	+ "<li class='five-box' style='width:6%;'  title='"+catObj.billDetailsId+"'>"
						+ (i+1)
						+"</li>"
						+ "<li class='bil-prod-box' style='width:75%;'  title='"+catObj.productName+"'>"
						+ catObj.productName.toUpperCase()
						+ "</li>"
						+ "<li class='five-box' style='width:20%;'  title='"+catObj.mrp+"'>"
						+ catObj.mrp
						+ "</li>"
						+ "<li class='five-box' style='width:20%;'  title='"+catObj.quantity+"'>"
						+ catObj.quantity
						+ "</li>"
						+ "<li class='five-box' style='width:20%;'  title='"+catObj.rate+"'>"
						+ catObj.rate
						+ "</li>"
						+ "<li class='five-box' style='width:20%; text-align: right;'  title='"+catObj.amount+"'>"
						+ catObj.amount
						+ "</li>"
						+"</ul>";
				$(tblRow).appendTo("#userData"); 
			});
		}
    	 $('#totalMrpDisp').text(response.totalMrp);
    	 $('#totalQuantityDisp').text(response.totalQuantity);
    	 $('#totalRateDisp').text(response.totalRate);
    	 $('#totalAmountDisp').text(response.totalAmount);
    	 $('#billNo').text(response.billNo);
    	 $('#billDate').text(response.billDate);
		 $('#lrNo').text(response.lrNo);
		 $('#lrDate').text(response.lrDate);
		 $('#orderNo').text(response.orderNo);
		 $('#orderDate').text(response.orderDate);
		 $('#dispatchedBy').text(response.dispatchedBy);
		 $('#noOfPacks').text(response.noOfPacks);
		 $('#orderBy').text(response.orderBy);
		 $('#packSlipNo').text(response.packSlipNo);
		 $('#termsOfPayment').text(response.termOfPayment);
		 $('#terms').text(response.terms);
		 $('#name').text(response.name);
		 $('#discount').text(response.discount);
		 $('#phone').text("Phone:"+response.phone);
		 $('#address').text(response.address);
		 $('#advance').text(response.advance);
		 $('#netAmount').text(response.netAmount);
		 $('#purTinNo').text("TIN:"+response.tinNo);
		 
		 
	}
	//paginationTable(3);
	
	

	var objArr = JSON.parse(unBill)
	 for(var i=0;i<objArr.length;i++){
		 objArr.netAmount;
	 }
	
	numToTxt = parseInt(objArr.netAmount);
	
	
	
	var options = {
		style : "currency",
		currency : "INR"
	};
	var showAmount = numToTxt.toLocaleString("hi-IN", options);
	$('#netAmount').text(showAmount);
	
	var amtWords = number2text(numToTxt);

	
	
	
	$('#amountinwords').text(amtWords);
	function number2text(value) {
		   var fraction = Math.round(frac(value)*100);
		   var f_text  = "";

		   if(fraction > 0) {
		       f_text = "AND "+convert_number(fraction)+" PAISE";
		   }

		   return convert_number(value)+" RUPEE "+f_text+" ONLY";
		}
	
	
	
	function frac(f) {
		   return f % 1;
		}

		function convert_number(number)
		{
		   if ((number < 0) || (number > 999999999)) 
		   { 
		       return "NUMBER OUT OF RANGE!";
		   }
		   var Gn = Math.floor(number / 10000000);  / Crore / 
		   number -= Gn * 10000000; 
		   var kn = Math.floor(number / 100000);     / lakhs / 
		   number -= kn * 100000; 
		   var Hn = Math.floor(number / 1000);      / thousand / 
		   number -= Hn * 1000; 
		   var Dn = Math.floor(number / 100);       / Tens (deca) / 
		   number = number % 100;               / Ones / 
		   var tn= Math.floor(number / 10); 
		   var one=Math.floor(number % 10); 
		   var res = ""; 

		   if (Gn>0) 
		   { 
		       res += (convert_number(Gn) + " CRORE"); 
		   } 
		   if (kn>0) 
		   { 
		           res += (((res=="") ? "" : " ") + 
		           convert_number(kn) + " LAKH"); 
		   } 
		   if (Hn>0) 
		   { 
		       res += (((res=="") ? "" : " ") +
		           convert_number(Hn) + " THOUSAND"); 
		   } 

		   if (Dn) 
		   { 
		       res += (((res=="") ? "" : " ") + 
		           convert_number(Dn) + " HUNDRED"); 
		   } 


		   var ones = Array("", "ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX","SEVEN", "EIGHT", "NINE", "TEN", "ELEVEN", "TWELVE", "THIRTEEN","FOURTEEN", "FIFTEEN", "SIXTEEN", "SEVENTEEN", "EIGHTEEN","NINETEEN"); 
		var tens = Array("", "", "TWENTY", "THIRTY", "FOURTY", "FIFTY", "SIXTY","SEVENTY", "EIGHTY", "NINETY"); 

		   if (tn>0 || one>0) 
		   { 
		       if (!(res=="")) 
		       { 
		           res += " AND "; 
		       } 
		       if (tn < 2) 
		       { 
		           res += ones[tn * 10 + one]; 
		       } 
		       else 
		       { 

		           res += tens[tn];
		           if (one>0) 
		           { 
		               res += ("-" + ones[one]); 
		           } 
		       } 
		   }

		   if (res=="")
		   { 
		       res = "zero"; 
		   } 
		   return res;
		}
	
	
}


function printBill(){
	//alert('printBill');
	$('#newbill').hide();
	$('#page-title').hide();
	$('#header').hide();
	$('#footer').hide();
	$('#prtBtn').hide();
	
	 window.print();


}
function dataCancel() {
	if(billInfo != ""){
		window.location.href="/gowthami/searchBill";
	}else{
		window.location.href="/gowthami/unBillCart";
	}
}

</script>
  <div>
    <section id="printSec" class="container" style="height:1415px; border:1px #666 solid; padding:10px; border-radius:8px;">
      <div class="block" style="margin-top: 5px;"> 
        <!-- <h2 id="newbill"><span class="icon1">&nbsp;</span>Bill Products</h2> -->
        <form:form name="cf_form" method="post" id="contact-form" commandname="" class="form-horizontal" action="http://localhost:8080/personal/reg#" onsubmit="return validationequiry()">
          <div>
            <div class="header-top header-top-1" style=" height: 100px;">
              <div class="block-1">
                <h1 id="logo"> <a href="http://dovasofttech.com/eBilling/index.html"><img src="images/sai-baba.png" width="97" height="75" alt="" style="padding-left: 1px;"></a> </h1>
              </div>
              <div class="block-2">
                <div class="cname" style="color:#999999; margin-left: 15px;">
                  <div id="companyNameBrand" style="color: black;">Gowthami Handlooms</div>
                  <p class="text-manfact" style="color: black;">House of: Handloom Dress Materials &amp; Sarees</p>
                </div>
              </div>
              <div class="block-4" style="color:black; margin-left: 50px;" >
                <p class="text-prop">Prop: <span>D. Kumaraswamy</span></p>
                <p class="text-address" style="font-size: 12px;">MIG-183, 1st Floor</p>
                <p class="text-address" style="font-size: 12px;">Bharat Nagar Colony</p>
                <p class="text-address" style="font-size: 12px;">Moosapet,Hyderabad - 500 018</p>
                 <!-- <h4 class="text-tin">TIN: <span >36053303269</span></h4> -->
                <%
                
			String showPanNo = (String) session.getAttribute("showPan");   
                //System.out.println("showPanNoshowPanNoshowPanNo==="+showPanNo);
                
                if(StringUtils.isNotEmpty(showPanNo) && showPanNo.equals("1")) {
                	
            %>
            <h4 class="text-tin">TIN: <span>36053303269</span></h4>
            <%
                }
            %>
           
              </div>
              <div class="block-3">
                <div class="mobile-no" style="color:black; margin-right: 5px;">
                  <h5>Mobile: 9246885990
                    <p>9246595990</p>
                    <p>9246959550</p>
                  </h5>
                  <p class="text-email"><span class="label-text">Email:</span> <span><b>gowthamihandlooms@gmail.com</b></span></p>
                </div>
              </div>
              <div class="block-5" style="padding-top:0;width:8%;"> <img class="logo2" src="images/balaji.jpeg" width="90" height="75" alt="" style="padding-left: 1px;"> </div>
            </div>
          </div>
        </form:form>
      </div>
      <div style="clear:both"></div>
      <div style="border:1px #ccc solid; margin-top:75px; margin-bottom:75px; border-radius:8px;">
        <table width="100%">
          <tbody>
            <tr> </tr>
            <tr>
              <td style="" colspan="2"><table border="0" rowspan="0" colspan="0" width="100%">
                  <tbody>
                    <tr>
                      <td style="width: 22%;padding-left: 2%;vertical-align: sub;padding-top: 2%;border:1px solid #cccccc;border-left:0;border-bottom:0;  border-top:0; font-weight:bold; font-size:16px; color: black;"><div id="name">sai </div>
                        <div id="address" style="color: black;"></div>
                        <div id="phone" style="color: black;"></div>
                        <div id="purTinNo" style="margin-top: 10px; color: black;"></div></td>
                      <td style="width: 70%;"><table class="billinfo-table" border="0" rowspan="0" colspan="0" width="100%">
                          <tbody>
                            <tr>
                              <td align="center" class="bill-info-td" colspan="4" style="border-left:0;border-right:0; border-top:0;"><h3>ORIGINAL COPY</h3></td>
                            </tr>
                            <tr>
                              <td class="bill-info-td" style="border-left:0;width:18%;color:black;border-top:0;">BILL NO:</td>
                              <td class="bill-info-td" style="width:35%;"><div id="billNo"></div></td>
                              <td class="bill-info-td">DATE:</td>
                              <td class="bill-info-td" style="border-right:0;"><div id="billDate"></div></td>
                            </tr>
                            <tr>
                              <td class="bill-info-td" style="border-left:0;">LR NO:</td>
                              <td class="bill-info-td"><div id="lrNo"></div></td>
                              <td class="bill-info-td" style="width:18%;">LR DATE:</td>
                              <td class="bill-info-td" style="border-right:0;"><div id="lrDate"></div></td>
                            </tr>
                            <tr>
                              <td class="bill-info-td" style="border-left:0;">ORDER NO:</td>
                              <td class="bill-info-td"><div id="orderNo"></div></td>
                              <td class="bill-info-td">ORDER DATE:</td>
                              <td class="bill-info-td" style="border-right:0;"><div id="orderDate"></div></td>
                            </tr>
                            <tr>
                              <td class="bill-info-td" style="border-left:0;">DISPATCHED BY:</td>
                              <td class="bill-info-td"><div id="dispatchedBy"></div></td>
                              <td class="bill-info-td">NO OF PACKS:</td>
                              <td class="bill-info-td" style="border-right:0;"><div id="noOfPacks"></div></td>
                            </tr>
                            <tr>
                              <td class="bill-info-td" style="border-left:0;">ORDERED BY:</td>
                              <td class="bill-info-td"><div id="orderBy"></div></td>
                              <td class="bill-info-td">PACK SLIP NO:</td>
                              <td class="bill-info-td" style="border-right:0;"><div id="packSlipNo"></div></td>
                            </tr>
                            <tr>
                              <td class="bill-info-td" style="border-bottom:0;border-left:0;">TERMS OF PAYMENT:</td>
                              <td class="bill-info-td" style="border-bottom:0;"><div id="termsOfPayment">cash</div></td>
                              <td class="bill-info-td" style="border-bottom:0;">TERMS</td>
                              <td class="bill-info-td" style="border-right:0 ;border-bottom:0;"><div id="terms"></div></td>
                            </tr>
                          </tbody>
                        </table></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table>
      </div>
      <div style="clear:both"></div>
      <div class="block " style="margin-bottom:75px; float:left;"> 
        <!-- <div class="head-box">
                        <h2><span class="icon2">&nbsp;</span>Bill Products<aside class="block-footer-right sucessfully" id="unc1" style="display:none;">Delete Sucessfully</aside></h2>
                    </div> -->
        <div class="" >
          <ul class="table-list" style="">
            <li class="five-box" style="width:6%;border-bottom:1px solid #cccccc; color:black;">S.No </li>
            <li id="bil-prod-box" style="width:75%;border-bottom:1px solid #cccccc; color:black;">Description </li>
            <li class="five-box" style="width:20%;border-bottom:1px solid #cccccc; color:black;">MRP </li>
            <li class="five-box" style="width:20%;border-bottom:1px solid #cccccc; color:black;">Quantity </li>
            <li class="five-box" style="width:20%;border-bottom:1px solid #cccccc; color:black;">Rate </li>
            <li class="five-box" style="width:20%;border-bottom:1px solid #cccccc;border-right: 0; color:black; text-align: right;">Amount </li>
          </ul>
          <div class="table-list-blk" id="userData" style=" font-size:16px; height:450px;border-bottom: 1px solid burlywood;">
            <!-- <ul class="">
              <li class="five-box" style="width:6%;" title="ba4d9f0ebf274ca7a92fbcda3a580870"></li>
              <li class="bil-prod-box" style="width:75%;">SAREES</li>
              <li class="five-box" style="width:20%;"></li>
              <li class="five-box" style="width:20%;"></li>
              <li class="five-box" style="width:20%;"></li>
              <li class="five-box" style="width:20%; border-right:0;"></li>
            </ul> -->
          </div>
          <div class="table-list-total" id="totalTable ">
            <ul class="table-list" style="">
              <li class="five-box" style="width:6%;">&nbsp;</li>
              <li class="bil-prod-box" style="width:75%; color:black; font-size:20px;"><b>Total</b></li>
              <li class="five-box" style="width:20%;"><b>
                <div id="totalMrpDisp" style="font-size:20px; text-align: right;"></div>
                </b></li>
              <li class="five-box" style="width:20%;"><b>
                <div id="totalQuantityDisp" style="font-size:20px; text-align: right;"></div>
                </b></li>
              <li class="five-box" style="width:20%;"><b>
                <div id="totalRateDisp"style="font-size:20px; text-align: right;"></div>
                </b></li>
              <li class="five-box" style="width:20%;border-right: 0;"><b>
                <div id="totalAmountDisp"style="font-size:20px; text-align:right;"></div>
                </b></li>
            </ul>
          </div>
          <div>
            <ul class="table-list">
              <li class="five-box" style="width:6%;">&nbsp;</li>
              <li class="five-box" style="width:75%;">&nbsp;</li>
              <li class="five-box" style="width:20%;">&nbsp;</li>
              <li class="five-box" style="width:20%;">&nbsp;</li>
              <li class="five-box" style="text-align:right;width:20%; font-size:20px;">
                <h4>Discount</h4>
              </li>
              <li class="five-box" style="width:20%;border-right: 0; color:black; font-size:20px; text-align:right;" id="discount"></li>
            </ul>
          </div>
          <div>
          <ul class="table-list">
          	<li class="five-box" style="width:6%;">&nbsp;</li>
              <li class="five-box" style="width:75%;">&nbsp;</li>
              <li class="five-box" style="width:20%;">&nbsp;</li>
              <li class="five-box" style="width:20%;">&nbsp;</li>
          <li class="five-box" style="text-align:right;width:20%; font-size:20px;">
                <h4>Advance</h4>
              </li>
              <li class="five-box" style="width:20%;border-right: 0; color:black; font-size:20px; text-align:right;" id="advance"></li>
          </ul>
          </div>
          <div>
            <ul class="table-list">
              <li class="five-box" style="width:6%;">&nbsp;</li>
              <li class="five-box" style="width:75%;">&nbsp;</li>
              <li class="five-box" style="width:20%;">&nbsp;</li>
              <li class="five-box" style="width:20%;">&nbsp;</li>
              <li class="five-box" style="text-align:right;width:20%; font-size:20px;">
                <h4>Grand Total</h4>
              </li>
              <li class="five-box" style="width:20%;border-right: 0; color:black; font-size:18px; text-align:right;" id="netAmount"></li>
            </ul>
          </div>
        </div>
        <div class="block-footer" style="background:#ffffff; font-size:15px;">
          <aside class="block-footer-left" style="width:98%; border-top: 1px solid burlywood;">
            <p>Amount in Words: <span class="amountinwords" id="amountinwords" style="font-size:15px;"></span></p>
          </aside>
        </div>
      </div>
      <div style="clear:both;"></div>
      <div class="header-top header-top-1 termsblock" style="border:1px #ccc solid; border-radius:8px; padding:10px; width:98%; height: 15%; color: black; margin-top: -40px;">
        <div class="block-6 termsblock" style="line-height:35px;font-weight:bold; font-size:12px;">
          <h5 class="termsmaintitle"><u>Terms &amp; Conditions:</u></h5>
          <p><span>*</span> Goods once sold cannot be taken back</p>
          <p><span>*</span> No Exchange</p>
          <p><span>*</span> Subject to Hyderabad jurisdiction only</p>
          <p><span>*</span><u> Payment Through:</u><span> ICICI BANK, MOOSAPET Branch</span></p>
          <p><span>*</span> Current A/c. No: 111 605 500 181, GOWTHAMI HANDLOOMS, IFSC CODE- ICIC0001116</p>
        </div>
        <div class="block-7 signsblock" style="width:32%;line-height:75px;font-weight:bold; margin-left: 148px;">
          <h5 style="text-align:center;">For: <span style="font-size:16px;font-weight:bold;">GOWTHAMI HANDLOOMS</span></h5>
          <p class="authsign" style="text-align:center;margin-top: 24px;">Authorised Signature</p>
        </div>

      </div>
      <div class="block-footer"  id="prtBtn" style="margin-top: 35px;border-top: -9px;id=;">
        <aside class="block-footer-left">
          <exptotal></exptotal>
        </aside>
        <aside class="block-footer-right">
          <input class="btn-cancel" name="" value="Cancel" type="button" onclick="dataCancel();">
          <input class="btn-save" name="" value="Print" type="button" id="print" onclick="printBill();">
        </aside>
      </div>
    </section>
	
	</body></html>
