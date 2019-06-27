require 'rails_helper'

#INTERGRATION TEST

#describe and feature is the same thing but the convention is to use feature for intergration test and describe for unit test 
feature 'tasks/index' do 
  scenario 'shows a list of tasks' do 
    FactoryBot.create(:homework)
    FactoryBot.create(:email)

    visit tasks_path #this is how capybara gem visit the pg for testing in rspec 
    expect(page).to have_content('do your homework')
    expect(page).to have_content('Write an e-mail')

  end
end

feature 'Adding New Task' do 
  scenario 'user adds a new task' do 
    user = FactoryBot.create(:user)
    visit tasks_path
    #expect takes in the step it takes to click a new task 
    expect {
      click_link 'New Task'
      #fill_in look for the form field labels  and fill it in with what u want
      fill_in 'Name', with: 'Learn Rspec'
      fill_in 'Priority', with: 2
      fill_in 'Due date', with: DateTime.now
      select(user.email, from: 'task_user_id')
      click_button 'Create Task'
    }.to change(Task, :count).by(1)

    expect(current_path).to eq(task_path(Task.last.id))
    expect(page).to have_content('Learn Rspec') 
  end

  feature "Edit task " do 
    scenario 'user edits task' do 
      task = FactoryBot.create(:homework)

      visit task_path(task)

      click_link 'Edit'
      fill_in "Name", with: "Master Rspec"
      fill_in "Priority", with: 2
      fill_in "Due date", with: DateTime.now
      select(task.user.email, from: 'task_user_id')
      click_button "Update Task"

      expect(current_path).to eq(task_path(task))
      expect(page).to have_content('Master Rspec')
    end
  end

end