class CreateShoppingListEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :shopping_list_emails do |t|
      t.references :shopping_list, null: false, foreign_key: true
      t.date :send_date, null: false
      t.integer :file_format, null: false
      t.string :recipient, null: false
      t.boolean :send, null: false, default: false

      t.timestamps
    end
  end
end
