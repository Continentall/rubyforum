# frozen_string_literal: true

class TopicDecorator < ApplicationDecorator
  delegate_all
  decorates_association :user #Автоматически при декорировании topic декорировать связанную модель :user

  def formatted_created_at
     l created_at, format: :long
  end
end
