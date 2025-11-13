class CreateStudents < ActiveRecord::Migration[8.1]
  def change
    create_table :students do |t|
      t.string :student_id, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :contact, null: false
      t.date :date_of_birth, null: false
      t.date :date_of_admission, null: false
      t.string :status, default: 'active'

      t.timestamps
    end

    add_index :students, :student_id, unique: true
    add_index :students, :email, unique: true
  end
end
