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

end
