package com.eBilling.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eBilling.dao.RegisterDao;
import com.eBilling.model.Product;
import com.eBilling.model.ProductStock;
import com.eBilling.model.Register;
import com.eBilling.model.SendSms;
import com.eBilling.model.StockDetails;
import com.eBilling.service.ProductPopulateService;
import com.eBilling.service.ProductStockService;
import com.eBilling.service.RegistrationService;
import com.eBilling.service.StockDetailsService;
import com.eBilling.util.CommonUtils;
import com.eBilling.util.EmailUtil;
import com.eBilling.util.Sms;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class ProductStockController {
	@Autowired
	ProductPopulateService objProductService;
	@Autowired
	ProductStockService productStockService;
	@Autowired
	StockDetailsService stockDetailsService;

	@RequestMapping(value = "/stockHome")
	public String stockHome(@ModelAttribute ProductStock productStock, HttpServletResponse objResponce,
			HttpSession objSession, HttpServletRequest objRequest) {

		objResponce.setCharacterEncoding("UTF-8");
		String sJson = null;
		String getAllProductStock = null;
		try {
			sJson = objProductService.populateProducts();
			objSession.setAttribute("allProducts", sJson);
			getAllProductStock = productStockService.getAllProductStock();
			objSession.setAttribute("getAllStock", getAllProductStock);
			objSession.setAttribute("tabActive", "stocks");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}

		return "stockHome";
	}

	@RequestMapping(value = "/saveProductStock")
	public @ResponseBody String saveProductStock(@ModelAttribute ProductStock productStock, HttpSession objSession,
			HttpServletRequest objRequest) {
		boolean isInsert = false;
		String sJson = "";
		InputStream input = null;
		SendSms Objsmsbean = null;
		String sOtp = null;
		StockDetails stockDetails = null;
		try {

			stockDetailsService.addStockDetails(productStock.getProductId(), productStock.getNewStock(),
					productStock.getStockId(), "Entry", productStock.getNewStock(), productStock.getOldStock());
			productStockService.addNewStock(productStock);

			sJson = productStockService.getAllProductStock();

		} catch (Exception e) {
		}

		return sJson;
	}

	@RequestMapping(value = "/updateProductStock")
	public @ResponseBody String updateProductStock(@ModelAttribute ProductStock productStock,
			@RequestParam("jsondata") JSONObject data, HttpSession objSession, HttpServletRequest objRequest) {
		boolean isupdate = false;
		String sJson = "";
		StockDetails stockDetails = null;
		try {
			String sStockId = data.getString("stockId");
			if (StringUtils.isNotEmpty(sStockId)) {
				isupdate = productStockService.deductProductStock(data.getString("productId"),
						data.getString("newStock"));
				if (isupdate)
					sJson = productStockService.getAllProductStock();

				stockDetailsService.addStockDetails(data.getString("productId"), data.getString("stock"), sStockId,
						"Update", data.getString("newStock"), data.getString("oldStock"));
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return sJson;
	}

	@RequestMapping(value = "/deleteProductStock")
	public @ResponseBody String deleteProductStock(@RequestParam("id") String id, HttpSession objSession,
			HttpServletRequest objRequest) throws JsonGenerationException, JsonMappingException, IOException {
		boolean isDelete = false;
		String sJson = "";
		isDelete = productStockService.deleteProductStock(id);
		if (isDelete) {
			sJson = productStockService.getAllProductStock();
		}
		return sJson;
	}

	@RequestMapping(value = "/stockDetails")
	public @ResponseBody String stockDetails(@RequestParam("productId") String sProductId, HttpSession objSession,
			HttpServletRequest objRequest) throws JsonGenerationException, JsonMappingException, IOException {

		String sJson = "";
		List<StockDetails> lstProductStockDetais = null;
		try {
			lstProductStockDetais = stockDetailsService.getProductStockDetailsByProductId(sProductId);

			if (lstProductStockDetais != null && lstProductStockDetais.size() > 0) {
				ObjectMapper objectMapper = new ObjectMapper();
				sJson = objectMapper.writeValueAsString(lstProductStockDetais);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return sJson;
	}

}