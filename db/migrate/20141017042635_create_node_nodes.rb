class CreateNodeNodes < ActiveRecord::Migration
  def change
    create_table :node_nodes do |t|
      t.integer :parent_id
      t.integer :child_id
      t.integer :node_depth_type
      t.boolean :non_unique

      t.timestamps
    end
  end
end
