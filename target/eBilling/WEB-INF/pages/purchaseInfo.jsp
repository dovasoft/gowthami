html<!DOCTYPE section PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head></head><body>

<!-- <script type="text/javascript" src="js/jquery-1.7.min.js"></script> -->
<script type="text/javascript" src="js/jquery.min.js"></script>
 <script type="text/javascript" src="js/purchaseInfo.js"></script>
 <!-- <script type="text/javascript" src="js/jquery-3.1.1.min.js"></script> -->
 <script type="text/javascript">
 
 $(document).ready(function() {
		var lstOrders ='${sessionScope.allPurchaseInfo}';
		showPurchaseData(lstOrders);
	});
 </script>
		<section class="container">
			<div class="block">
				<h2><span class="icon1">&nbsp;</span>New Purchaser</h2>
				<form name="cf_form" method="post" id="contact-form"  onsubmit="return false;">
					<div class="block-searchbill">
						<div class="block-searchbill-input">
							<label>Name</label>
							<input type="text" name="name" id="name" onkeyup="removeError(this.id);">
						</div>
						<div class="block-searchbill-input">
							<label>Mobile No</label>
							<input type="text" name="mobileNo" id="mobileNo" onkeyup="removeError(this.id);">
						</div> 
						<div class="block-searchbill-input last">
							<label>Email</label>
							<input type="text" name="eMail" id="eMail" onkeyup="removeError(this.id);">
						</div>
					</div>
					<div class="block-searchbill">
					<div class="block-searchbill-input">
							<label>Address</label>
							<!-- <input type="t" name="address" id="address"> -->
							<textarea rows="4" cols="" name="address" id="address" onsubmit="return false;"></textarea>
						</div>
						</div>
					<div class="block-footer">
						<aside class="block-footer-left sucessfully" id="unc" style="display: none">Save Sucessfully</aside>
						<aside class="block-footer-right">
							<input class="btn-cancel" name="" value="Cancel" type="button">
							<input class="btn-save" name="" value="Save" type="submit" onclick="productRegister();">
						</aside>
					</div>
				</form>
			</div>
			<div class="block table-toop-space">
				<div class="head-box">
					<h2><span class="icon2">&nbsp;</span>Product Details<aside class="block-footer-right sucessfully" id="unc1" style="display:none;" >Delete Sucessfully</aside></h2>
				</div>
				<div class="block-box-mid block-box-last-mid">
					<ul class="table-list">
						<li class="nine-box">Name
							<ul>
								<li><a class="top" href="http://localhost:8080/personal/reg#">&nbsp;</a></li>
								<li><a class="bottom" href="http://localhost:8080/personal/reg#">&nbsp;</a></li>
							</ul>
						</li>
						<li class="five-box">Mobile No
							<ul>
								<li><a class="top" href="http://localhost:8080/personal/reg#">&nbsp;</a></li>
								<li><a class="bottom" href="http://localhost:8080/personal/reg#">&nbsp;</a></li>
							</ul>
						</li>
						<li class="five-box">eMail
							<ul>
								<li><a class="top" href="http://localhost:8080/personal/reg#">&nbsp;</a></li>
								<li><a class="bottom" href="http://localhost:8080/personal/reg#">&nbsp;</a></li>
							</ul>
						</li>    
						<li class="five-box">Address
							<ul>
								<li><a class="top" href="http://localhost:8080/personal/reg#">&nbsp;</a></li>
								<li><a class="bottom" href="http://localhost:8080/personal/reg#">&nbsp;</a></li>
							</ul>
						</li>            
						<li class="ten-box">Edit</li>
						<li class="ten-box last">Delete</li>
					</ul>
					<div class="table-list-blk" id="userData">
						<!-- <ul>
							<li class="nine-box">Shirts</li>
							<li class="five-box">1,000</li>
							<li class="five-box">Nos</li>                    
							<li class="ten-box"><a href="#">Edit</a></li>
							<li class="ten-box last"><a href="#">Delete</a></li>
						</ul>
						<ul>
							<li class="nine-box">Phants</li>
							<li class="five-box">2,000</li>
							<li class="five-box">Mts</li>                    
							<li class="ten-box"><a href="#">Edit</a></li>
							<li class="ten-box last"><a href="#">Delete</a></li>
						</ul>    -->                                         
					</div>
				</div>
				<div class="block-footer">
					<aside class="block-footer-left"><exptotal></exptotal></aside>
					<aside class="block-footer-right">
						<input class="btn-cancel" name="" value="Cancel" type="button">
						<input class="btn-save" name="" value="Save" type="submit">
					</aside>
				</div>
			</div>
		</section>
</body>