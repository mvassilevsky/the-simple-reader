class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [:new_posts_first, :unread_only])
  end

  def update_resource(resource, params)
    if params[:password] || params[:password_confirmation] ||
       params[:current_password]
      super
    else
      resource.update_without_password(params)
    end
  end
end
