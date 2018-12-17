class Admin < User
	has_many :projects, foreign_key: "user_id"
end