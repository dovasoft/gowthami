package com.eBilling.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eBilling.baseModel.BillingDetailsCart;
import com.eBilling.dao.BillingDetailsCartDao;
import com.eBilling.dao.DamageDao;
import com.eBilling.dao.ProductStockDao;
import com.eBilling.model.Damage;
import com.eBilling.model.ProductStock;
import com.eBilling.model.StockDetails;
import com.eBilling.util.CommonUtils;
import com.fasterxml.jackson.databind.ObjectMapper;


@Service
public class ProductStockServiceImpl implements ProductStockService{
	
	@Autowired
	ProductStockDao productStockDao;
	@Autowired
	BillingDetailsCartDao billingDetailsCartDao;
	@Autowired
	BillingDetatilsCartService objBillingDetatilsCartService;
	@Autowired
	DamageDao damageDao;
	
	
	private Logger objLogger = Logger.getLogger(ProductStockServiceImpl.class);
	
	@Override
	public boolean saveProductStock(ProductStock objProductStock) {
		boolean isSave = false;
		try {
			isSave = productStockDao.saveProductStock(objProductStock);
		}catch(Exception e){
			objLogger.error("Exception in ProductStockServiceImpl in saveProductStock() "+e);
			
		}finally{
			
		}
		return isSave;
	}
	@Override
	public boolean updateProductStock(ProductStock objProductStock) {
		boolean isUpdate = false;
		try {
			isUpdate = productStockDao.updateProductStock(objProductStock);
		}catch(Exception e){
			objLogger.error("Exception in ProductStockServiceImpl in updateProductStock() "+e);
			e.printStackTrace();
		}finally{
			
		}
		return isUpdate;
	}
	
	@Override
	public boolean updatingStock(ProductStock productStock,BillingDetailsCart billingdetailsCart,List<ProductStock> lstProductstock,JSONObject data) {
		boolean isUpdate = false;
		 String sProductId ="";
		 BillingDetailsCart existBillingDetailsCart =null;
		 List<BillingDetailsCart> listBillingDetails =null;
		try {
			
			sProductId = data.getString("productId");
			lstProductstock = productStockDao.getAllProductStockByProductId(sProductId);
			for(int i=0;i<lstProductstock.size();i++){
				productStock=lstProductstock.get(i);
				
			}
			listBillingDetails = billingDetailsCartDao.getAllBillDetailsByProductId(sProductId);
			for(int i=0;i<listBillingDetails.size();i++){
				existBillingDetailsCart=listBillingDetails.get(i);
				
			}if(existBillingDetailsCart.getProductId().equals(sProductId)){
				int stock =Math.abs(Integer.parseInt(existBillingDetailsCart.getQuantity())-Integer.parseInt(data.getString("quantity")));
				int sNewStock = Math.abs(Integer.parseInt(productStock.getStock()) - Integer.parseInt( String.valueOf(stock)));
				 productStock.setStock(String.valueOf(sNewStock));
				 productStockDao.updateProductStock(productStock);
			}
			
			
		}catch(Exception e){
			objLogger.error("Exception in ProductStockServiceImpl in updateProductStock() "+e);
			e.printStackTrace();
		}finally{
			
		}
		return isUpdate;
	}
	@Override
	public boolean updatedStock(String sBillId,HttpSession objSession) {
		boolean isUpdate = false;
		 String sProductId ="";
		 List<BillingDetailsCart> listBillingDetails = null;
		 List<ProductStock> lstProductstock =null;
		 ProductStock productStock =null;
		try {
			listBillingDetails = objBillingDetatilsCartService.getAllbillDeteailsCart(sBillId);
			for(BillingDetailsCart billingdetailsC :listBillingDetails){
				lstProductstock = productStockDao.getAllProductStockByProductId(billingdetailsC.getProductId());
				productStock=lstProductstock.get(0);
				int sNewStock = Math.abs(Integer.parseInt(productStock.getNewStock()) - Integer.parseInt(billingdetailsC.getQuantity()));
				
				productStock.setOldStock(productStock.getNewStock());
				productStock.setNewStock(String.valueOf(sNewStock));
				productStock.setStock(String.valueOf(sNewStock));
				
				objSession.setAttribute("sessionCartStock",productStock);
						 productStockDao.updateProductStock(productStock);
				
			}
		}catch(Exception e){
			objLogger.error("Exception in ProductStockServiceImpl in updateProductStock() "+e);
			e.printStackTrace();
		}finally{
			
		}
		return isUpdate;
	}
	@Override
	public boolean deleteProductStock(String id) {
		boolean isDelete = true;
		try {
			isDelete = productStockDao.deleteProductStock(id);
		} catch (Exception e) {
			objLogger.error(e.getMessage());
			isDelete = false;
			objLogger.fatal("error in ProductStockServiceImpl in deleteProductStock()");
		}
		return isDelete;
	}
	@Override
	public String getAllProductStock() {
		ObjectMapper objectMapper = null;
		String sJson = null;
		List<ProductStock> lstRegisterModel = null;
		try {
			lstRegisterModel = productStockDao.getAllProductStock();
			if (lstRegisterModel != null && lstRegisterModel.size() > 0) {
				objectMapper = new ObjectMapper();
				sJson = objectMapper.writeValueAsString(lstRegisterModel);
			}
		} catch (Exception e) {
			objLogger.info("Exception in RegistrationServiceImpl in populateProducts()" + e);
			////System.out.println("Exception in Register Controller in  getAllProducts()");
		}
		return sJson;
	}
	@Override
	public List<ProductStock> getAllProductStockByProductId(String sProductId) {
		ObjectMapper objectMapper = null;
		String sJson = null;
		List<ProductStock> productStocks = null;
		try {
			productStocks = productStockDao.getAllProductStockByProductId(sProductId);
			
		} catch (Exception e) {
			//objLogger.info("Exception in getAllProductStockByProductId()" + e);
			//System.out.println("Exception in getAllProductStockByProductId()");
		}
		return productStocks;
	}
	
	@Override
	public Boolean checkStock(String sProductId, String sBilledQty) {
		ObjectMapper objectMapper = null;
		String sJson = null;
		List<ProductStock> productStocks = null;
		 List<ProductStock> lstProductstock =null;
		 ProductStock productStock=null;
		 boolean bStockAvailable = false;
		try {
			lstProductstock = getAllProductStockByProductId(sProductId);
			for(int i=0;i<lstProductstock.size();i++){
				productStock=lstProductstock.get(i);
			}
			String sStock = productStock.getStock();
			//System.out.println("sStock=="+sStock+"-------sBilledQty====="+sBilledQty);
			if(Integer.parseInt(sStock) >= Integer.parseInt(sBilledQty)){
				bStockAvailable=true;
			}
			
		} catch (Exception e) {
			//objLogger.info("Exception in getAllProductStockByProductId()" + e);
			//System.out.println("Exception in checkStock()");
		}
		return bStockAvailable;
	}

	@Override
	public boolean deductStock(String sProductId, String sBilledQty,HttpSession objSession) {
		boolean isUpdate = false;
		List<ProductStock> lstProductstock = null;
		try {
			lstProductstock = productStockDao.getAllProductStockByProductId(sProductId);
			ProductStock productStock = lstProductstock.get(0);
			int sNewStock = Math.abs(Integer.parseInt(productStock.getStock()) - Integer.parseInt(sBilledQty));
			productStock.setStock(String.valueOf(sNewStock));
			
			if(Integer.parseInt(productStock.getOldStock()) != 0){
			int sOldStock=Math.abs(Integer.parseInt(productStock.getOldStock()) - Integer.parseInt(sBilledQty));
			productStock.setOldStock(String.valueOf(sOldStock));
			}else{
				int sOldStock=Math.abs(Integer.parseInt(sBilledQty) -Integer.parseInt(productStock.getOldStock()));
				//productStock.setOldStock(String.valueOf(sOldStock));
			}
			objSession.setAttribute("sessionStock",productStock);
			productStockDao.updateProductStock(productStock);
			isUpdate = true;

		} catch (Exception e) {
			objLogger.error("Exception in ProductStockServiceImpl in deductStock() " + e);
			e.printStackTrace();
		} finally {

		}
		return isUpdate;
	}
	@Override
	public boolean deductProductStock(String sProductId, String sBilledQty) {
		boolean isUpdate = false;
		List<ProductStock> lstProductstock = null;
		try {
			lstProductstock = productStockDao.getAllProductStockByProductId(sProductId);
			ProductStock productStock = lstProductstock.get(0);
			if(productStock.getOldStock() != null){
			productStock.setOldStock(productStock.getNewStock());
			productStock.setStock(String.valueOf(sBilledQty));
			productStock.setNewStock(sBilledQty);
			
			productStockDao.updateProductStock(productStock);
			isUpdate = true;
			}
		} catch (Exception e) {
			objLogger.error("Exception in ProductStockServiceImpl in deductProductStock() " + e);
			e.printStackTrace();
		} finally {

		}
		return isUpdate;
	}
	
	@Override
	public boolean addStock(ProductStock productStock) {
		boolean isAdd = false;
		boolean isupdate =false;
		List<ProductStock> lstProductstock = null;
		ProductStock existProductstock =null;
		try {
			String sProductId = productStock.getProductId();
			lstProductstock = productStockDao.getAllProductStockByProductId(sProductId);
			for(int i=0;i<lstProductstock.size();i++){
				existProductstock =lstProductstock.get(i);
			}
			if(lstProductstock.size() == 0){
				//System.out.println("saveProductStock:::::::::::"+productStock.toString());
				productStock.setStockId(CommonUtils.getAutoGenId());
				productStock.setProductId(productStock.getProductId());
				productStock.setOldStock(productStock.getStock());
				productStock.setNewStock(productStock.getNewStock());
				int iOldStock=Integer.parseInt(productStock.getOldStock());
				int iNewStock=Integer.parseInt(productStock.getNewStock());
				int iStock=iOldStock+iNewStock;
				productStock.setStock(String.valueOf(iStock));
				boolean isInsert = productStockDao.saveProductStock(productStock);
				if(isInsert)
					isAdd = true;
			}else{
				if(existProductstock.getProductId() !=null && existProductstock.getProductId().equals(sProductId)){
					productStock.setStockId(existProductstock.getStockId());
					productStock.setOldStock(productStock.getStock());
					productStock.setNewStock(productStock.getNewStock());
					int iOldStock=Integer.parseInt(productStock.getOldStock());
					int iNewStock=Integer.parseInt(productStock.getNewStock());
					int iStock=iOldStock+iNewStock;
					productStock.setStock(String.valueOf(iStock));
					
					isupdate = productStockDao.updateProductStock(productStock);
					if(isupdate)
						isAdd = true;
					
				
				}
				}

		} catch (Exception e) {
			objLogger.error("Exception in ProductStockServiceImpl in addStock() " + e);
			e.printStackTrace();
		} finally {

		}
		return isAdd;
	}
	@Override
	public boolean updateProductStock(String sProductId, String sQty,HttpSession objSession) {
		boolean isUpdate = false;
		 List<Damage> lstDamageProduct =null;
		 Damage existDamageStock =null;
		 List<ProductStock> lstProductstock = null;
		 ProductStock productStock =null;
		try {
			
			lstProductstock = productStockDao.getAllProductStockByProductId(sProductId);
			for(int i=0;i<lstProductstock.size();i++){
				productStock=lstProductstock.get(i);
			}
			lstDamageProduct=damageDao.getAllDamageProductsByProductId(sProductId);
			for(int i=0;i<lstDamageProduct.size();i++){
				existDamageStock=lstDamageProduct.get(i);
			}
			if(existDamageStock.getProductId().equals(sProductId)){
				int stock = Math.abs(Integer.parseInt(sQty)-Integer.parseInt(existDamageStock.getQuantity()));
				
				int sNewStock = Math.abs(Integer.parseInt(productStock.getNewStock()) - Integer.parseInt( String.valueOf(stock)));
				//int sOldStock = Math.abs(Integer.parseInt(productStock.getOldStock()) - Integer.parseInt( String.valueOf(stock)));
				 productStock.setStock(String.valueOf(sNewStock));
				 productStock.setNewStock(String.valueOf(sNewStock));
				 productStock.setOldStock(productStock.getNewStock());
				 
				 objSession.setAttribute("sessionDamageStock",productStock);
				 productStockDao.updateProductStock(productStock);
			}
			
		}catch(Exception e){
			objLogger.error("Exception in RegistrationServiceImpl in updateProductStock() "+e);
			e.printStackTrace();
		}finally{
			
		}
		return isUpdate;
	}
	@Override
	public boolean addNewStock(ProductStock productStock) {
		boolean isAdd = false;
		boolean isupdate =false;
		List<ProductStock> lstProductstock = null;
		ProductStock existProductstock =null;
		try {
			String sProductId = productStock.getProductId();
			lstProductstock = productStockDao.getAllProductStockByProductId(sProductId);
			for(int i=0;i<lstProductstock.size();i++){
				existProductstock =lstProductstock.get(i);
			}
			if(lstProductstock.size() == 0){
				//System.out.println("saveProductStock:::::::::::"+productStock.toString());
				productStock.setStockId(CommonUtils.getAutoGenId());
				productStock.setProductId(productStock.getProductId());
				productStock.setOldStock(productStock.getStock());
				productStock.setNewStock(productStock.getNewStock());
				//int iOldStock=Integer.parseInt(productStock.getOldStock());
				int iNewStock=Integer.parseInt(productStock.getNewStock());
				//int iStock=iOldStock+iNewStock;
				productStock.setStock(String.valueOf(iNewStock));
				boolean isInsert = productStockDao.saveProductStock(productStock);
				if(isInsert)
					isAdd = true;
			}else{
				if(existProductstock.getProductId() !=null && existProductstock.getProductId().equals(sProductId)){
					productStock.setStockId(existProductstock.getStockId());
					productStock.setOldStock(existProductstock.getNewStock());
					int iPreNewStock=Integer.parseInt(existProductstock.getNewStock());
					int iNewStock=Integer.parseInt(productStock.getNewStock());
					int iStock=iPreNewStock+iNewStock;
					productStock.setStock(String.valueOf(iStock));
					productStock.setNewStock(String.valueOf(iStock));
					
					isupdate = productStockDao.updateProductStock(productStock);
					if(isupdate)
						isAdd = true;
					
				
				}
				}

		} catch (Exception e) {
			objLogger.error("Exception in ProductStockServiceImpl in addStock() " + e);
			e.printStackTrace();
		} finally {

		}
		return isAdd;
	}
	@Override
	public boolean deductedStock(String sProductId, String sBilledQty,HttpSession objSession) {
		boolean isUpdate = false;
		List<ProductStock> lstProductstock = null;
		try {
			lstProductstock = productStockDao.getAllProductStockByProductId(sProductId);
			ProductStock productStock = lstProductstock.get(0);
			int sNewStock = Math.abs(Integer.parseInt(productStock.getNewStock()) - Integer.parseInt(sBilledQty));
			
			productStock.setOldStock(productStock.getNewStock());
			productStock.setNewStock(String.valueOf(sNewStock));
			productStock.setStock(String.valueOf(sNewStock));
			
			objSession.setAttribute("sessionStock",productStock);
			productStockDao.updateProductStock(productStock);
			isUpdate = true;

		} catch (Exception e) {
			objLogger.error("Exception in ProductStockServiceImpl in deductStock() " + e);
			e.printStackTrace();
		} finally {

		}
		return isUpdate;
	}

}
