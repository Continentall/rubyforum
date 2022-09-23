class Topic < ApplicationRecord  #ApplicationRecord < ActiveRecord
    has_many :messages, dependent: :destroy # Пусть это указанно в БД. Но тут надо указать тоже чтобы использовать эту связь делая запросы кодом Ruby
#:dependent - Управляет тем, что произойдет со связанными объектами, когда его владелец будет уничтожен: destroy - одна из его опций
# Все опци смотреть тут (6.25 пункт): http://rusrails.ru/active-record-associations#dependent3

    validates :title, presence: true, length: {minimum:2} #Валидация заголовка на его наличие и длину более 2
    validates :body, presence: true, length: {minimum:2}

    def formatted_created_at 
        self.created_at.strftime('%d.%m.%Y %H:%M') # применит strftime к created_at полю у элемента для которого вызван formatted_created_at
    end
end
