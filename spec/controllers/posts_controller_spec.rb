require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create :user }

  before { sign_in user }

  describe '#show' do
    let!(:post) { create :post, user: user }
    let(:params) do
      { id: post }
    end

    subject { get :show, params: params }

    it 'assigns @post' do
      subject
      expect(assigns(:post)).to eq(post)
    end

    it { is_expected.to render_template(:show) }

    context 'when user tries to see non-existent post' do
      let(:post) { build_stubbed :post, user: user }

      it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  describe '#new' do
    subject { get :new }

    it { is_expected.to render_template(:new) }

    it 'assigns new @post' do
      subject
      expect(assigns(:post)).to be_a_new Post
    end

    context 'when the user is not logged in' do
      before { sign_out user }

      it 'redirect to log in page' do
        subject
        is_expected.to redirect_to(new_user_session_path)
      end
    end
  end

  describe '#create' do
    let(:params) do
      { post: attributes_for(:post) }
    end

    subject { post :create, params: params }

    it 'create post' do
      expect { subject }.to change { Post.count }.by(1)
      is_expected.to redirect_to(feed_posts_path)
    end

    context 'when params invalid' do
      let(:params) do
        { post: { image_data: nil } }
      end

      it { is_expected.to render_template(:new) }
      it { expect { subject }.not_to change { Post.count } }
    end
  end
end
