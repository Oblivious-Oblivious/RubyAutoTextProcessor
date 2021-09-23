require_relative "../datamodel/StyleEnum";
require_relative "../datamodel/FormatEnum";

# Class to represent a set of rules
#
# The main idea of the class is that it has a field for every rule of interest.
# So, it has rules for headings and rules for style.
# Headings: the class has a rule for what to omit,
# a rule for how to handle heading 1, a rule for handling heading 2
# Style: the class has a rule for bold and a rule for italics.
#
# All these rules dictate when sth is t obe treated as h1, or bold, etc.
# If an item does not apply by any of the "heading" rules, it is by default NORMAL
# If an item does not apply by any of the "style" rules, it is by default REGULAR
#
# The class comes with two methods, that, given a LineBlock,
# decide which classification applies (a) for its heading and (b) for its style
class RuleSet
    private attr_reader :name, :omit_rule, :h1_rule, :h2_rule, :bold_rule, :italics_rule;

    def initialize(name, omit_rule, h1_rule, h2_rule, bold_rule, italics_rule)
        @name = name;
        @omit_rule = omit_rule;
        @h1_rule = h1_rule;
        @h2_rule = h2_rule;
        @bold_rule = bold_rule;
        @italics_rule = italics_rule;
    end

    def determine_heading_status(lineblock)
        if omit_rule.is_valid?(lineblock)
            StyleEnum::OMITTED;
        elsif h1_rule.is_valid?(lineblock)
            StyleEnum::H1;
        elsif h2_rule.is_valid?(lineblock)
            StyleEnum::H2;
        else
            StyleEnum::NORMAL;
        end
    end

    def determine_format_status(lineblock)
        if bold_rule.is_valid?(lineblock)
            FormatEnum::BOLD;
        elsif italics_rule.is_valid?(lineblock)
            FormatEnum::ITALIC;
        else
            FormatEnum::NORMAL;
        end
    end

    def to_s
        return "
            #{name}\n
            OMIT: #{omit_rule}\n
            H1: #{h1_rule}\n
            H2: #{h2_rule}\n
            BOLD: #{bold_rule}\n
            ITALICS: #{italics_rule}\n
        ";
    end
end
