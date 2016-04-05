require 'spec_helper'

describe Spree::Artist do

  it { should have_many(:bank_accounts) }

end
