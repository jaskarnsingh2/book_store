class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
  
    protected
  
    # Permit the additional parameter `province_id`
    def configure_sign_up_params
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :province_id, :name])
      end
      
  end
  