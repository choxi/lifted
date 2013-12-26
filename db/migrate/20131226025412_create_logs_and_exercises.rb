class CreateLogsAndExercises < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer   :user_id, null: false
      t.timestamp :logged_at, null: false
      t.timestamps
    end

    create_table :exercise_logs do |t|
      t.integer :exercise_id, null: false
      t.integer :log_id, null: false
      t.integer :weight, default: 0, null: false
      t.timestamps
    end

    create_table :exercises do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
