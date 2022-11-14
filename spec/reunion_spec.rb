require './lib/reunion'
require './lib/activity'

RSpec.describe Reunion do 
  let(:reunion) { Reunion.new("1406 BE") }
  let(:activity_1) { Activity.new("Brunch")}
  
  it 'exists and has attributes' do 
    expect(reunion).to be_an(Reunion)
    expect(reunion.name).to eq("1406 BE")
    expect(reunion.activities).to eq([])
  end

  it 'can add an activity to activities array' do 
    reunion.add_activity(activity_1)

    expect(reunion.activities).to eq([activity_1])
  end

  it 'the reunion has a total cost for its activities' do 
    activity_1.add_participant("Maria", 20)
    activity_1.add_participant("Luther", 40)
    reunion.add_activity(activity_1)

    expect(reunion.total_cost).to eq(60)

    activity_2 = Activity.new("Drinks")
    activity_2.add_participant("Maria", 60)
    activity_2.add_participant("Luther", 60)
    activity_2.add_participant("Louis", 0)
    reunion.add_activity(activity_2)
    
    expect(reunion.total_cost).to eq(180)
  end

  it 'returns a hash with the participants name and why they owe' do 
    activity_1.add_participant("Maria", 20)
    activity_1.add_participant("Luther", 40)
    reunion.add_activity(activity_1)
    activity_2 = Activity.new("Drinks")
    activity_2.add_participant("Maria", 60)
    activity_2.add_participant("Luther", 60)
    activity_2.add_participant("Louis", 0)
    reunion.add_activity(activity_2)
    
    expect(reunion.breakout).to eq({
                                    "Maria" => -10, 
                                    "Luther" => -30, 
                                    "Louis" => 40
                                  })
  end

  it 'returns a summary of the breakout to terminal' do 
    activity_1.add_participant("Maria", 20)
    activity_1.add_participant("Luther", 40)
    reunion.add_activity(activity_1)
    activity_2 = Activity.new("Drinks")
    activity_2.add_participant("Maria", 60)
    activity_2.add_participant("Luther", 60)
    activity_2.add_participant("Louis", 0)
    reunion.add_activity(activity_2)
    
    puts reunion.summary
    expect(reunion.summary).to eq("Maria: -10\nLuther: -30\nLouis: 40")
  end
end