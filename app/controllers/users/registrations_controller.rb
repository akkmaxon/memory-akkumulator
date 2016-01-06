class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
  after_action :create_welcome_article, only: [:create]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def create_welcome_article
    return unless user_signed_in?
    app_name = "Memory Akkumulator"
    content = "Hi, this is your first article.\n
	       You can edit me by clicking on my title.\n
	       Click to menu sign and choose 'Add article' for creating new articles.\n
	       For freshing your memory all articles will appear on the main page randomly.\n
	       You can filter which categories of articles should be hidden in menu point 'Edit profile'."
    category = Category.find_by(title: "Not specified") || Category.create(title: "Not specified")
    article = Article.create(
      title: "Welcome to #{app_name}!",
      content: content,
      user_id: current_user.id,
      category_id: category.id
    )
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end