class Topic < ApplicationRecord  #ApplicationRecord < ActiveRecord
    validates :title, presence: true, length: {minimum:2} #Валидация заголовка на его наличие и длину более 2
    validates :body, presence: true, length: {minimum:2}
end
