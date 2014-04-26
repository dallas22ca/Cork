class RegistrationsController < Devise::RegistrationsController
  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    
    if current_user.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      sign_in current_user, bypass: true
      redirect_to after_update_path_for(current_user)
    else
      render "edit"
    end
  end
end