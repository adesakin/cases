class Flow < ActiveRecord::Base
  belongs_to :step
  belongs_to :slice

end
