package eonerate.data;

import ElcRate.adapter.jdbc.JDBCOutputAdapter;
import ElcRate.record.BalanceImpact;
import ElcRate.record.DBRecord;
import ElcRate.record.IRecord;
import eonerate.entity.RatRec;
import java.util.ArrayList;
import java.util.Collection;

public class BalOutputAdapter extends JDBCOutputAdapter {

    @Override
    public Collection<IRecord> procValidRecord(IRecord r) {
        RatRec inRecord;
        DBRecord dbRecord;
        Collection<IRecord> outbatch;
        BalanceImpact aBalanceImpact;
        int i;

        outbatch = new ArrayList<IRecord>();

        inRecord = (RatRec) r;

        for (i = 0; i < inRecord.getBalanceImpactCount(); i++) {
            aBalanceImpact = inRecord.getBalanceImpact(i);
            dbRecord = new DBRecord();

            dbRecord.setOutputColumnCount(6);
            dbRecord.setOutputColumnInt(0, inRecord.BalanceGroup);
            dbRecord.setOutputColumnInt(1, aBalanceImpact.counterID);
            dbRecord.setOutputColumnLong(2, aBalanceImpact.recID);
            dbRecord.setOutputColumnLong(3, aBalanceImpact.startDate);
            dbRecord.setOutputColumnInt(4, (int) aBalanceImpact.endDate);
//            dbRecord.setOutputColumnDouble(5, aBalanceImpact.balanceDelta);
            dbRecord.setOutputColumnDouble(5, aBalanceImpact.balanceAfter);

            outbatch.add((IRecord) dbRecord);
        }

        return outbatch;

    }

    @Override
    public Collection<IRecord> procErrorRecord(IRecord r) {
        return null;
    }

}
