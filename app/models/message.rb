# frozen_string_literal: true

class Message < ApplicationRecord
  include Commentable
  
  belongs_to :topic # Пусть это указанно в БД. Но тут надо указать тоже чтобы использовать эту связь делая запросы кодом Ruby
  belongs_to :user
  
  validates :body, presence: true, length: { minimum: 2 }
end
