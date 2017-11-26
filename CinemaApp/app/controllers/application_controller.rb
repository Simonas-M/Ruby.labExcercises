# frozen_string_literal: true

# default rails ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end
