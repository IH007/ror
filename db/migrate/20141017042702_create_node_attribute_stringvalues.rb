class CreateNodeAttributeStringvalues < ActiveRecord::Migration
  def change
    create_table :node_attribute_stringvalues do |t|
      t.string :value_string
      t.string :nodes_id
      t.string :node_attributes_id

      t.timestamps
    end
  end
end
