class Topic < ApplicationRecord  #ApplicationRecord < ActiveRecord
    validates :title, presence :true, length: {minimum:2, maximum:256} #Валидация заголовка на его наличие и длину более 2
    validates :body, presence :true, length: {minimum:2, maximum:65},
end
