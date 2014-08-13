require 'test_helper'

class ManageMembersTest < ActionDispatch::IntegrationTest
  def setup
    @user_new = create(:user)
    @member = @user_new_create_member
    user_sign_in
  end

  def teardown
    
  end

  test 'access members from root page' do
    visit root_path
    find('#header').click_on('Members')
    current_path.must_equal members_path

    member_rows = page.all('table#members tbody tr')
    member_rows.count.must_equal Member.count
  end


  it 'creates a new member on page', :js => true do
    visit members_path
    #need to test js methods
  end

  it 'lists members and their names' do
    visit members_path
  end

  it 'shows a member on page', :driver => :poltergeist do
    @member_new = create(:member_new)
    visit members_path
    find('table#members').click_on(@member_new.user.name)
    #need to test js methods
  end
end
