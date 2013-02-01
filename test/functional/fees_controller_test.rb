require 'test_helper'

class FeesControllerTest < ActionController::TestCase
  setup do
    @fee = fees(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fee" do
    assert_difference('Fee.count') do
      post :create, fee: { donation: @fee.donation, name: @fee.name, email: @fee.email, iban: @fee.iban, bic: @fee.bic }
    end

    assert_redirected_to new_fee_path
  end
end
