require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:follower_follows).with_foreign_key(:following_id)
                                                  .class_name('Follow')
                                                  .dependent(:destroy) }
  it { is_expected.to have_many(:followers).through(:follower_follows).source(:follower) }

  it { is_expected.to have_many(:following_follows).with_foreign_key(:follower_id)
                                                   .class_name('Follow')
                                                   .dependent(:destroy) }
  it { is_expected.to have_many(:followings).through(:following_follows).source(:following) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  it { is_expected.to validate_presence_of(:nickname) }
  it { is_expected.to validate_uniqueness_of(:nickname).case_insensitive }

  it { is_expected.to validate_length_of(:name).is_at_most(50) }
  it { is_expected.to validate_length_of(:bio).is_at_most(300) }
end
