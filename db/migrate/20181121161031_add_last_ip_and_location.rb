class AddLastIpAndLocation < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :last_ip, :string
  	add_column :users, :last_location, :string
  end
end
