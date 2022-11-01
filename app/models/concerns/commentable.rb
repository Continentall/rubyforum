# frozen_string_literal: true

module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :commentable, dependent: :destroy
    # Данный concern позволяет подключить к модели следующую логику:
    # Модель имеет много коментариев и это отношнение будет называться commentable (commentable user) - комментируемый пользователь
    # В модели comment мы уже указывали это отношение:
    # belongs_to :commentable, polymorphic: true
  end
end
