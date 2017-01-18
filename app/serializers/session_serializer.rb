class SessionSerializer < ActiveModel::Serializer
    attributes  :email, :full_name, :user_id, :jwt_token

    def user_id
      object.id
    end

    def jwt_token
      API::JWTAdapter.new.encode(user_id: object.id)
    end

    def full_name
      [object.first_name, object.last_name].join(' ')
    end
end
