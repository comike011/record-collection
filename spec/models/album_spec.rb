require 'rails_helper'

RSpec.describe Album, type: :model do
  it { should belong_to(:artist) }
  it { should have_many(:tracks) }
end
