class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  WillPaginate.per_page = 30
end
