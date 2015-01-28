class PublicController < ApplicationController
  def index
    raise ActionController::RoutingError.new('Not Found')
  end
end
