class Comment < ApplicationRecord
    belongs_to :commentable, polymorphic: true # Тут модель comment становится полиморфически зависимой от некоторой вирутальной модели commentable 
    belongs_to :user

    validates :body, presence: true, length: { minimum: 2 }
end
