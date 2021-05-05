module RewardService
  class RewardAllocation
    def self.call(user_id, order_amount, timestamp)
      points = RewardService::RewardGenerate.call(order_amount, timestamp)
      #this should have reference of order_id so we dont process same reward more than once
      #The below approach is ok to see history of allocated points
      #but aslo we should store a aggrigate of final reward points for faster sorting and access
      Reward.create(user_id: user_id, points: points, order_amount:order_amount)
    end
  end
end