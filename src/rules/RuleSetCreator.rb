require_relative "ConcreteRuleFactory";

# The class is responsible for creating a RuleSet, given a set of strings as input.
# The set of strings to specify the rules are given as input at the constructor of the class
# The constructor also needs the set of LineBlocks of the document (for the positional rules)
# and a name to discriminate the new RuleSet from the others
# The core of the processing is performed by method create_rule_set()
class RuleSetCreator
    private attr_reader :line_blocks, :input_spec, :name, :factory,
                        :omit_rule, :h1_rule, :h2_rule, :bold_rule, :italics_rule;

    # Switch on the first argument that signifies the rule type
    #
    # @param l -> The current rule list
    # @param current_rule -> The rule object to produce
    def produce_type_of_rule(l, current_rule)
        case l[0].strip.upcase
        when "OMIT"
            omit_rule = current_rule;
        when "H1"
            h1_rule = current_rule;
        when "H2"
            h2_rule = current_rule;
        when "<B>"
            bold_rule = current_rule;
        when "<I>"
            italics_rule = current_rule;
        else
            # TODO Turn into a puts
            raise "[RuleSetCreator] Wrong rule set specification syntax. Aborting";
        end
    end

    # Switch on the second argument that signifies the rule position
    #
    # @param l -> The current rule list
    # @return The newly produced rule
    def produce_position_of_rule(l)
        case l[1].strip.upcase
        when "STARTS_WITH"
            factory.create_rule_start_with(l[2]);
        when "ALL_CAPS"
            factory.create_rule_all_caps;
        when "POSITIONS"
            factory.create_rule_in_position(
                line_blocks,
                l[2].split(/\s*,\s*/).map { |item| item.to_i }
            );
        else
            factory.create_rule_undefined;
        end
    end

    # The constructor of the class initializes the attributes of the class to the default values
    # such that they are subsequently changed only if necessary
    # The most important aspect of the project is the specification
    # of the RuleSet by the clients of this class.
    # This is represented in the attribute this.input_spec,
    # which in turns is populated by the constructor's input parameter input_spec
    # The format is as follows: input_spec is a List of List<String>.
    # Each internal List<String> is a triplet of 3 strings:
    # (a) style of heading, i.e., H1, H2, OMIT, <B>, <I>
    # (b) when the rule is activated, i.e., STARTS_WITH, ALL_CAPS, POSITIONS
    # (c) the value pertaining to the rule
    # The only case where just a pair of strings is needed is ALL_CAPS
    # POSITIONS requires a single number or a comma-separated list of numbers as 3rd argument
    # For example, a triplet saying "OMIT", "POSITIONS" "4,5"
    # will omit the positions 4 and 5 in the list of paragraphs
    # As another example, a triplet saying "H1", "ALL_CAPS"
    # will treat all lines with all their characters as capital letters as H1
    #
    # @param line_blocks -> a List<LineBlock> representing the paragraphs of
    #                    the input (called LineBlocks in this project)
    # @param input_spec -> a List<List<String>> with the specification of behavior
    # @param name -> the name of the RuleSet to be created
    def initialize(line_blocks, input_spec, name)
        @line_blocks = line_blocks;
        @input_spec = input_spec;
        @name = name;

        @factory = ConcreteRuleFactory.new;
        dummy_rule = factory.create_rule_undefined;

        @omit_rule = dummy_rule;
        @h1_rule = dummy_rule;
        @h2_rule = dummy_rule;
        @bold_rule = dummy_rule;
        @italics_rule = dummy_rule;
    end

    # The class populates a new RuleSet with all its necessary
    # rules and returns it as the result of the processing
    # The class employs the abstract class IRule
    # (to be concreted with concrete subclasses per category of rule)
    # and the respective Factory. Thus, a set of concrete classes to
    # handle the rules of AllCaps, Position, StartsWith, or Undefined are needed.
    # At the end, the different kinds of rules of the RuleSet
    # are all populated with an object of the appropriate class.
    #
    # @return the RuleSet to be generated
    def create_rule_set
        input_spec.each do |l|
            current_rule = produce_position_of_rule(l);
            produce_type_of_rule(l, current_rule);

            # TODO Move outside boundaries
            puts "[RuleSetCreator] #{current_rule}";
        end
    end
end
