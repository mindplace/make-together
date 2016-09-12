module ProjectsHelper
  def most_recent
    Project.all.order(created_at: :desc)
  end

  def posted_by_developers
    Project.joins(:user).where(users: {role: "developer"})
  end

  def posted_by_designers
    Project.joins(:user).where(users: {role: "designer"})
  end

  def expiring_soon
    Project.where('projects.expiration >=? AND projects.expiration <=?', Date.today, 3.days.from_now)
  end

  def format_tags(project)
    tags = []
    project.tags.each do |tag|
      tags << tag.body
    end
    tags.join(", ")
  end

  def rand_dev_projects
    Project.joins(:user).where("projects.user_id !=? AND users.role = 'developer'", current_user).limit(2)
  end

  def rand_design_projects
    Project.joins(:user).where("projects.user_id !=? AND users.role = 'designer'", current_user).limit(2)
  end
end
