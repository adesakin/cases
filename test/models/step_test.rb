require 'test_helper'

class StepTest < ActiveSupport::TestCase
  def setup
    @use_case = create(:use_case)
    @use_case.steps.build
    @step = @use_case.steps[0]
    @standard = @use_case.steps.create(type: 'Standard')
    @alternate = @use_case.steps.create(type: 'Alternate')
  end

  test "valid step definition" do
    @step.must_be :valid?
    @step.must_respond_to :use_case
  end

  test "manage a standard flow step" do
    @step.type = "Standard"
    assert_difference('Standard.count') do
      @step.save
    end

    #auto assign custom id
  end

  test "manage a alternate flow step" do
    @step.type = "Alternate"
    assert_difference('Alternate.count') do
      @step.save
    end
  end

  test "full description for step" do
    @step.full_desc.must_equal "#{@step.custom_id} #{@step.description}"
  end

  test "assign custom id" do
    @step.save
    @next_standard = @use_case.steps.create(type: 'Standard')
    @next_standard.custom_id.must_equal "SF.#{@use_case.id}.#{(@standard.custom_id.split('.')[2].to_i + 1).to_s}"

    @next_alternate = @use_case.steps.create(type: 'Alternate')
    @next_alternate.custom_id.must_equal "AF.#{@use_case.id}.#{(@alternate.custom_id.split('.')[2].to_i + 1).to_s}"
  end

end
