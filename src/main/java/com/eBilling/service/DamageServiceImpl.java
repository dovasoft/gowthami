package com.eBilling.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eBilling.baseModel.BillingDetailsCart;
import com.eBilling.dao.DamageDao;
import com.eBilling.dao.ProductDao;
import com.eBilling.dao.ProductStockDao;
import com.eBilling.model.Damage;
import com.eBilling.model.Product;
import com.eBilling.model.ProductStock;
import com.eBilling.util.CommonUtils;
import com.fasterxml.jackson.databind.ObjectMapper;


@Service
public class DamageServiceImpl implements DamageService{
	@Autowired
	ProductStockDao productStockDao;
	@Autowired
	DamageDao damageDao;
	private Logger objLogger = Logger.getLogger(DamageServiceImpl.class);
	@Override
	public String populateDamage() {
		ObjectMapper objectMapper = null;
		String sJson = null;
		List<Damage> lstDamage = null;
		try {
			lstDamage = damageDao.getAllDamage();
			//lstDamage = productDao.getAllProduct();
			if (lstDamage != null && lstDamage.size() > 0) {
				objectMapper = new ObjectMapper();
				sJson = objectMapper.writeValueAsString(lstDamage);
			}
		} catch (Exception e) {
			objLogger.info("Exception in DamageServiceImpl in populateProducts()" + e);
			//System.out.println("Exception in Damage Controller in  getAllProducts()");
		}
		return sJson;
	}
	@Override
	public boolean damageSave(Damage damage) {
		boolean isSave = false;
		try {
			isSave = damageDao.damageSave(damage);
			//isSave = productDao.productSave(product);
		}catch(Exception e){
			objLogger.error("Exception in DamageServiceImpl in getAllbillDeteailsCart() "+e);
			
		}finally{
			
		}
		return isSave;
	}
	
	@Override
	public boolean updateDamage(Damage damage) {
		boolean isSave = false;
		try {
			isSave = damageDao.updateDamage(damage);
			//isSave = productDao.updateProduct(product);
		}catch(Exception e){
			objLogger.error("Exception in BillingDetatilsCartServiceImpl in getAllbillDeteailsCart() "+e);
			//System.out.println("erroor in updateDamage() "+e);
		}finally{
			
		}
		return isSave;
	}
	@Override
	public List<Damage> getDamageById(String sDamageId) {
		List<Damage> getById = null;
		try {
			getById = damageDao.getDamageById(sDamageId);
			//getById = damageDao.getDamageById(sDamageId);
			//getByName = productDao.getProductByName(sDamageId);
		}catch(Exception e){
			objLogger.error("Exception in BillingDetatilsCartServiceImpl in getAllbillDeteailsCart() "+e);
		}finally{
			
		}
		return getById;
	}
	
	@Override
	public boolean deleteDamage(String sDamageId) {
		boolean isDelete = true;
		try {
			isDelete = damageDao.deleteDamage(sDamageId);
			//isDelete = productDao.deleteProduct(sProductId);
		} catch (Exception e) {
			objLogger.error(e.getMessage());
			isDelete = false;
			objLogger.fatal("error in deleteCategory in category service");
		}
		return isDelete;
	}
	public String getAllDamage() {
		ObjectMapper objectMapper = null;
		String sJson = null;
		List<Damage> lstDamage = null;
		try {
			lstDamage = damageDao.getAllDamage();
			if (lstDamage != null && lstDamage.size() > 0) {
				objectMapper = new ObjectMapper();
				sJson = objectMapper.writeValueAsString(lstDamage);
			}
		} catch (Exception e) {
			objLogger.info("Exception in RegistrationServiceImpl in populateProducts()" + e);
			//System.out.println("Exception getAllDamage()"+e);
		}
		return sJson;
	}
	
	/*@Override
	public boolean updateStock(ProductStock productStock,JSONObject data,List<ProductStock> lstProductstock) {
		boolean isUpdate = false;
		 String sProductId ="";
		 List<Damage> lstDamageProduct =null;
		 Damage existDamageStock =null;
		try {
			
			sProductId = data.getString("productId");
			lstProductstock = productStockDao.getAllProductStockByProductId(sProductId);
			for(int i=0;i<lstProductstock.size();i++){
				productStock=lstProductstock.get(i);
			}
			lstDamageProduct=damageDao.getAllDamageProductsByProductId(sProductId);
			for(int i=0;i<lstDamageProduct.size();i++){
				existDamageStock=lstDamageProduct.get(i);
			}
			if(existDamageStock.getProductId().equals(sProductId)){
				int stock = Math.abs(Integer.parseInt(data.getString("quantity"))-Integer.parseInt(existDamageStock.getQuantity()));
				
				int sNewStock = Math.abs(Integer.parseInt(productStock.getStock()) - Integer.parseInt( String.valueOf(stock)));
				 productStock.setStock(String.valueOf(sNewStock));
				 productStockDao.updateProductStock(productStock);
			}
			
		}catch(Exception e){
			objLogger.error("Exception in RegistrationServiceImpl in updateProductStock() "+e);
			e.printStackTrace();
		}finally{
			
		}
		return isUpdate;
	}*/
	@Override
	public boolean updatedStock(ProductStock productStock,JSONObject data,List<ProductStock> lstProductstock) {
		boolean isUpdate = false;
		 String sProductId ="";
		try {
			
			sProductId = data.getString("productId");
			lstProductstock = productStockDao.getAllProductStockByProductId(sProductId);
			for(int i=0;i<lstProductstock.size();i++){
				productStock=lstProductstock.get(i);
				
			}
			int sNewStock = Math.abs(Integer.parseInt(productStock.getStock()) - Integer.parseInt( data.getString("quantity")));
			 productStock.setStock(String.valueOf(sNewStock));
			 productStockDao.updateProductStock(productStock);
		}catch(Exception e){
			objLogger.error("Exception in RegistrationServiceImpl in updatedStock() "+e);
			e.printStackTrace();
		}finally{
			
		}
		return isUpdate;
	}
	@Override
	public boolean addDeletedStock(ProductStock productStock,JSONObject data,List<ProductStock> lstProductstock) {
		boolean isUpdate = false;
		 String sProductId ="";
		try {
			
			sProductId = data.getString("productId");
			lstProductstock = productStockDao.getAllProductStockByProductId(sProductId);
			for(int i=0;i<lstProductstock.size();i++){
				productStock=lstProductstock.get(i);
				
			}
			int sNewStock = Math.abs(Integer.parseInt(productStock.getStock()) + Integer.parseInt( data.getString("quantity")));
			int sOldStock = Math.abs(Integer.parseInt(productStock.getOldStock()) + Integer.parseInt( data.getString("quantity")));
			 productStock.setStock(String.valueOf(sNewStock));
			 productStock.setOldStock(String.valueOf(sOldStock));
			 
			 productStockDao.updateProductStock(productStock);
			 
		}catch(Exception e){
			objLogger.error("Exception in RegistrationServiceImpl in updatedStock() "+e);
			e.printStackTrace();
		}finally{
			
		}
		return isUpdate;
	}
	@Override
	public List<Damage> updateProductQuantity(Damage damage,
			List<Damage> lstDamage) {
		String sProductId = null;
		try {
			sProductId = damage.getProductId();
			lstDamage=damageDao.getDamageProductByProductName(sProductId);
			//lstProductModel = objPopulateService.getProductByName(sProductName);
			//sNewProductId = billingdetailsCart.getProductId();
			for (int i = 0; i < lstDamage.size(); i++) {
				Damage existDamage = lstDamage.get(i);
				if (existDamage.getProductId().equals(sProductId)) {
					////System.out.println("in----------updateProductQuantity---------------sNewProductId=="+sNewProductId+"--------------existBillingDetailsCart.getProductId()==="+existBillingDetailsCart.getProductId());
					int existQty = Integer.parseInt(existDamage.getQuantity());
					int newQty = Integer.parseInt(damage.getQuantity());
					////System.out.println("existQty=="+existQty+"--------------newQty==="+newQty);
					damage.setQuantity(String.valueOf(existQty + newQty));
					damage.setDamageId(existDamage.getDamageId());
					damage.setProductId(existDamage.getProductId());
					damage.setDescription(existDamage.getDescription());
					damage.setUpdatedBy(CommonUtils.getDate());
					damage.setUpdatedOn(CommonUtils.getDate());
					damageDao.updateDamage(damage);
					break;
				}

			}

		} catch (Exception e) {

			//System.out.println("Exception in updateProductQuantity in  calculateTotal()");
		}
		return lstDamage;
	}
	
	
	@Override
	public boolean checkInQuantity(Damage damage,
			List<Damage> lstDamage) {
		String sProductId = null;
		boolean isExist = false;
		Damage existdamage = null;
		try {
			sProductId = damage.getProductId();
			 lstDamage=damageDao.getDamageProductByProductName(sProductId);
			 for(int i=0;i<lstDamage.size();i++){
				 existdamage= lstDamage.get(i);
				 if(existdamage.getProductId().equals(sProductId)){
					// //System.out.println("in----------checkInCart---------------sNewProductId=="+sNewProductId+"--------------existBillingDetailsCart.getProductId()==="+existBillingDetailsCart.getProductId());
					 isExist = true;
					 break;
				 }
				 
			 }
			
			
		} catch (Exception e) {

			System.out
					.println("Exception in checkInCart()");
		}
		return isExist;
	}
}
