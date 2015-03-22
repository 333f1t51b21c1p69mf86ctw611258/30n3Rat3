/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.entity;

/**
 *
 * @author manucian86
 */
public class PromoItem {

    public Boolean IsInternal;
    public String OfferId;
    public String BonusItemId;
    public String DiscountItemId;

    /**
     * Monthly, Weekly, ... hay ActivityEnd
     */
    public String DiscountAccumulatorPeriod;

    @Override
    public String toString() {
        return String.format("OID: %s; BIID: %s; DIID: %s; Per: %s; Int: %s",
                OfferId,
                BonusItemId,
                DiscountItemId,
                DiscountAccumulatorPeriod,
                IsInternal != false ? "1" : "0");
    }

}
