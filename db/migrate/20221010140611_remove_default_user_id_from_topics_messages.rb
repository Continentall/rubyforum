class RemoveDefaultUserIdFromTopicsMessages < ActiveRecord::Migration[7.0]
  def up # Метод вызываемый при применении миграции
    change_column_default :topics, :user_id, from: User.first.id, to: nil
    change_column_default :messages, :user_id, from: User.first.id, to: nil
  end

  def down # Метод вызываемый при откате применении миграции
    change_column_default :topics, :user_id, from: nil, to: User.first.id
    change_column_default :messages, :user_id, from: nil, to: User.first.id
  end
end
