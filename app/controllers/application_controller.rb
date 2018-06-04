class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # Session Helper for logging in
  include SessionsHelper

  def hello
  	render html: "hello, world!"
  end
end
