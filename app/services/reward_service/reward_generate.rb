module RewardService
  class RewardGenerate
    def self.call(order_amount, timestamp)
      datetime = DateTime.parse(timestamp)

      case true
      when datetime >= datetime.change(:hour => 12) && 
           datetime <= datetime.change(:hour => 13) 
        points = (order_amount.to_f/3)
      when (datetime >= datetime.change(:hour => 11) && 
        datetime <= datetime.change(:hour => 12)) || (
          (datetime >= datetime.change(:hour => 13) && 
          datetime <= datetime.change(:hour => 14))
        ) 
        points = (order_amount.to_f/2)
      when (datetime >= datetime.change(:hour => 10) && 
        datetime <= datetime.change(:hour => 11)) || (
          (datetime >= datetime.change(:hour => 14) && 
          datetime <= datetime.change(:hour => 15))
        ) 
        points = order_amount.to_f
      else 
        points = order_amount.to_f/4
      end
      points.ceil
      points = 0 if points < 3 || points > 20
      points
    end
  end
end