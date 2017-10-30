# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :token, :email, :snum
end
