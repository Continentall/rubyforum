# frozen_string_literal: true

# ApplicationRecord < ActiveRecord
class Topic < ApplicationRecord
  include Commentable
  
  has_many :messages, dependent: :destroy # Пусть это указанно в БД. Но тут надо указать тоже чтобы использовать эту связь делая запросы кодом Ruby
  # :dependent - Управляет тем, что произойдет со связанными объектами, когда его владелец будет уничтожен: destroy - одна из его опций
  # Все опци смотреть тут (6.25 пункт): http://rusrails.ru/active-record-associations#dependent3
  belongs_to :user
  has_many :topic_tags, dependent: :destroy
  has_many :tags, through: :topic_tags

  validates :title, presence: true, length: { minimum: 2 } # Валидация заголовка на его наличие и длину более 2
  validates :body, presence: true, length: { minimum: 2 }

  scope :all_by_tags, ->(tag_ids) do
    topics = includes(:user, :topic_tags, :tags)
    topics = topics.joins(:tags).where(tags: tag_ids) if tag_ids
    topics.order(created_at: :desc)
  end
end
