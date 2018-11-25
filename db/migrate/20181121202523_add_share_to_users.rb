class AddShareToUsers < ActiveRecord::Migration[5.2]
  def change
  	create_table :users_tasks do |t|
      t.integer :owner_id
      t.integer :user_id
    add_column :users, :shared_tasks, :string
    end
  end
end
