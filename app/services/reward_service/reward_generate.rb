module RewardService
  class RewardGenerate
    def self.call(order_amount, timestamp)

      datetime = DateTime.parse(timestamp).utc

      case true
      when datetime >= DateTime.now.utc.beginning_of_day.change(:hour => 12) && 
           datetime <= DateTime.now.utc.beginning_of_day.change(:hour => 13) 
        (order_amount/3).to_i
      when (datetime >= DateTime.now.utc.beginning_of_day.change(:hour => 11) && 
        datetime <= DateTime.now.utc.beginning_of_day.change(:hour => 12)) || (
          (datetime >= DateTime.now.utc.beginning_of_day.change(:hour => 13) && 
          datetime <= DateTime.now.utc.beginning_of_day.change(:hour => 14))
        ) 
        (order_amount/2).to_i
      when (datetime >= DateTime.now.utc.beginning_of_day.change(:hour => 10) && 
        datetime <= DateTime.now.utc.beginning_of_day.change(:hour => 11)) || (
          (datetime >= DateTime.now.utc.beginning_of_day.change(:hour => 14) && 
          datetime <= DateTime.now.utc.beginning_of_day.change(:hour => 15))
        ) 
        order_amount.to_i
      else 
        order_amount/4.to_i
      end
    end
  end
end