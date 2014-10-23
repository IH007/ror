class NodeAttrb < ActiveRecord::Base
 
 belongs_to :node
  #has_many :authors, through: :articles

  # validates_presence_of :name_display, :node_type_id

  #belongs_to :nodeattrtype, class: Lookup, foreign_key: :node_type_id
  belongs_to :nodeattr, class: Lookup, foreign_key: :node_type_id
  #belongs_to :grade, class: Lookup, foreign_key: :grade_type_id
end
