# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  # Модули (concerns) будут не доступны если не подключить их в главный контроллер
  include ErrorHandling
  include Authentication
end
