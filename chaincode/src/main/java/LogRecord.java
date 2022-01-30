import com.owlike.genson.annotation.JsonProperty;
import org.hyperledger.fabric.contract.annotation.DataType;
import org.hyperledger.fabric.contract.annotation.Property;

@DataType
public final class LogRecord {

    @Property()
    private final String content;


    public LogRecord(@JsonProperty("content") final String content) {
        this.content = content;
    }


    public String getContent() {
        return content;
    }
}
