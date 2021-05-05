module UserService
  class UserCreate
    def self.call(name)
      User.where(name:name).first_or_create
    end
  end
end