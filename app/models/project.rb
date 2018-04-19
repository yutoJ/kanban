class Project < ApplicationRecord
  belongs_to :host_user, class_name: 'User', inverse_of: :projects
end
