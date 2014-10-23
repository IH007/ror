class CreateNodeAttributeFloatvalues < ActiveRecord::Migration
  def change
    create_table :node_attribute_floatvalues do |t|
      t.string :value_float
      t.string :nodes_id
      t.string :node_attributes_id

      t.timestamps
    end
  end
end
