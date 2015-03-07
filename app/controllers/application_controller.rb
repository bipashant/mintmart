class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  add_breadcrumb "HOME", :root_path,:title => "Back to the Index"
  protect_from_forgery with: :exception
  before_action :authenticate_user!
end
