# frozen_string_literal: true

class AddUserIdToMessages < ActiveRecord::Migration[7.0]
  def change
    add_reference :messages, :user, null: false, foreign_key: true, default: User.first.id
  end
end
