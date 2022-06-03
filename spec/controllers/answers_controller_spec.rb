require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:answer) { create(:answer) }

  describe 'GET #index' do
    let(:question) { create(:question, :with_answers, count: 3) }
    before { get :index, params: { question_id: question.id } }

    it 'populates an array of all answers' do
      expect(assigns(:answers)).to match_array(question.answers)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: answer.id} }

    it 'assigns the requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { login(answer.user) }
    before { get :new, params: { question_id: answer.question_id} }

    it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before { login(answer.user) }
    let(:question) { create(:question) }

    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question }, format: :js }.to change(question.answers, :count).by(1)
      end
      it 'renders create template' do
        post :create, params: { answer: attributes_for(:answer), question_id: question }, format: :js
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not to save the answer' do
        expect { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question }, format: :js }.to_not change(Answer, :count)
      end
      it 'renders create template' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question }, format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe 'POST #update' do
    let(:question) { create(:question) }
    let!(:answer) { create(:answer, question: question) }
    before { login(answer.user) }

    context 'with valid attributes' do
      before { patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js }

      it 'changes answer attributes' do
        answer.reload

        expect(answer.body).to eq 'new body'
      end

      it 'renders update view' do
        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid ) }, format: :js }

      it 'does not change answer' do
        answer.reload

        expect(answer.body).to eq answer.body
      end

      it 'renders update view' do
        expect(response).to render_template :update
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:answer) { create(:answer) }

    context "answer's author" do
      before { login(answer.user) }

      it 'deletes the answer' do
        expect { delete :destroy, params: { id: answer.id }, format: :js }.to change(Answer, :count).by(-1)
      end

      it 'renders destroy view' do
        delete :destroy, params: { id: answer.id }, format: :js
        expect(response).to render_template :destroy
      end
    end

    context "not answer's author" do
      let(:user) { create(:user) }
      before { login(user) }

      it 'not deletes the question' do
        expect { delete :destroy, params: { id: answer.id }, format: :js }.to_not change(Answer, :count)
      end

      it 'renders destroy view' do
        delete :destroy, params: { id: answer.id }, format: :js
        expect(response).to render_template :destroy
      end
    end
  end
end
