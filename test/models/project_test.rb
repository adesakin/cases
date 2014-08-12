require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test 'project must have a name and must be unique' do
  	@project = Project.new
  	@project.valid?(:name).must_equal false
  	@project.name = "Test Project"
  	@project.valid?(:name).must_equal true
  	@project.save
  	@project_2 = build(:project, name: "Test Project")
  	@project_2.valid?(:name).must_equal false
  	@project_2.name = "Test Project 2"
  	@project_2.valid?(:name).must_equal true
  end

  # test "the truth" do
  #   assert true
  # end
end
