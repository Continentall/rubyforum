class Message < ApplicationRecord
  belongs_to :topic # Пусть это указанно в БД. Но тут надо указать тоже чтобы использовать эту связь делая запросы кодом Ruby

  validates :body, presence: true, length: {minimum:2 }

end
