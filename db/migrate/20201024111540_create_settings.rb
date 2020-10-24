class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.integer :interval
      t.decimal :max_usage
      t.decimal :initial_period
      t.decimal :last_period

      t.timestamps
    end
  end
end
