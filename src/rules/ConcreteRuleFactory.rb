# Creator of concrete rule objects
#
# For each concrete subclass, the factory comes with one method.
# Thus, the clients of the package need only work with
#   (a) the current factory for rule creation
#   (b) the AbstractRule abstract class for the actual work of a specific rule (rule validation)
class ConcreteRuleFactory
    def create_rule_undefined = RuleUndefined.new;
    def create_rule_all_caps = RuleAllCaps.new;
    def create_rule_in_position(line_blocks, positions) = RuleInPosition.new(line_blocks, positions);
    def create_rule_start_with(prefix) = RuleStartWith.new(prefix);
end
