require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:questions) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe '#author_of?' do
    let(:question) { create(:question) }

    subject { user.author_of?(question) }

    context 'when question belong to user' do
      let(:user) { question.user }

      it { is_expected.to be_truthy }
    end

    context 'when question not belong to user' do
      let(:user) { create(:user)}

      it { is_expected.to be_falsey }
    end
  end
end
