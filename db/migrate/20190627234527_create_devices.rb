class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :serial_number, null: false
      t.string :firmware_version, null: false
      t.string :auth_token, null: false

      t.timestamps
    end

    add_index :devices, :auth_token, unique: true
  end
end
