class CreateLogsAndExercises < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.timestamps
    end

    create_table :exercise_logs do |t|
      t.integer :exercise_id
      t.integer :log_id
      t.integer :weight
      t.timestamps
    end

    create_table :exercises do |t|
      t.string :name
      t.timestamps
    end
  end
end
