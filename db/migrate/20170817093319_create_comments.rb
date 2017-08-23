class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :post, index: true, foreign_key: true
      t.belongs_to :user
      t.belongs_to :post
      t.timestamps null: false
    end
  end
end
