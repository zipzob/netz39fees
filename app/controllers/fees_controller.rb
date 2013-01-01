class FeesController < InheritedResources::Base
  actions :new, :create, :index, :destroy
  http_basic_authenticate_with name: "username", password: "secret", except: [:new, :create, :confirm, :edit, :update]
  
  def create
    create!(notice: "Fee was successfully created. An email with a confirmation link was send to your email address. Please click this link to confirm your fee.") { new_fee_path }
  end
  
  def confirm
    @fee = Fee.find_by_confirmation_token(params[:token])
    if @fee
      @fee.confirmed = true
      @fee.save
    end
  end
  
  def edit
    @fee = Fee.find_by_confirmation_token(params[:token])
  end
  
  def update
    @fee = Fee.find_by_confirmation_token(params[:token])
    if @fee.update_attributes(params[:fee])
      flash[:notice] = "Successfully updated fee."
      redirect_to fees_edit_path
    else
      render :action => 'edit'
    end
  end
end
