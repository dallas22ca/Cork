class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :configure_devise_params, if: :devise_controller?
  before_filter :set_folders, if: :user_signed_in?
  
  private
  
  def set_folders
    @folders ||= current_user.folders.active
  end
  
  def set_folder
    @folder ||= (
      if controller_name == "folders"
        @folders.find(params[:id])
      elsif params[:folder_id]
        @folders.find(params[:folder_id])
      end
    )
  end
  
  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:password, :password_confirmation, :remember_me, :name, :phone, :website, :email) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:remember_me, :email) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:password, :password_confirmation, :name, :phone, :email, :website, :avatar, :brokerage_id, brokerage_attributes: [:id, :name, :website, :logo]) }
  end
end
