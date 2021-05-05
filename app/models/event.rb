class Event
  #this input will be a robust stream some like kafka from which multiple broker services can read
  #events symultanioulsy
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
        "customer": "Elizabeth",
        "amount": 12.50,
        "timestamp": "2020-07-01T12:15:57-05:00"
      },
      {
        "action": "new_order",
        "customer": "Elizabeth",
        "amount": 12.50,
        "timestamp": "2020-07-01T12:15:57-05:00"
      },
      {
        "action": "new_order",
        "customer": "Elizabeth",
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
        "timestamp": "2020-07-01T12:20:00-05:00"
      }
    ]
  }

  #ideally this event broker logic will either be a load balancer to assign events or group of events to
  #multiple instances of reward service
  #(this will help us to have fine control on which service-instance to utilize more or stream particulat tpe of events to) but it could also act as a single point of faliure
  #OR
  #we need to use some lock/handshake so that multiple instance of this reward service can read the
  #un-read events from event-stream symultaniously to increase throughut
  #(this approach is more distrubuted but the handshake mechanism can be complicated or buggy)
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
  end
end