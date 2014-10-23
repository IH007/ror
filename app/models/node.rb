class Node < ActiveRecord::Base
   has_many :node_attrbs, dependent: :destroy #, :class_name => 'Node'
   belongs_to :user
   accepts_nested_attributes_for :node_attrbs, :allow_destroy => true

  	#has_many :node_attributes :class_name => 'Node'
  	#accepts_nested_attributes_for :node_attributes, :allow_destroy => true
  
  #belongs_to :journal

  #validates_presence_of :name_display, :node_type_id
  belongs_to :node, class: Lookup, foreign_key: :node_type_id
 # belongs_to :grade, class: Lookup, foreign_key: :grade_type_id
  
end