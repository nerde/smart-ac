class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.belongs_to :device, foreign_key: true, null: false
      t.belongs_to :device_snapshot, foreign_key: true, null: false
      t.datetime :occurred_at, null: false
      t.datetime :resolved_at
      t.string :kind, null: false
      t.belongs_to :resolved_by

      t.timestamps
    end

    add_foreign_key :issues, :users, column: :resolved_by_id
  end
end
