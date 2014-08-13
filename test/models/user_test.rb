require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'user name is deduced from email, first_name, last_name' do 
    @user = create(:user, email: 'model@test.local', password: 'password')
    @user.name.must_equal @user.email
    @user.build_member(first_name: 'FN', last_name: 'SN')
    @user.name.must_equal "#{@user.member.first_name} #{@user.member.last_name}"
  end

end
