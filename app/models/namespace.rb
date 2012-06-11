class Namespace < ActiveRecord::Base

  has_many :pages
  has_one :talk_ns, :foreign_key => "talk_for_id", :class_name => "Namespace"
  belongs_to :talk_for, :class_name => "Namespace"

end
