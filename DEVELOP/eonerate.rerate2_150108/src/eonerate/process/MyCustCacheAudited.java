package eonerate.process;

import ElcRate.CommonConfig;
import ElcRate.ElcRate;
import ElcRate.cache.CustomerCacheAudited;
import ElcRate.exception.InitializationException;
import ElcRate.lang.AuditSegment;

public class MyCustCacheAudited
        extends CustomerCacheAudited {

    @Override
    public void addAuditedCPI(long auditSegId, long productRefId, String prodID, String subId, String service, long prodValidFrom, long prodValidTo) throws InitializationException {
//        super.addAuditedCPI(auditSegId, productRefId, prodID, subId, service, prodValidFrom, prodValidTo); //To change body of generated methods, choose Tools | Templates.

        AuditSegment tmpAuditSegment;

        // Recover the audit segment
        tmpAuditSegment = auditSegmentCache.get(auditSegId);

        if (tmpAuditSegment == null) {
            message = "Attempting to add a product <" + productRefId + "> to a non-existent audit segment <" + auditSegId + ">";
            ElcRate.getElcRateFrameworkLog().error(message);
        } else {
            // adjust the to high date
            if (prodValidTo == 0) {
                prodValidTo = CommonConfig.HIGH_DATE;
            }

            // Add the product to the audit segment
            tmpAuditSegment.getProductList().addProduct(productRefId, prodID, subId, service, prodValidFrom, prodValidTo, 1);

            int productCount = tmpAuditSegment.getProductList().getProductCount();
            tmpAuditSegment.getProductList().getProduct(productCount - 1).setProductRefId((int) productRefId);
        }
    }

}
