class FeesController < InheritedResources::Base
  actions :new, :create, :index, :destroy
  http_basic_authenticate_with name: "username", password: "secret", except: [:new, :create, :confirm, :edit, :update]
  before_filter :set_locale
  
  def create
    create!(notice: t(:fee_email_send_alert)) { new_fee_path }
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
      flash[:notice] = t :fee_update
      redirect_to fees_edit_path
    else
      render :action => 'edit'
    end
  end
  
  private
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
