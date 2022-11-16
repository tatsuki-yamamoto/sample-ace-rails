class CreateTodos < ActiveRecord::Migration[7.0]
  def change
    create_table :todos do |t|
      t.string :title, null: false, comment: 'タイトル'
      t.text :description, comment: '説明'
      t.integer :status, unsigned: true, null: false, default: 0, comment: '状態'

      t.timestamps
    end
  end
end
