class CreateUserIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :user_ingredients do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :checked, default: false

      t.timestamps
    end
  end
end
