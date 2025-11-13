class CreateSubjects < ActiveRecord::Migration[8.1]
  def change
    create_table :subjects do |t|
      t.string :subject_code, null: false
      t.string :subject_name, null: false
      t.string :semester, null: false
      t.references :instructor, null: false, foreign_key: true

      t.timestamps
    end

    add_index :subjects, :subject_code, unique: true
  end
end
