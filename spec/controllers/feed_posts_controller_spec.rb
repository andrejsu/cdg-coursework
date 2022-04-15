require 'rails_helper'

RSpec.describe FeedPostsController, type: :controller do
  let(:user) { create :user }

  before { sign_in user }

  describe '#index' do
    subject { get :index }

    let!(:post) { create :post, user: user }

    it 'assigns @posts' do
      subject
      expect(assigns(:posts)).to eq([post])
    end

    it { is_expected.to render_template(:index) }

    context 'when the ajax request comes' do
      subject { get :index, xhr: true, format: :json }

      it 'returns json' do
        subject
        expect(response.header['Content-Type']).to include('application/json')
      end
    end

    context 'when the user is not logged in' do
      before { sign_out user }

      it 'redirect to log in page' do
        subject
        is_expected.to redirect_to(new_user_session_path)
      end
    end
  end
end