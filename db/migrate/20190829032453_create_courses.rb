class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :content
      t.date :start_date
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
