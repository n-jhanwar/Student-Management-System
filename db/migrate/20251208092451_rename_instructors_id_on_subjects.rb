class RenameInstructorsIdOnSubjects < ActiveRecord::Migration[8.1]
  def change
    rename_column :subjects, :instructors_id, :instructor_id
  end
end
