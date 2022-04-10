require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) { create :user }

  before { sign_in user }

  describe '#create' do
    let(:likeable) { create :post, user: user }
    let(:params) do
      { like: { likeable_id: likeable.id, likeable_type: likeable.class } }
    end

    subject { post :create, xhr: true, params: params, format: :json }

    it 'create like' do
      expect { subject }.to change { Like.count }.by(1)
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

  describe '#destroy' do
    let!(:like) { create :like, user: user }
    let(:params) do
      { id: like }
    end

    subject { delete :destroy, method: :delete, xhr: true, params: params, format: :json }

    it 'destroy like' do
      expect { subject }.to change { Like.count }.by(-1)
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
