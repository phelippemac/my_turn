class AddEndTimeToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :endtime, :string
  end
end
