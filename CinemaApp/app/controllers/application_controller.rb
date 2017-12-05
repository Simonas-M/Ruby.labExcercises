# frozen_string_literal: true

# default rails ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :respond_and_notify
  helper_method :redirect_and_notify
  helper_method :validate_params

  def redirect_and_notify(format, path, notice)
    format.html { redirect_to(path, notice: notice) }
  end

  def respond_and_notify(path, notice = '')
    respond_to do |format|
      redirect_and_notify(format, path, notice)
    end
  end

  def validate_params(*parameters)
    parameters.each { |param| params.require(param) }
  end
end
