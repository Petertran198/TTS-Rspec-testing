require 'rails_helper'

RSpec.describe Task, type: :model do
  it "is valid with a name and a priority " do
    task = FactoryBot.build(:homework) #goes to factories folder and get the automated data
    expect(task).to be_valid 
  end 

  it "is invalid without a name" do
    task = FactoryBot.build(:homework, name: nil)#goes to factories folder and get the automated data
    expect(task).not_to be_valid
  end

  it "is invalid without a priority" do 
    task = FactoryBot.build(:homework, priority: nil)#goes to factories folder and get the automated data
    expect(task).not_to be_valid
  end
  
  it "belongs to User" do 
    # It is looking at the association between task and users and making sure that Task belongs to user 
    expect(Task.reflect_on_association(:user).macro).to eq(:belongs_to)
  end


end
