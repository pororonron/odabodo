class ApplicationController < ActionController::Base
  before_action :is_matching_login_end_user, only: [:edit, :update]
end
