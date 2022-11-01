# frozen_string_literal: true

class RemoveDefaultUserIdFromTopicsMessages < ActiveRecord::Migration[7.0]
  # Метод вызываемый при применении миграции
  def up
    change_column_default :topics, :user_id, from: User.first.id, to: nil
    change_column_default :messages, :user_id, from: User.first.id, to: nil
  end

  # Метод вызываемый при откате применении миграции
  def down
    change_column_default :topics, :user_id, from: nil, to: User.first.id
    change_column_default :messages, :user_id, from: nil, to: User.first.id
  end
end
