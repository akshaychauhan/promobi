class Task < ActiveRecord::Base
	STATUS = {
		"new" => "NEW",
		"in_progress" => "IN_PROGRESS",
		"done" => "DONE"
	}

	belongs_to :project
	belongs_to :developer, foreign_key: "user_id"

	validates :title, :desc, :developer, presence: true
end
