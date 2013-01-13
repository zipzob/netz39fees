class FeesController < InheritedResources::Base
  actions :new, :create, :index, :destroy
  before_filter :authenticate, only: [:index, :destroy]
  before_filter :set_locale
  
  def create
    create!(notice: t(:fee_email_send_alert)) { new_fee_path }
  end
  
  def confirm
    @fee = Fee.find_by_confirmation_token(params[:token])
    if @fee
      @fee.confirmed = true
      @fee.save!
    end
  end
  
  def edit
    @fee = Fee.find_by_confirmation_token(params[:token])
  end
  
  def update
    @fee = Fee.find_by_confirmation_token(params[:token])
    if @fee.update_attributes(params[:fee])
      flash[:notice] = t :fee_update
      redirect_to fees_edit_path
    else
      render :action => 'edit'
    end
  end
end
