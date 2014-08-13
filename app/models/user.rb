class User < ActiveRecord::Base
  has_one :member, dependent: :destroy
  accepts_nested_attributes_for :member, :reject_if => :all_blank, :allow_destroy => true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  def name
    unless member.nil?
      "#{member.first_name} #{member.last_name}"
    else
      email
    end
  end

end
