public class GS_CommandFactory {

    private static final String DOT = '.';
    private static final String COMMAND_CONTAINER_NAME = 'GS_CommandContainer';
    private static final String COMMAND_NAME_TEMPLATE = COMMAND_CONTAINER_NAME + DOT + 'GS_{0}Command';
    private static final String DEFAULT_COMMAND_NAME = 'GS_DefaultCommand';

    public static GS_CommandContainer.GS_Command create() {
        Type commandType = Type.forName(COMMAND_CONTAINER_NAME + DOT + DEFAULT_COMMAND_NAME);
        GS_CommandContainer.GS_Command command = (GS_CommandContainer.GS_Command)commandType.newInstance();
        return command;
    }

    public static GS_CommandContainer.GS_Command create(String commandName, Map<String, String> params) {
        if(String.isBlank(commandName)) {
            create();
        }

        String commandClassName = String.format(COMMAND_NAME_TEMPLATE, new String[] {commandName});
        Type commandType = Type.forName(commandClassName);
        if(commandType == null) {
            commandType = Type.forName(DEFAULT_COMMAND_NAME);
        }
        GS_CommandContainer.GS_Command command = (GS_CommandContainer.GS_Command)commandType.newInstance();
        command.setParams(params);
        return command;
    }
}