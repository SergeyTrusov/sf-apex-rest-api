public class GS_RestApiController {

    private static final String COMMAND_NAME_PARAM = 'command';

    private Map<String, String> commandAliasNameMap =  new Map<String, String>{
        'test' => 'FirstTest'
    };

    public String response {get; private set;}

    public GS_RestApiController() { }

    public void execute() {
        this.response = getCommand().execute().toJSON();
    }

    private GS_CommandContainer.GS_Command getCommand() {

        Map<String, String> params = ApexPages.currentPage().getParameters();

        String commandName = params.get(COMMAND_NAME_PARAM);

        if (commandAliasNameMap.containsKey(commandName)) {
            commandName = commandAliasNameMap.get(commandName);
        }
        
        params.remove(COMMAND_NAME_PARAM);

        return GS_CommandFactory.create(commandName, params);
    }
}