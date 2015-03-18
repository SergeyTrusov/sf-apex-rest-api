public class GS_CommandContainer {

    public class GS_CommandFactory {

        private static final String COMMAND_NAME_TEMPLATE = 'GS_{0}Command';
        private static final String DEFAULT_COMMAND_NAME = 'GS_DefaultCommand';

        public static GS_ICommand create() {
            Type commandType = Type.forName(DEFAULT_COMMAND_NAME);
            GS_ICommand command = (GS_ICommand)commandType.newInstance();
            return command;
        }

        public static GS_ICommand create(String commandName) {
            if(String.isBlank(commandName)) {
                create();
            }

            String commandClassName = String.format(COMMAND_NAME_TEMPLATE, new String[] {commandName});
            Type commandType = Type.forName(commandClassName);
            if(commandType == null) {
                commandType = Type.forName(DEFAULT_COMMAND_NAME);
            }
            GS_ICommand command = (GS_ICommand)commandType.newInstance();
            return command;
        }
    }

    public interface GS_ICommand {
        execute();
        perform();
    }

    public abstract class GS_CommandBase implements GS_ICommand {

        public String execute() {
            try {
                GS_Result resultObject = perform();
                return GS_WSResult.toJSON(
                    GS_StatusCode.OK, 
                    getMessage(),
                    resultObject);
            } catch (GS_Exception e) {
                String message = GS_SettingsProvider.isDebugMode() ? e.getMessage() + e.getStackTraceString() : e.getMessage();
                return GS_WSResult.toJSON(GS_StatusCode.ERROR, message);
            } catch (Exception e) {
                String message = GS_SettingsProvider.isDebugMode() ? e.getMessage() + e.getStackTraceString() 
                    : GSTWCConstants.UNEXPECTED_ERORR;
                return GS_WSResult.toJSON(GS_StatusCode.ERROR, message);
            }
        }

        public abstract GS_Result perform(String jsonParameter);

        public virtual String getMessage() {
            return null; 
        }
    }

    public class GS_FirstTestCommand extends GS_CommandBase {
        
    }

    public class GS_SecondTestCommand extends GS_CommandBase {
        
    }

    public class GS_DefaultCommand extends GS_CommandBase {
        
    }
}