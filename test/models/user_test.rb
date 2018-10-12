require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
   test "login with invalid credentials" do
    post :login, :user => {:email => 'foo', :password =>'bar'}
    assert_equals flash[:error] , "Authentication failed"
  end
end
