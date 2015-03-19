public class GS_RestApiController {

    private static final String COMMAND_NAME_PARAM = 'command';

    private Map<String, String> commandAliasNameMap =  new Map<String, String>{
        'test' => 'FirstTest'
    };

    public String response {get; private set;}

    public GS_RestApiController() {
    }

    private GS_CommandContainer.GS_ICommand chooseCommand() {

        Map<String, String> parameters = ApexPages.currentPage().getParameters();

        String commandName = parameters.get(COMMAND_NAME_PARAM);

        if (commandAliasNameMap.containsKey(commandName)) {
            commandName = commandAliasNameMap.get(commandName);
        }
        
        return GS_CommandFactory.create(commandName);
    }

    public void execute() {
        //this.response = chooseCommand().execute();
    }
}