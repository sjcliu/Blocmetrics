class API::EventsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    byebug
    registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])
  end
end
