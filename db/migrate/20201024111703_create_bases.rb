class CreateBases < ActiveRecord::Migration[6.0]
  def change
    create_table :bases do |t|
      t.string :code
      t.string :email
      t.integer :level
      t.boolean :use

      t.timestamps
    end
  end
end
