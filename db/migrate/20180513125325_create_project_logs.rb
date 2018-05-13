class CreateProjectLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :project_logs do |t|
      t.references :project, foreign_key: true, nill: false
      t.text :message, nil: false

      t.timestamps
    end
  end
end
