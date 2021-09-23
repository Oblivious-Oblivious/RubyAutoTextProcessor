# Interface for defining basic use cases
class IMain
    # Option for registering a specific ruleset for editing
    #
    # @return true if all compiles correctly else exit with an error message
    def register_rule_set = self;

    # Option for loading a file to edit
    #
    # @return true
    def load_data = self;
    
    # Option for crafting a report with gathered data
    #
    # @return true
    def get_report = self;

    # Option to export the edited file to pdf of md
    #
    # @return true if all compiles correctly else exit with an error message
    def export_to_filetype = self;
end
