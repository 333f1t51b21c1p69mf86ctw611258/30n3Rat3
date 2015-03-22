/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package eonerate.entity;

import ElcRate.record.ChargePacket;

/**
 *
 * @author manucian86
 */
public class MyChargePacket extends ChargePacket {
    
    public Integer TariffPriority;
    public Integer RCPriority;
    public Integer DiscountPriority;
    public Integer BalancePriority;
    public Integer DisplayPriority;
    
    public Integer POId;
    
}
