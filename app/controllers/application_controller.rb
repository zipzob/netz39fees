class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private

  def authenticate_me
    authenticate_or_request_with_http_basic("Application") do |name, password|
      user = User.find_by_username(name)
      user && user.authenticate(password)
    end
  end
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  helper_method :set_locale, :authenticate_me
end
