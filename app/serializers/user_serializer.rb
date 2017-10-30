class UserSerializer < ActiveModel::Serializer
  attributes :token, :email, :snum
end
