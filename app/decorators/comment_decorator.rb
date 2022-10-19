# frozen_string_literal: true

class CommentDecorator < ApplicationDecorator
    delegate_all
    decorates_association :user #Автоматически при декорировании comment декорировать связанную модель :user

    def for?(commentable)
      commentable = commentable.object if commentable.decorated? # если пременная задекорированна вытягиваем из нее образец класса

      commentable == self.commentable # self - конкретный комментарий / self.commentable - для чего комментарий был оставлен
    end
  end