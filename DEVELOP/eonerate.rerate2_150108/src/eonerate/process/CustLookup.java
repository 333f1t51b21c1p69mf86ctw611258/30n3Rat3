/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.process;

import ElcRate.exception.ProcessingException;
import ElcRate.lang.AuditSegment;
import ElcRate.lang.CustProductInfo;
import ElcRate.lang.ProductList;
import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.process.AbstractCustomerLookupAudited;
import ElcRate.record.ErrorType;
import ElcRate.record.IRecord;
import ElcRate.record.RecordError;
import eonerate.entity.RatRec;

/**
 *
 * @author hinhnd
 */
public class CustLookup extends AbstractCustomerLookupAudited {

	ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");

	@Override
	public IRecord procValidRecord(IRecord r) {
		RatRec currentRecord;
		currentRecord = (RatRec) r;

		// try {
		LOG_PROCESSING.debug(currentRecord.concatHeader(0, "Prods:"));

		if (!lookupCustomer(currentRecord)) {

			LOG_PROCESSING.error(currentRecord.concatHeader(1,
					"No customer || No product"));

		}
		// logString = super.getSymbolicName() + " [A_NUMBER: " +
		// currentRecord.NumberA + "] => Result: <PRODUCT: " + productList +
		// ">";

		// } catch (Exception e) {
		// String errors = ElcRateUtil.getErrorList(r);
		//
		// currentRecord.addError(new RecordError("CUSTOMER_LOOKUP_ERROR: " +
		// errors, ErrorType.SPECIAL, getSymbolicName()));
		//
		// LOG_PROCESSING.error(currentRecord.concatHeader(0, "WHEN: ;ERRORS: "
		// + errors));
		// }
		return (IRecord) currentRecord;
	}

	@Override
	public IRecord procErrorRecord(IRecord r) {

		RatRec CurrentRecord;
		CurrentRecord = (RatRec) r;
		LOG_PROCESSING.error(CurrentRecord.toString()
				+ " > WHEN: Lookup Customer");

		// FWLog.debug("A_NUMBER: " + CurrentRecord.ANumber + " " +
		// getSymbolicName());
		return null;
	}

	/**
	 * This looks up a customer record and the products associated with it,
	 * based on the validity of the customer and of the individual products.
	 *
	 * @param currentRecord
	 * @return Customer product list
	 * @throws Exception
	 */
	private boolean lookupCustomer(RatRec currentRecord) {
		//        String result = StringUtils.EMPTY;

		boolean result = false;

		CustProductInfo aCustProductInfo;
		Integer customerID;
		ProductList productList = null;
		ProductList validProductList;

		try {
			// Get the customerID for the alias
			// AccountId
			customerID = getCustId(currentRecord.GuidingKey, currentRecord.CdrStartTimeInSecond);

			if (customerID == null || customerID == 0) {

				currentRecord.addError(new RecordError("ALIAS_NOT_FOUND", ErrorType.DATA_NOT_FOUND, getSymbolicName()));

			} else {

				AuditSegment auditSegment = getAuditSegment(customerID, currentRecord.CdrStartTimeInSecond);

				// Khong tim thay AccountVersion - AuditSegment thoa man voi CdrStartTime hien tai
				if (auditSegment == null) {
					currentRecord.addError(new RecordError("AUDIT_SEGMENT_ERROR", ErrorType.DATA_VALIDATION, getSymbolicName()));
					LOG_PROCESSING.error(currentRecord.concatHeader(0, "Valid AccVer isn't found; With AccId: " + customerID));
					return false; // result = false;
				}

				try {

					// Danh sach da duoc sx: PO -> SO -> ...
					productList = getProductList(currentRecord.GuidingKey, currentRecord.CdrStartTimeInSecond);

				} catch (ProcessingException ex) {

					currentRecord.addError(new RecordError("CUSTOMER_PRODUCT_LOOKUP; ERROR: " + ex.toString(), ErrorType.LOOKUP_FAILED, getSymbolicName()));

				}

				currentRecord.BalanceGroup = (int) auditSegment.getAuditSegmentID(); // customerID ~ AccVerId;

				//Skip get IMSI MSN IMSI
				//CurrentRecord.MSN = getMSN(CustomerID);
				if (productList == null || productList.getProductCount() <= 0) {

					currentRecord.addError(new RecordError("PRODUCT_NOT_FOUND", ErrorType.DATA_NOT_FOUND, getSymbolicName()));

				} else {

					// Xu ly truong hop ngay hieu luc den dau thang sau
					// Voi cac truong hop dang ky tu ngay 15, 16 or 21
					validProductList = new ProductList();
					for (int i = 0; i < productList.getProductCount(); i++) {
						aCustProductInfo = productList.getProduct(i);
						if (aCustProductInfo.getUTCValidFrom() <= currentRecord.UTCEventDate &&
								aCustProductInfo.getUTCValidTo() > currentRecord.UTCEventDate &&
								aCustProductInfo.getService().equals(currentRecord.rvId.toString())) {

							validProductList.addProduct(aCustProductInfo);

						}
					}

					//		for (i = productList.getProductCount() - 1; i >= 0; i--) {
					//		    aCustProductInfo = productList.getProduct(i);
					//		    if (aCustProductInfo.getUTCValidFrom() <= currentRecord.UTCEventDate
					//			    & aCustProductInfo.getUTCValidTo() > currentRecord.UTCEventDate) {
					//			
					//			validProductList.addProduct(aCustProductInfo);
					//		    
					//		    }
					//		}
					if (validProductList.getProductCount() == 0) {
						// Did not find any customer information
						currentRecord.addError(new RecordError("NO_PRODUCT", ErrorType.SPECIAL, getSymbolicName()));
					} else {
						// Set back to Record
						// CurrentRecord.Products = tmpProductList;
						//		    currentRecord.Products = validProductList;

						//		    currentRecord.ProductList = StringUtils.EMPTY;
						// we found the product - retrieve the information
						for (int i = 0; i < validProductList.getProductCount(); i++) {
							aCustProductInfo = validProductList.getProduct(i);

							currentRecord.RatePlans.add(aCustProductInfo);
							currentRecord.SubscriptionID = aCustProductInfo.getSubID();

							LOG_PROCESSING.debug(currentRecord.concatHeader(1, "Prod " + (i + 1) + ": " + aCustProductInfo.getProductID()));

							//                        result = result + aCustProductInfo.getProductID() + ",";
						}

						result = true;
					}
				}
			}

		} catch (ProcessingException ex) {

			currentRecord.addError(new RecordError("ALIAS_LOOKUP; ERROR: " + ex.toString(), ErrorType.LOOKUP_FAILED, getSymbolicName()));

		}

		return result;

	}
}
