class Message < ApplicationRecord
  belongs_to :topic # Пусть это указанно в БД. Но тут надо указать тоже чтобы использовать эту связь делая запросы кодом Ruby

  validates :body, presence: true, length: {minimum:2 }

  def formatted_created_at 
    self.created_at.strftime('%d.%m.%Y %H:%M') # применит strftime к created_at полю у элемента для которого вызван formatted_created_at
  end
end
