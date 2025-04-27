class CreateNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :content
      t.references :group, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
