class CreateEnrollments < ActiveRecord::Migration[8.1]
  def change
    create_table :enrollments do |t|
      t.references :student, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.date :enrollment_date, null: false
      t.string :status, default: 'enrolled'

      t.timestamps
    end

    add_index :enrollments, [:student_id, :subject_id], unique: true
  end
end
