require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  describe "#new" do
    context "with signed in user" do
      before do
        session[:user_id] = FactoryBot.create(:user).id
      end

      it "should render the new template" do
        get(:new)
        expect(response).to(render_template(:new))
      end
  
      it "should set an instance variable with a new idea" do
        get(:new)
        expect(assigns(:idea)).to(be_a_new(Idea))
      end  
    end
  end

  describe '#create' do
    context "with user signed in" do
      before do
        session[:user_id] = FactoryBot.create(:user).id
      end

      context "with valid parameters" do
        def valid_params
          post(:create, params:{idea: FactoryBot.attributes_for(:idea)})
        end
  
        it "should create a idea in the database" do
          count_before = Idea.count
          valid_params
          count_after = Idea.count
          expect(count_after).to(eq(count_before + 1))
        end
  
        it "should redirect us to the show page for that post" do
          valid_params
          idea = Idea.last
          expect(response).to(redirect_to(idea_path(idea)))
        end
      end
  
      context "with invalid parameters" do
        def invalid_params
          post(:create, params:{idea: FactoryBot.attributes_for(:idea, title: nil)})
        end
  
        it "should not save a record into the database" do
          count_before = Idea.count
          invalid_params
          count_after = Idea.count
          expect(count_after).to(eq(count_before))
        end
  
        it "should render the new template" do
          invalid_params
          expect(response).to(render_template(:new))
        end
  
      end
    end

    context "without user signed in" do
      it "should redirect to the sign in page" do
        post(:create, params:{idea: FactoryBot.attributes_for(:idea)})
        expect(response).to(redirect_to(new_session_path))
      end
    end

  end

end
