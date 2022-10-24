class Tag < ApplicationRecord
    has_many :topic_tags, dependent: :destroy
    has_many :topic, through: :topic_tags
end
