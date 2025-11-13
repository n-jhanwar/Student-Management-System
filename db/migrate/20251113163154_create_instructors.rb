class CreateInstructors < ActiveRecord::Migration[8.1]
  def change
    create_table :instructors do |t|
      t.string :instructor_id, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :contact, null: false
      t.date :hire_date, null: false
      t.string :status, null: false, default: 'active'

      t.timestamps
    end

    add_index :instructors, :instructor_id, unique: true
    add_index :instructors, :email, unique: true
  end
end
