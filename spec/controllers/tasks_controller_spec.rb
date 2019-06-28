require 'rails_helper'

RSpec.describe TasksController, type: :controller do

  before { sign_in(FactoryBot.create(:user)) }
  #get new page of Task
  describe "Get #index" do

    it "renders the index template" do 
      get :index #trigger index action 
      expect(response).to render_template(:index)
    end

    it "returns all the tasks" do
      get :index 
      expect(assigns(:tasks)).not_to be_nil
      #is making sure that the task controller index action has a variable called @tasks
      #this is because (:tasks) becomes @tasks
    end

  end

  #get new page of Task
  describe "Get #new" do 

    it "renders the new template " do 
      get :new 
      expect(response).to render_template(:new)
    end

    it "creates a new instance of Task and assign it to @task" do 
      get :new 
      expect(assigns(:task)).to be_a_new(Task)
      # assigns(:task) is making a variable called @task by 
    end

  end

  #get show page of Task
  describe "GET #show" do 

    it "assigns the requested task to @task " do 
      #Create a instance of Task first 
      task = FactoryBot.create(:homework)
      get :show, params: {id: task.to_param }
      expect(assigns(:task)).to eq(task)
    end

    it "renders the show template" do 
      task = FactoryBot.create(:homework)
      get :show, params: {id: task.to_param}
      expect(response).to render_template(:show)
    end

  end 

  describe "Get #edit" do 

    it "assigns the requested task to @task " do 
      #Create a instance of Task first 
      task = FactoryBot.create(:homework)
      get :edit, params: {id: task.to_param }
      expect(assigns(:task)).to eq(task)
    end

    it "renders the show template" do 
      task = FactoryBot.create(:homework)
      get :edit, params: {id: task.to_param}
      expect(response).to render_template(:edit)
    end

  end

  describe "POST #create" do 
    #let(:var_name) creates a variable which u can use 
    let(:user) {FactoryBot.create(:user)}

    let(:valid_attributes) {FactoryBot.attributes_for(:email, user_id: user.id) }

    let(:invalid_attributes) { FactoryBot.attributes_for(:invalid_task)}

    context "With valid attributes" do
      it "creates new task that is saved to the db" do
        expect {
          post :create, params: {task: valid_attributes }
        }.to change(Task, :count).by(1)  

      end
      it "redirects to the show page" do 
        post :create, params: { task: valid_attributes}
        expect(response).to redirect_to(assigns(:task))
      end
    end


    context "With invalid attributes" do

      it "does not save a task to the db " do
        expect {
          post :create, params: { task: invalid_attributes }
        }.not_to change(Task, :count)
      end

      it "re-renders new template" do 
        post :create, params: { task: invalid_attributes}
        expect(response).to render_template(:new)
      end

    end

  end

  describe "PATCH #update" do 

    let(:task) {FactoryBot.create(:email)}
    let(:new_attributes) { FactoryBot.attributes_for(:homework)}
    let(:invalid_attributes) { FactoryBot.attributes_for(:invalid_task)}

    context "With valid params" do 
      it "Update the task" do 
        patch :update, params: { id: task.to_param, task: new_attributes }
        task.reload

        expect(task.name).to eq("do your homework")
        expect(task.priority).to eq(1)
      end 

      it "redirect to the show task page " do
        patch :update, params: {id: task.to_param, task: new_attributes}
        task.reload
        #should pass therefore redirects
        expect(response).to redirect_to(task)
      end 
    end

    context "with invalid param" do 

      it "does not change the task " do
        patch :update, params: { id: task.to_param, task: invalid_attributes}
        task.reload
        #should fail therefore @task stays the same
        expect(assigns(:task)).to eq(task)
      end

      it "re-renders the edit template" do
        patch :update, params: { id: task.to_param, task: invalid_attributes}
        expect(response).to render_template(:edit)
      end

    end


  end

  describe "DELETE #destroy" do 

    let(:task) { FactoryBot.build(:homework)}

    it "destroys the requested task" do
      task.save
      expect {
        delete :destroy, params: { id: task.to_param}
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the task list" do 
      task.save
      delete :destroy, params: {id: task.to_param}
      expect(response).to redirect_to(tasks_path)
    end
  end

  describe "unauthenticate user" do 
    it "will be asked to log in" do 
      sign_out(:user)
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end

end
