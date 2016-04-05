require 'spec_helper'
require 'cancan/matchers'
require 'spree/testing_support/ability_helpers'

describe Spree::MarketplaceAbility do

  let(:user) { create(:user, artist: create(:artist)) }
  let(:ability) { Spree::MarketplaceAbility.new(user) }
  let(:token) { nil }

  context 'for artistBankAccount' do
    context 'requested by non artist user' do
      let(:ability) { Spree::MarketplaceAbility.new(create(:user)) }
      let(:resource) { Spree::artistBankAccount.new }

      it_should_behave_like 'admin denied'
      it_should_behave_like 'access denied'
    end

    context 'requested by artists user' do
      let(:resource) { Spree::artistBankAccount.new({artist: user.artist}, without_protection: true) }
      it_should_behave_like 'admin granted'
      it_should_behave_like 'access granted'
    end

    context 'requested by another artists user' do
      let(:resource) { Spree::artistBankAccount.new({artist: create(:artist)}, without_protection: true) }
      it_should_behave_like 'create only'
    end
  end

end
