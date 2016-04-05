require 'spec_helper'

describe Spree::ArtistBankAccount do

  it { should belong_to(:artist) }

  it { should validate_presence_of(:masked_number) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:artist) }
  it { should validate_presence_of(:token) }
  it { should validate_uniqueness_of(:token) }

end
