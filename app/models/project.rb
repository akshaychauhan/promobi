class Project < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :users

	has_many :tasks

	validates :name, presence: true

	def task_titles_by(status:)
    @tasks_group ||= self.tasks.group_by(&:status)
    return @tasks_group[status] ? @tasks_group[status].map(&:title) : []
	end
end
