class FeesController < InheritedResources::Base
  actions :new, :create
  
  def create
    create! { new_fee_path }
  end
end
