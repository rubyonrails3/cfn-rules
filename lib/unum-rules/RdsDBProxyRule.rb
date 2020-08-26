require 'cfn-nag/violation'
require 'cfn-nag/base_rule'
require './lib/unum-rules-lib/UnumTagRule'
require './lib/unum-rules-lib/UnumDescriptionRule'

class RdsDBProxyRule < CfnNag::BaseRule

  def rule_id
    'RDSDBPROXYRULE'
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
    'AWS::RDS::DBProxy'
  end

end
