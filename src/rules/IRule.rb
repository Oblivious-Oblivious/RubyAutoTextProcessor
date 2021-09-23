# Interface to be implemented by specific subclasses
# for handling of paragraph characterization
class IRule
    # Decides if the paragraph abides by the rule
    #
    # @param paragraph -> The lineblock under test
    # @return true if the lineblock abides by the test of the rule
    def is_valid?(paragraph) = self;

    # For debugging and testing purposes
    # Outputs a string on what the rule does
    def to_s = self;
end
