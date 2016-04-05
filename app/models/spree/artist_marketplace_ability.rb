module Spree
  class ArtistMarketplaceAbility
    include CanCan::Ability

    def initialize(user)
      user ||= Spree.user_class.new

      if user.artist
        can [:admin, :manage], Spree::ArtistBankAccount, artist_id: user.artist_id
        can :create, Spree::ArtistBankAccount
      end
    end
  end
end