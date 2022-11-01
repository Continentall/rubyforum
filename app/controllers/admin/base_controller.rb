# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    def authorize(record, query = nil)
      super([:admin, record], query)
    end
  end
end
# Эту штука позволяет писать не authorize [:admin, user] а просто authorize user
# В админском контроллере (куда подключен этот контроллер)
