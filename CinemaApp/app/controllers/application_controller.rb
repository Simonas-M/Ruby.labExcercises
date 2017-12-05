# frozen_string_literal: true

# default rails ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :respond
  helper_method :redirect
  helper_method :validate_params

  def redirect(format, path, notice = '')
    format.html { redirect_to(path, {notice: notice}) }
  end

  def respond(path, notice = '', status)
    respond_to do |format|
      redirect(format, path, notice)
    end
  end

  def validate_params(*parameters)
    parameters.each { |param| params.require(param) }
  end
end
