module RewardService
  class RewardReport
    def report
      h = {}
      points_total = User.eager_load(:rewards).group("users.id").sum(:points)
      points_avg = User.eager_load(:rewards).group("users.id").average(:points)
      User.all.map do |user|
        if points_avg.fetch(user.id).present?
          h[user.name] = "#{user.name}: #{points_total.fetch(user.id)} points with #{points_avg.fetch(user.id)} points per order."
        else
          h[user.name] = "#{user.name}: No orders."
        end
      end
      h
    end
  end
end