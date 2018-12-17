class AddstatusAToTask < ActiveRecord::Migration
  def change
  	add_column :tasks, :status, :string, default: "NEW"
  end
end
