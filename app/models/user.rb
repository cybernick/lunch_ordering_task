class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :set_admin

  belongs_to :organization
  has_many :orders

  private

  def set_admin
    User.count == 1 ? User.first.update_attribute(:admin, true) : true
  end
end
