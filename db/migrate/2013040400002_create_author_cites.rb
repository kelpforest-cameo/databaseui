class CreateAuthorCites < ActiveRecord::Migration
  def change
    create_table :author_cites do |t|
      t.integer :author_id
      t.integer :citation_id
      t.integer :user_id
      t.integer :project_id
      t.boolean :mod
      t.boolean :approved

      t.timestamps
    end
  end
end
