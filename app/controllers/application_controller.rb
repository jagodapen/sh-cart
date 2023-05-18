# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from Base::Repository::RepositoryError, with: :redirect_to_index

  def redirect_to_index
    flash.alert = "Object doesn't exist"
    redirect_to action: "index"
  end
end
