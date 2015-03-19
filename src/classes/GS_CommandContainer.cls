public class GS_CommandContainer {

    public abstract class GS_Command {

        private Map<String, String> params = new Map<String, String>();

        public void setParams(Map<String, String> params) {
            this.params = params;
        }

        public GS_RestResponse execute() {
            try {
                Object resultObject = perform();
                return new GS_RestResponse(GS_StatusCode.OK, getMessage(), resultObject);
            } catch (GS_Exception exp) {
                String message = exp.getMessage() + exp.getStackTraceString();
                return new GS_RestResponse(GS_StatusCode.ERROR, message);
            } catch (Exception exp) {
                String message =  exp.getMessage() + exp.getStackTraceString();
                return new GS_RestResponse(GS_StatusCode.ERROR, message);
            }
        }

        public abstract Object perform();

        public virtual String getMessage() {
            return null; 
        }
    }

    public class GS_FirstTestCommand extends GS_Command {

        public override Object perform() {
            return 'FirstTestResult + Params : ' + params;
        }

        public override String getMessage() {
            return 'FirstTestMessage';
        }
    }

    public class GS_SecondTestCommand extends GS_Command {

        public override Object perform() {
            return 'SecondTestResult + Params : ' + params;
        }

        public override String getMessage() {
            return 'SecondTestMessage';
        }
    }

    public class GS_DefaultCommand extends GS_Command {

        public override Object perform() {
            return 'This is defult result.';
        }

        public override String getMessage() {
            return 'This is default message.';
        }
    }
}