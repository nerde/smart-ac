class CreateDeviceSnapshots < ActiveRecord::Migration[5.2]
  def change
    create_table :device_snapshots do |t|
      t.belongs_to :device, foreign_key: true
      t.datetime :taken_at, null: false
      t.decimal :temperature_celsius, null: false, precision: 5, scale: 2
      t.decimal :humidity_percentage, null: false, precision: 5, scale: 2
      t.decimal :carbon_monoxide_ppm, null: false, precision: 6, scale: 3
      t.string :status, null: false, limit: 150

      t.timestamps
    end
  end
end
