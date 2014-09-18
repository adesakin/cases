require 'test_helper'

class UseCaseTest < ActiveSupport::TestCase
  test 'use case must have a project_id' do
  	use_case = UseCase.new
  	use_case.valid?(:project_id).must_equal false
  	use_case.project_id = 1  	
  end

  test 'project must be touched after modifying its use case' do
    @use_case = create(:use_case)
    @use_case.project.updated_at.must_be :>=, @use_case.updated_at
  end

  test "returns all slices associated with a use case" do 
    @use_case = create(:use_case)
    step_one = create(:step, use_case: @use_case, type: "Standard")
    step_two = create(:step, use_case: @use_case, type: "Standard")
    slice_one = build(:slice)
    slice_one.steps << step_one
    slice_two = build(:slice)
    slice_two.steps << step_two
    slice_one.save; slice_two.save
    @use_case.slices.count.must_equal 2
    @use_case.slices.must_include slice_one
    @use_case.slices.must_include slice_two
  end


  test "use case is goal_established at creation and transitions to structure_understood" do
    @use_case = create(:use_case)
    @use_case.goal_established?.must_equal true
    @use_case.done!
    @use_case.structure_understood?.must_equal true
  end

  test "use_case at structure_understood done transits to simplest_fulfilled or reverts to goal_established" do
    @use_case = create(:use_case)
    @use_case.update(workflow_state: "structure_understood")
    @use_case.done!
    @use_case.simplest_fulfilled?.must_equal true
    2.times {@use_case.revert!}
    @use_case.goal_established?.must_equal true
  end

  test "use_case at simplest_fulfilled done transits to sufficient_fulfilled or reverts to structure_understood" do
    @use_case = create(:use_case)
    @use_case.update(workflow_state: "simplest_fulfilled")
    @use_case.simplest_fulfilled?.must_equal true
    @use_case.done!
    @use_case.sufficient_fulfilled?.must_equal true
    2.times {@use_case.revert!}
    @use_case.structure_understood?.must_equal true
  end

  test "use_case at sufficient_fulfilled done transits to all_fulfilled or reverts to simplest_fulfilled" do
    @use_case = create(:use_case)
    @use_case.update(workflow_state: "sufficient_fulfilled")
    @use_case.sufficient_fulfilled?.must_equal true
    @use_case.done!
    @use_case.all_fulfilled?.must_equal true
    2.times {@use_case.revert!}
    @use_case.simplest_fulfilled?.must_equal true
  end

  test "use_case at all_fulfilled reverts to sufficient_fulfilled" do
    @use_case = create(:use_case)
    @use_case.update(workflow_state: "all_fulfilled")
    @use_case.revert!
    @use_case.sufficient_fulfilled?.must_equal true
  end

end