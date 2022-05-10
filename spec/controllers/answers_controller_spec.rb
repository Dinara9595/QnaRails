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
    before { get :show, params: { question_id: answer.question_id, id: answer.id} }

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

  describe 'GET #edit' do
    before { login(answer.user) }
    before { get :edit, params: { question_id: answer.question_id, id: answer.id} }

    it 'assigns the requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    before { login(answer.user) }
    let(:question) { create(:question) }

    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer) } }.to change(question.answers, :count).by(1)
      end
      it 'redirects to question view with answers' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer) }
        expect(response).to redirect_to "/questions/#{assigns(:question).id}"
      end
    end

    context 'with invalid attributes' do
      it 'does not to save the answer' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid) } }.to_not change(Answer, :count)
      end
      it 'render to questions/show view' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid) }
        expect(response).to render_template :'questions/show'
      end
    end
  end

  describe 'POST #update' do
    before { login(answer.user) }

    context 'with valid attributes' do
      it 'assigns the requested answer to @answer' do
        patch :update, params: { question_id: answer.question_id, id: answer, answer: attributes_for(:answer) }
        expect(assigns(:answer)).to eq answer
      end

      it 'changes answer attributes' do
        patch :update, params: { question_id: answer.question_id, id: answer, answer: { body: 'new body' } }
        answer.reload

        expect(answer.body).to eq 'new body'
      end

      it 'redirects to updates answer' do
        patch :update, params: { question_id: answer.question_id, id: answer, answer: attributes_for(:answer) }
        expect(response).to redirect_to answer
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { question_id: answer.question_id, id: answer, answer: attributes_for(:answer, :invalid ) } }

      it 'does not change question' do
        answer.reload

        expect(answer.body).to eq "Answer body test"
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:answer) { create(:answer) }

    context "answer's author" do
      before { login(answer.user) }

      it 'deletes the answer' do
        expect { delete :destroy, params: { question_id: answer.question_id, id: answer.id } }.to change(Answer, :count).by(-1)
      end

      it 'redirects to page question with answers' do
        delete :destroy, params: { question_id: answer.question_id, id: answer.id }
        expect(response).to redirect_to question_path(answer.question)
      end
    end

    context "not answer's author" do
      let(:user) { create(:user) }
      before { login(user) }

      it 'not deletes the question' do
        expect { delete :destroy, params: { question_id: answer.question_id, id: answer.id } }.to_not change(Answer, :count)
      end

      it 'redirects to page question with answers' do
        delete :destroy, params: { question_id: answer.question_id, id: answer.id }
        expect(response).to redirect_to question_path(answer.question)
      end
    end
  end
end
