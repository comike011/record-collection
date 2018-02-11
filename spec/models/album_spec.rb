require 'rails_helper'

RSpec.describe Album, type: :model do
  it { should belong_to(:artist) }
  it { should have_many(:tracks) }
  it { should validate_uniqueness_of(:title).scoped_to(:artist_id) }
end
