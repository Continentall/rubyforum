# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authorization
  include Pagy::Backend
  # Модули (concerns) будут не доступны если не подключить их в главный контроллер
  include ErrorHandling
  include Authentication
  include Internationalization
end
