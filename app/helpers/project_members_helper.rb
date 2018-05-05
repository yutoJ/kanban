module ProjectMembersHelper
  def find_invitaion(project, project_members)
    project_member = project_members.select{|project_member| project_member.project_id == project.id }
    project_member[0]
  end
end
