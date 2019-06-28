FactoryBot.define do

  factory :user do
    email {FFaker::Internet.email}
    password {'Password1'}
    encrypted_password {'Password1'}
    firstname {FFaker::Name.first_name}
    lastname {FFaker::Name.last_name}

    factory :user_with_tasks do 
      after(:build) do |user|
        user.tasks << FactoryBot.create(:homework, user: user)
        user.tasks << FactoryBot.create(:email, user: user)
      end  
    end
    
  end



end
