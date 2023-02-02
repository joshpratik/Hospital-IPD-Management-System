class ApplicationController < ActionController::API
  before_action :authenticate_user!
  load_and_authorize_resource
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  
  rescue_from CanCan::AccessDenied do |exception|
    render json: { warning: exception, status: 'authorization_failed'}, status:401
  end

  private

  def record_not_found
    render json:'record_not_found', status: :not_found 
  end
end
