# frozen_string_literal: true

class TopicDecorator < ApplicationDecorator
  delegate_all

  def formatted_created_at
    created_at.strftime('%d.%m.%Y %H:%M') # применит strftime к created_at полю у элемента для которого вызван formatted_created_at
  end
end