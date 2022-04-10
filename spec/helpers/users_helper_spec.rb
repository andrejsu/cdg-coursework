require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe '#is_current_user?' do
    let(:user) { create :user }

    it 'returns true if the current user is the passed user' do
      allow(helper).to receive(:current_user).and_return(user)
      expect(helper.is_current_user?(user)).to be
    end
  end
end
