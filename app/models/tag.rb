# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :topic_tags, dependent: :destroy
  has_many :topic, through: :topic_tags

  validates :title, presence: true, uniqueness: true
end
