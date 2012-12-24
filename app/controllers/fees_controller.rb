class FeesController < InheritedResources::Base
  actions :new, :create, :index, :destroy
  http_basic_authenticate_with name: "username", password: "secret", except: [:new, :create, :activate, :edit, :update]
  
  def create
    create!(notice: "Fee was successfully created. An email with an activation link was send to your email address. Please click this link to activate your fee.") { new_fee_path }
  end
  
  def activate
    @fee = Fee.find_by_activation_token(params[:token])
    if @fee
      @fee.activated = 1
      @fee.save
    end
  end
  
  def edit
    @fee = Fee.find_by_activation_token(params[:token])
  end
  
  def update
    @fee = Fee.find_by_activation_token(params[:token])
    if @fee.update_attributes(params[:fee])
      flash[:notice] = "Successfully updated fee."
      redirect_to fees_edit_path
    else
      render :action => 'edit'
    end
  end
end
