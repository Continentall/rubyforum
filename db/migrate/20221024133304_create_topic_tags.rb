class CreateTopicTags < ActiveRecord::Migration[7.0]
  def change
    create_table :topic_tags do |t|
      t.belongs_to :topic, null: false, foreign_key: true
      t.belongs_to :tag, null: false, foreign_key: true

      t.timestamps
    end
    add_index :topic_tags, [:topic_id, :tag_id], unique: true
  end
end
