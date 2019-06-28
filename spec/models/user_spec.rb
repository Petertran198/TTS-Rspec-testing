require 'rails_helper'

RSpec.describe User, type: :model do
  #let statement creates a variable and assign it whatver is in the { }
  # build_stubbed or stubs in general creates fake objects that are not saved to the db or have db access. Stubs allows for fake functions and less db calls   
  let(:test_user) { FactoryBot.build_stubbed(:user) }
  let(:test_user_with_task) {FactoryBot.build(:user_with_tasks)}
  it "is valid with a first name , last name, and email" do
    expect(test_user).to be_valid
  end

  it "is invalid without first name" do
    test_user.firstname = nil
    expect(test_user).not_to be_valid
  end

  it "is invalid without a last name" do 
    test_user.lastname = nil
    expect(test_user).not_to be_valid
  end

  it "is invalid without a email" do
    test_user.email = nil
    expect(test_user).not_to be_valid

  end

  it "has two task created " do 
    expect(test_user_with_task.tasks.length).to eq(2)
  end
end
