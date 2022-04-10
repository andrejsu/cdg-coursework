require 'rails_helper'

RSpec.describe FollowsController, type: :controller do
  let(:user) { create :user }

  before { sign_in user }

  describe '#create' do
    let(:following) { create :user }
    let(:params) do
      { followed_id: user }
    end

    subject { post :create, xhr: true, params: params, format: :json }

    it 'create follow' do
      expect { subject }.to change { Follow.count }.by(1)
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
    let(:following) { create :user }
    let!(:follow) { create :follow, follower: user, following: following }
    let(:params) do
      { id: follow }
    end

    subject { delete :destroy, method: :delete, xhr: true, params: params, format: :json }

    it 'destroy follow' do
      expect { subject }.to change { Follow.count }.by(-1)
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
