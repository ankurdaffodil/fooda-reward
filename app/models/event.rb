# class used to simulate the inputs and outputs
class Event

  # We need to improve code if huge payload come as inputs
  # either consume as stream 
  # or we can divide events array into small chunks and then process by multiple instance of service

  EVENTS = {
    "events": [
      {
        "action": "new_customer",
        "name": "Jessica",
        "timestamp": "2020-07-01T00:00:00-05:00"
      },
      {
        "action": "new_customer",
        "name": "Will",
        "timestamp": "2020-07-01T01:00:00-05:00"
      },
      {
        "action": "new_customer",
        "name": "Elizabeth",
        "timestamp": "2020-07-01T01:00:00-05:00"
      },
      {
        "action": "new_order",
        "customer": "Jessica",
        "amount": 12.50,
        "timestamp": "2020-07-01T12:15:57-05:00"
      },
      {
        "action": "new_order",
        "customer": "Jessica",
        "amount": 16.50,
        "timestamp": "2020-07-01T10:01:00-05:00"
      },
      {
        "action": "new_order",
        "customer": "Will",
        "amount": 8.90,
        "timestamp": "2020-07-01T12:20:00-05:00"
      },
      {
        "action": "new_order",
        "customer": "Will",
        "amount": 1.50,
        "timestamp": "2020-07-01T12:21:00-05:00"
      }
    ]
  }

  def self.call
    EVENTS[:events].map do |event|
      case event[:action]
      when "new_customer"
        UserService::UserCreate.call(event[:name])
      when "new_order"
        user = User.find_by_name(event[:customer])
        RewardService::RewardAllocation.call(user.id, event[:amount], event[:timestamp]) if user.present?
      end
    end
    # outputs
    RewardService::RewardReport.call
  end
end