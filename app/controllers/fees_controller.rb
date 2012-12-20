class FeesController < InheritedResources::Base
  actions :new, :create, :index, :destroy
  http_basic_authenticate_with name: "username", password: "secret", except: [:new, :create]
  
  def create
    create! { new_fee_path }
  end
end
