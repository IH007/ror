class Node < ActiveRecord::Base
	puts "XXXXXXX Node < ActiveRecord::Base XXXXXXX "

	#has_many :node_attributes :class_name => 'Node'
  has_many :node_attrbs, dependent: :destroy #, :class_name => 'Node'
  belongs_to :user
  belongs_to :node, class: Lookup, foreign_key: :node_type_id

  accepts_nested_attributes_for :node_attrbs, :allow_destroy => true

  validates_presence_of :name_display #,  :if => :url_check?  #, :node_type_id

end

