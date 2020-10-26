class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.date :day
      t.string: :hour
      t.decimal :duration
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
