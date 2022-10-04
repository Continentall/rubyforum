# frozen_string_literal: true

class AddMissingNullCheks < ActiveRecord::Migration[7.0]
  def change
    change_column_null :topics, :title, false
    change_column_null :topics, :body, false
    change_column_null :messages, :body, false
    # change_column_null - указывает могут ли указанные поля быть NULL или нет (в зависимости от bool в конце)
  end
end
