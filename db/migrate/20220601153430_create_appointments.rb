class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.string :city, null: false
      t.date :date, null: false
      t.references :user, null: false, foreign_key: true
      t.references :billionaire, null: false, foreign_key: true

      t.timestamps
    end
  end
end
