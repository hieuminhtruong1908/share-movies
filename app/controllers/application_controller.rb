class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :track_params_to_logstash

  private
  def track_params_to_logstash
    RequestStore.store[:payload] = params
    RequestStore.store[:host] = request.host
  end
end
