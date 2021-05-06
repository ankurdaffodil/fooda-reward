module RewardService
  # class to allocate generated rewards to user
  class RewardAllocation
    def self.call(user_id, order_amount, timestamp)
      points = RewardService::RewardGenerate.call(order_amount, timestamp)

      # We can improve by moving this to event driven.
      # When points ready then raise event to assign to user 
      Reward.create(user_id: user_id, points: points, order_amount:order_amount)
    end
  end
end