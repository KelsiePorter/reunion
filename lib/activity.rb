class Activity 
  attr_reader :name,
              :participants

  def initialize(name)
    @name = name
    @participants = {}
  end

  def add_participant(name, cost)
    @participants[name] = cost
    # You create and add a key/value pair to a hash like this. 
  end

  def total_cost
    participants.values.sum
    # To get a total of all of the values in a hash. Call on the hash variable name
    # .values.sum to get a total of ALL values
  end

  def split 
    total_cost / @participants.length
    # This is using the sum of all values (from method above) in the hash divided by the number of
    # key/value pairs in the hash (.length)
  end

  def owed 
      @participants.transform_values do |value|
      split - value
      # .transform_values is an enumerable that can be used to iterate over a hash
      # where you do not want to change any keys. So, this enum does not need 
      # two block variables on line 28. This enum creates a NEW hash based on the
      # conditions of the block
    end
  end

  def all_participants 
    # this is a helper method (for all_participants in reunion.rb) 
    # that returns an array of all participant names (the keys in this ex.)
    @participants.keys
  end

  def cost_for(participant)
    # ** I do not know why this method works or how **
    # owed from above is a hash
    # This method returns an integer of what the participant owes (split - value)
    owed[participant]
  end
end