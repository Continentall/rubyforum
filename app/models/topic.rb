class Topic < ApplicationRecord  #ApplicationRecord < ActiveRecord
    validates :title, presence: true, length: {minimum:2} #Валидация заголовка на его наличие и длину более 2
    validates :body, presence: true, length: {minimum:2}

    def formatted_created_at 
        self.created_at.strftime('%d.%m.%Y %H:%M') # применит strftime к created_at полю у элемента для которого вызван formatted_created_at
    end
end
