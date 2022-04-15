require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create :user }

  before { sign_in user }

  describe '#create' do
    let(:post_) { create :post, user: user }
    let(:params) do
      {
        comment: attributes_for(:comment),
        post_id: post_
      }
    end

    subject { post :create, xhr: true, params: params, format: :json }

    it 'create comment' do
      expect { subject }.to change { Comment.count }.by(1)
    end

    it 'returns json' do
      subject
      expect(response.header['Content-Type']).to include('application/json')
    end

    context 'when the user is not logged in' do
      before { sign_out user }

      it 'returns 401 status code' do
        subject
        expect(response.status).to eq(401)
      end
    end
  end
end
