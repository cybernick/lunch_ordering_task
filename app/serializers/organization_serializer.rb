class OrganizationSerializer < ActiveModel::Serializer
  embed :ids
  attributes :id, :name , :email, :created_at, :updated_at, :auth_token
  has_many :users
end
