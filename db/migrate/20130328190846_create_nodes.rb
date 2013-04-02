class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.integer :itis_id
      t.integer :non_itis_id
      t.string :working_name
      t.integer :functional_group_id
      t.string :native_status
      t.boolean :is_assemblage
      t.integer :user_id

      t.timestamps
    end
  end
end
