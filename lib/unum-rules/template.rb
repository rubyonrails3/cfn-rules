require 'cfn-nag/violation'
require 'cfn-nag/base_rule'
require './lib/unum-rules-lib/UnumTagRule'
require './lib/unum-rules-lib/UnumDescriptionRule'

class :KLASS_NAME < CfnNag::BaseRule

  def rule_id
    ':KLASS_RULE_ID'
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_text
    "Tag names and Description check of #{resource_type}"
  end

  def audit_impl(cfn_model)
    UnumTagRule.new(resource_type: resource_type).audit_impl(cfn_model).concat(
      UnumDescriptionRule.new(resource_type: resource_type).audit_impl(cfn_model)
    )
  end

  private

  def resource_type
    ':RESOURCE_TYPE'
  end

end