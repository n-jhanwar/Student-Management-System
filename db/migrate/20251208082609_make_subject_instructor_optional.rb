class MakeSubjectInstructorOptional < ActiveRecord::Migration[8.1]
  def change
    change_column_null :subjects, :instructors_id, true
  end
end
