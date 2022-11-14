require './lib/activity'

RSpec.describe Activity do 
  let(:activity) { Activity.new("Brunch") }
  it 'exists with attributes' do 

    expect(activity).to be_an(Activity)
    expect(activity.name).to eq("Brunch")
    expect(activity.participants).to eq({})
  end

  it 'can add participants to the activity' do 
    activity.add_participant("Maria", 20)
    
    expect(activity.participants).to eq({"Maria" => 20})
  end

  it 'an activity has a total cost based on how much each participant paid' do
    expect(activity.total_cost).to eq(0) 

    activity.add_participant("Maria", 20)

    expect(activity.total_cost).to eq(20) 

    activity.add_participant("Luther", 40)
    
    expect(activity.participants).to eq({"Maria" => 20, "Luther" => 40})
    expect(activity.total_cost).to eq(60)
  end

  it 'the total cost of an activity can be split between participants' do 
    activity.add_participant("Maria", 20)
    activity.add_participant("Luther", 40)

    expect(activity.total_cost).to eq(60)

    expect(activity.split).to eq(30)
  end

  it 'hash can return how much each participant owes or is owed' do 
    activity.add_participant("Maria", 20)
    activity.add_participant("Luther", 40)

    expect(activity.split).to eq(30)
    expect(activity.owed).to eq({"Maria"=>10, "Luther"=>-10})
  end
end