class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def hello
    render text: "HELM! 108!"
  end

  def goodbye
    render text: "¡Helm to 108‽"
  end

end
