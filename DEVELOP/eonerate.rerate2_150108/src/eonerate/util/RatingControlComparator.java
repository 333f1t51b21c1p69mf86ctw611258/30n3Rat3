/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.util;

import eonerate.entity.RatingControl;
import java.util.Comparator;
import java.util.Map;

/**
 *
 * @author manucian86
 */
public class RatingControlComparator implements Comparator<String> {

    Map<String, RatingControl> base;

    public RatingControlComparator(Map<String, RatingControl> base) {
        this.base = base;
    }

    // Note: this comparator imposes orderings that are inconsistent with equals.    
    @Override
    public int compare(String a, String b) {
        int result = 0;

        try {
            result = base.get(a).Priority - base.get(b).Priority;
        } catch (Exception ex) {
            System.err.println("Comparation Error: " + ex.toString() + ex.getStackTrace());
        }

        return result;
    }
}
