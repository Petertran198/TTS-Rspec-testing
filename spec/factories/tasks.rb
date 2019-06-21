#Set up a “factory” that is used to automate task 
FactoryBot.define do
  factory :task do
    name { "MyString" }
    priority { 1 }
    due_date { DateTime.now }
  end


  # the class: task is there so factory gem knows which model to look at
  factory :homework, class: Task do
    # association is saying when u create an instatce of the task model associate it with a user 
    association :user
    name { "do your homework"}
    priority { 1 }
    due_date { DateTime.now }

  end


  # the class: task is there so factory gem knows which model to look at
  factory :invalid_task, class: Task do 
    # association is saying when u create an instatce of the task model associate it with a user 
    association :user
    name { nil }
    priority { nil }
    due_date { nil }

  end

end
