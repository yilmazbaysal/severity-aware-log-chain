import com.owlike.genson.Genson;
import org.hyperledger.fabric.contract.Context;
import org.hyperledger.fabric.contract.ContractInterface;
import org.hyperledger.fabric.contract.annotation.Contract;
import org.hyperledger.fabric.contract.annotation.Default;
import org.hyperledger.fabric.contract.annotation.Info;
import org.hyperledger.fabric.contract.annotation.Transaction;
import org.hyperledger.fabric.shim.ChaincodeException;
import org.hyperledger.fabric.shim.ChaincodeStub;


@Contract(
        name = "LogRecords",
        info = @Info(
                title = "LogRecords contract",
                description = "Chaincode for the blockchain-based log storage",
                version = "1.0"
        )
)
@Default
public class LogRecordRepository implements ContractInterface {

    private final Genson genson = new Genson();

    @Transaction()
    public void initLedger(final Context context) {
    }

    @Transaction()
    public LogRecord getLogRecord(final Context context, final String key) {
        String logRecordState = context.getStub().getStringState(key);

        // Check the existence of the record
        if (logRecordState.isEmpty()) {
            throw new ChaincodeException("LogRecord " + key + ": DOES NOT EXIST!");
        }

        return genson.deserialize(logRecordState, LogRecord.class);
    }

    @Transaction()
    public LogRecord createLogRecord(final Context context, final String key, final String logContent) {
        ChaincodeStub chaincodeStub = context.getStub();
        String logRecordState = chaincodeStub.getStringState(key);

        // Check the existence of the record
        if (!logRecordState.isEmpty()) {
            throw new ChaincodeException("LogRecord " + key + ": ALREADY EXIST!");
        }

        LogRecord logRecord = new LogRecord(logContent);
        chaincodeStub.putStringState(key, genson.serialize(logRecord));
        return logRecord;
    }
}
