require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_least(2).is_at_most(1000) }
end
