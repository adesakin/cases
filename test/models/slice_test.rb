require 'test_helper'

class SliceTest < ActiveSupport::TestCase
  test "slice must have at least a step" do
    Slice.new.wont_be :valid?
  end

  test "slice is valid if it has steps" do
    slice = build(:slice)
    slice.steps << create(:step)
    slice.must_be :valid?
    slice.save
  end


  test "slice is scoped at creation and transitions to prepared" do
    slice = build(:slice)
    slice.steps << create(:step)
    slice.save
    slice.scoped?.must_equal true
    slice.done!
    slice.prepared?.must_equal true
  end

  test "slice at prepared done transits to analyzed or reverts to scoped" do
    slice = build(:slice)
    slice.steps << create(:step)
    slice.save
    slice.done! #transits to :prepared
    slice.done!
    slice.current_state.to_s.must_equal "analyzed"
    slice.revert!
    slice.current_state.to_s.must_equal "prepared"
    slice.revert!
    slice.current_state.to_s.must_equal "scoped"
  end

  test "slice at analyzed done transits to implemented or reverts to prepared" do
    slice = build(:slice)
    slice.steps << create(:step)
    slice.save
    2.times {slice.done!}
    slice.current_state.to_s.must_equal "analyzed"
    slice.done!
    slice.current_state.to_s.must_equal "implemented"
    2.times {slice.revert!}
    slice.current_state.to_s.must_equal "prepared"
  end


  test "slice at implemented done transits to verified or reverts to analyzed" do
    slice = build(:slice)
    slice.steps << create(:step)
    slice.save
    3.times {slice.done!}
    slice.current_state.to_s.must_equal "implemented"
    slice.done!
    slice.current_state.to_s.must_equal "verified"
    2.times {slice.revert!}
    slice.current_state.to_s.must_equal "analyzed"
  end


  test "slice at verified reverts to analyzed" do
    slice = build(:slice)
    slice.steps << create(:step)
    slice.save
    4.times {slice.done!}
    slice.current_state.to_s.must_equal "verified"

    2.times {slice.revert!}
    slice.current_state.to_s.must_equal "analyzed"
  end


      # state :implemented do
    #   event :done, :transitions_to => :verified
    #   event :revert, :transitions_to => :analyzed
    # end
    # state :verified do
    #   event :revert, :transitions_to => :implemented
    # end

  # test "the truth" do
  #   assert true
  # end
end



