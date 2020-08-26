require 'cfn-nag/violation'
require 'cfn-nag/base_rule'

class UnumTagRule < CfnNag::BaseRule
  VALID_TAGS = ['COSTCENTER', 'STACK']
  attr_reader :resource_type
  def initialize resource_type: nil
    @resource_type = resource_type
  end

  def rule_id
    'F999999'
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_text
    'CONSTCENTER AND STACK check'
  end

  def audit_impl(cfn_model)
    tracker = Hash.new { |h, k| h[k] = 0 } # to track duplicate valid tags 

    violating_domains = cfn_model.resources_by_type(resource_type).select do |app|
      invalid_tag = false

      app.tags.each do |tag|
        key, value = tag.values_at('Key', 'Value') # GET values from Hash
        tracker[key] += 1
        if !VALID_TAGS.include?(key) || value.nil? || tracker[key] > 1
          puts "Violating tag #{key} #{value} #{tracker[key]}"
          invalid_tag = true
        end
      end
      invalid_tag
    end
    violating_domains.map(&:logical_resource_id)
  end
end
