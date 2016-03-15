class FeesController < ApplicationController
  before_filter :authenticate, only: [:index, :destroy, :edit_admin, :update_admin]
  before_filter :set_locale

  def index
    @overall = Fee.overall
    @fee_sum = Fee.sum :fee
    @donation_sum = Fee.sum :donation

    order = params[:order] if Fee.accessible_attributes.include?(params[:order]) || params[:order] == 'total'
    order = 'first_name' if order.nil?
    if order == 'total'
      @fees = Fee.all.sort! { |x,y| y.total <=> x.total }
    else
      @fees = Fee.order(order.to_sym)
    end

    respond_to do |format|
      format.html { render :index }
      format.xml {
        @direct_debit = DirectDebitFees.new(@fees, params[:sepa][:reference], params[:sepa][:remittance_information], params[:sepa][:requested_date], params[:sepa][:multiplier])
        send_data @direct_debit.to_xml, filename: "sepa.xml", type: "application/xml", :disposition => 'attachment'#, :disposition => 'inline'
      }
    end
  end

  def new
    @fee = Fee.new
  end

  def create
    @fee = Fee.new(params[:fee])
    if @fee.save
      FeeMailer.confirmation(@fee).deliver
      FeeMailer.new_fee(@fee).deliver
      flash[:notice] = t(:fee_email_send_alert)
      redirect_to new_fee_path
    else
      render 'new'
    end
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
      FeeMailer.notification(@fee).deliver
      FeeMailer.fee_changed(@fee).deliver
      flash[:notice] = t :fee_update
      redirect_to fees_edit_path
    else
      render 'edit'
    end
  end

  def edit_admin
    @fee = Fee.find(params[:id])
  end

  def update_admin
    @fee = Fee.find(params[:id])
    if @fee.update_attributes(params[:fee])
      FeeMailer.notification(@fee).deliver
      flash[:notice] = t :fee_update
      redirect_to fees_url
    else
      render 'edit_admin'
    end
  end

  def destroy
    @fee = Fee.find(params[:id])
    @fee.destroy
    flash[:notice] = "Successfully deleted fee."
    redirect_to fees_url
  end
end
