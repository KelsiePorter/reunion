class Reunion 
  attr_reader :name,
              :activities

  def initialize(name)
    @name = name
    @activities = []
  end

  def add_activity(activity)
    @activities << activity
    # You can only shovel into an array not a hash
  end

  def total_cost
    cost = 0
    @activities.map do |activity|
      cost += activity.participants.values.sum
      # I am reaching into an array activity instances (@activities.map). Then I am reaching
      # into each activity instance (activity block variable and activity. in the condition)
      # Each activity instance has a hash of participants. I am reaching into this hash (activity.participants)
      # to get the values from each key/value pair and getting the sum (activity.participants.values.sums)
      # In order to return a final integer, used a counter on line 16. Without the counter,
      # the .map enumerable returns an ARRAY containing the integer and we only need the integer.
    end
    cost
  end

  def breakout 
    # what do we need? a Hash
    breakout_hash = {}
    # Next, what do we need? all participants names so create a helper method (all_participants)
    all_participants.each do |participant|
      # iterate over all the unique names array
      # for each name, turn that name into a key in our above hash
      # set this new key equal to the #participant_cost helper below
      breakout_hash[participant] = participant_cost(participant)
    end
    breakout_hash
  end

  def all_participants 
    # this is a helper method for #breakout above. It's purpose is to return
    # an array of all UNIQUE names (.uniq). Iterating over @activities array
    # using flat_map returns a new array for concatenated results.
    # We are using our other #all_participants helper (from activity.rb) in the block to get all of these names
    @activities.flat_map do |activity|
      activity.all_participants
      # need to use unique - this is a note to remind me to put .uniq somewhere
    end.uniq
  end

  def participant_cost(participant)
    # iterate over the activities array. For each activity, what is the participant's cost?
   @activities.map do |activity|
    # This helper accepts an argument that is passed in in the #breakout iteration
      activity.cost_for(participant)
      # cost_for is a helper method in activity.rb. #cost_for returns an integer of what the
      # participant owes. We are iterating through each participant in each activity
      # to get what that single participant owes for each activity and sums them all together (.sum below)
    end.compact.sum
    # .compact removes all nil's
  end

  def summary
    string = ''
    breakout.map do |name, value|
     string << "#{name}: #{value}\n"
    end
    string.chomp
  end
end