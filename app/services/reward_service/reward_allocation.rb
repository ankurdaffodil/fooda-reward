module RewardService
  class RewardAllocation
    def self.call(user_id, order_amount, timestamp)
      points = RewardService::RewardGenerate.call(order_amount, timestamp)
      Reward.create(user_id: user_id, points: points, order_amount:order_amount)
    end
  end
end