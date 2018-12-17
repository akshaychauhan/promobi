class AddDefaultToUserStatus < ActiveRecord::Migration
  def up
	  change_column :users, :type, :string, default: "Developer"
	end

	def down
	  change_column :users, :type, :string, default: nil
	end
end
