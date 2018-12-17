class Developer < User
	has_and_belongs_to_many :projects, foreign_key: "user_id"
	has_many :tasks, foreign_key: "user_id"

	def task_titles_by(status:)
    @tasks_group ||= self.tasks.group_by(&:status)
    return @tasks_group[status] ? @tasks_group[status].map(&:title) : []
	end
end