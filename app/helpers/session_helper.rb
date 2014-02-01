module SessionHelper

  def sign_in user
    token = Artist.generate_token
    cookies.permanent[:remember_token] = token
    user.update_attribute :remember_token, Artist.encrypt(token)
    self.current_user = user
  end

  def signed_id?
    current_user != nil
  end

  def current_user= user
    @current_user = user
  end

  def current_user
    remember_token = Artist.encrypt cookies[:remember_token]
    @current_user ||= Artist.find_by remember_token: remember_token
  end

  def current_user? user
    current_user == user
  end

  def sign_out
    self.current_user = nil
    cookies.delete :remember_token
  end

  def signed_id_user
    unless signed_id?
      store_location
      redirect_to signin_url, notice: "Log in to proceed"
    end
  end
  
  def redirect_back_or default
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

end
