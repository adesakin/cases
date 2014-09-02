class Step < ActiveRecord::Base
  belongs_to :use_case
  after_create :assign_custom_id

  validate :type, presence: true


  def assign_custom_id
    previous = self.class.where('id < ? and use_case_id = ?', self.id, use_case.id).order("id DESC").take
    if previous.nil?
      update_attributes(custom_id: "#{type.to_s[0]}F.#{use_case.id}.1")
    else
      update_attributes(custom_id: "#{type.to_s[0]}F.#{use_case.id}.#{(previous.custom_id.split('.')[2].to_i + 1).to_s}")
    end
  end


end
