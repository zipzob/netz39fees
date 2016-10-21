class UsersController < ApplicationController
  before_filter :authenticate
  before_filter :set_locale

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'Successfully created new user.'
      redirect_to users_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:fee])
      flash[:notice] = 'Successfully updated user.'
      redirect_to users_url
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = 'Successfully deleted user.'
      redirect_to users_url
    end
  end
end
