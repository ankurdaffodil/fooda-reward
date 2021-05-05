module RewardService
  class RewardGenerate
    def self.call(order_amount, timestamp)
      datetime = DateTime.parse(timestamp)

      case true
      when datetime >= datetime.change(:hour => 12) && 
           datetime <= datetime.change(:hour => 13) 
        (order_amount/3).to_i
      when (datetime >= datetime.change(:hour => 11) && 
        datetime <= datetime.change(:hour => 12)) || (
          (datetime >= datetime.change(:hour => 13) && 
          datetime <= datetime.change(:hour => 14))
        ) 
        (order_amount/2).to_i
      when (datetime >= datetime.change(:hour => 10) && 
        datetime <= datetime.change(:hour => 11)) || (
          (datetime >= datetime.change(:hour => 14) && 
          datetime <= datetime.change(:hour => 15))
        ) 
        order_amount.to_i
      else 
        order_amount/4.to_i
      end
    end
  end
end