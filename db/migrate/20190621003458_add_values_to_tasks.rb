class AddValuesToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :due_date, :datetime
    add_column :tasks, :user_id, :integer
  end
end
