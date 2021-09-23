# Interface for the exporter classes
# Each class should at least have an api for an export message
class IExporter
    # Exports paragraphs to an external file system according to type
    #
    # @return The number of total paragraphs exported
    def export = self;
end
