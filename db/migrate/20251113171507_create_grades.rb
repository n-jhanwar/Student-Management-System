class CreateGrades < ActiveRecord::Migration[8.1]
  def change
    create_table :grades do |t|
      t.references :enrollment, null: false, foreign_key: true
      t.decimal :score, precision: 5, scale: 2
      t.decimal :maximum_score, precision: 5, scale: 2
      t.decimal :weight, precision: 5, scale: 2
      t.date :graded_date

      t.timestamps
    end
  end
end
