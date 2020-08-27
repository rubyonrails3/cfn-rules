require 'cfn-nag/violation'
require 'cfn-nag/base_rule'
require './lib/unum-rules-lib/UnumDescriptionRule'

class SecretsManagerRotationScheduleRule < CfnNag::BaseRule

  def rule_id
    'SECRETSMANAGERROTATIONSCHEDULERULE'
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_text
    "Description check of #{resource_type}"
  end

  def audit_impl(cfn_model)
    UnumDescriptionRule.new(resource_type: resource_type).audit_impl(cfn_model)
  end

  private

  def resource_type
    'AWS::SecretsManager::RotationSchedule'
  end
end
