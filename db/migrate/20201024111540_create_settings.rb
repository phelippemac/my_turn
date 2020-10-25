class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.decimal :interval, default: 0.50
      t.decimal :max_usage, default: 2.00
      t.decimal :initial_period, default: 0.00
      t.decimal :last_period, default: 23.00

      t.timestamps
    end
  end
end
