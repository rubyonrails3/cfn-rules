require 'cfn-nag/violation'
require 'cfn-nag/base_rule'

class UnumDescriptionRule < CfnNag::BaseRule


  attr_reader :resource_type
  def initialize resource_type: nil
    @resource_type = resource_type
  end

  def rule_id
    'S3 Check'
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_text
    'Description is missing for either file or parameters'
  end

  def audit_impl(cfn_model)
    file_description = cfn_model.raw_model['Description']
    validation_errors =  []
    cfn_model.parameters.each_pair do |parameter, value|
      validation_errors << "#{parameter} value is nil" if value.description.nil?
    end

    violating_domains = cfn_model.resources_by_type(resource_type).select do |app|
      if validation_errors.length == 0 and !file_description.nil?
        false
      else
        puts validation_errors
        true
      end
    end
    violating_domains.map(&:logical_resource_id)
  end
end
