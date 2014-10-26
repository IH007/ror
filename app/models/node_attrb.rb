class NodeAttrb < ActiveRecord::Base
	belongs_to :node
	belongs_to :nodeattr, class: Lookup, foreign_key: :node_type_id

	#validates_presence_of :name  #, :node_type_id
	#byebug
end
