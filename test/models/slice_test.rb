require 'test_helper'

class SliceTest < ActiveSupport::TestCase
  test "slice must have at least a step" do
    skip "Next step"
    Slice.new.wont_be :valid?
  end
  # test "the truth" do
  #   assert true
  # end
end



