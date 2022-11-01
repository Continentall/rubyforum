# frozen_string_literal: true

class RemoveDefaultUserIdFromTopicsMessages < ActiveRecord::Migration[7.0]
  # Метод вызываемый при применении миграции
  def change
    return unless User.all.any?

    change_column_default :topics, :user_id, from: User.first.id, to: nil
    change_column_default :messages, :user_id, from: User.first.id, to: nil
  end
end
