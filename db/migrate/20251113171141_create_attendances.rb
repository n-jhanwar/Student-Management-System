class CreateAttendances < ActiveRecord::Migration[8.1]
  def change
    create_table :attendances do |t|
      t.references :enrollment, null: false, foreign_key: true
      t.date :attendance_date, null: false
      t.string :status, null: false, default: 'present'
      t.text :remarks

      t.timestamps
    end

    add_index :attendances, [:enrollment_id, :attendance_date], unique: true
  end
end
