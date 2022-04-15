require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create :user }

  before { sign_in user }

  describe '#show' do
    let(:params) do
      { id: user }
    end

    subject { get :show, params: params }

    it 'assigns @user' do
      subject
      expect(assigns(:user)).to eq(user)
    end

    it { is_expected.to render_template(:show) }

    context 'when user tries to see non-existent user' do
      let(:user) { build_stubbed :user }

      it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'when the user is not logged in' do
      before { sign_out user }

      it { is_expected.to render_template(:show) }
    end
  end
end
