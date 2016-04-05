module Spree
  class ArtistAbility
    include CanCan::Ability

    def initialize(user)
      user ||= Spree.user_class.new

      if user.artist
        if SpreeArtistMarketplace::Engine.spree_digital_available?
          # can [:admin, :manage], Spree::Digital, variant: { artist_ids: user.artist_id }
          can [:admin, :manage], Spree::Digital do |digital|
            digital.variant.artist_ids.include?(user.artist_id)
          end
          can :create, Spree::Digital
        end
        can [:admin, :manage], Spree::Image do |image|
          image.viewable.product.artist_ids.include?(user.artist_id)
        end
        can :create, Spree::Image
        if SpreeArtistMarketplace::Engine.spree_group_price_available?
          # can [:admin, :manage], Spree::GroupPrice, variant: { artist_ids: user.artist_id }
          can [:admin, :manage], Spree::GroupPrice do |price|
            price.variant.artist_ids.include?(user.artist_id)
          end
        end
        if SpreeArtistMarketplace::Engine.spree_related_products_available?
          # can [:admin, :manage], Spree::Relation, relatable: { artist_ids: user.artist_id }
          can [:admin, :manage], Spree::Relation do |relation|
            relation.relatable.artist_ids.include?(user.artist_id)
          end
        end
        # TODO: Want this to be inline like:
        # can [:admin, :manage, :stock], Spree::Product, artists: { id: user.artist_id }
        can [:admin, :manage, :stock], Spree::Product do |product|
          product.artist_ids.include?(user.artist_id)
        end
        can [:admin, :create, :index], Spree::Product
        # can [:admin, :manage], Spree::ProductProperty, product: { artist_ids: user.artist_id }
        can [:admin, :manage, :stock], Spree::ProductProperty do |property|
          property.product.artist_ids.include?(user.artist_id)
        end
        can [:admin, :index, :read], Spree::Property
        can [:admin, :read], Spree::Prototype
        can [:admin, :manage, :read, :ready, :ship], Spree::Shipment, order: { state: 'complete' }, stock_location: { artist_id: user.artist_id }
        can [:admin, :create, :update], :stock_items
        can [:admin, :manage], Spree::StockItem, stock_location_id: user.artist.stock_locations.pluck(:id)
        can [:admin, :manage], Spree::StockLocation, artist_id: user.artist_id
        can :create, Spree::StockLocation
        can [:admin, :manage], Spree::StockMovement, stock_item: { stock_location_id: user.artist.stock_locations.pluck(:id) }
        can :create, Spree::StockMovement
        can [:admin, :update], Spree::Artist, id: user.artist_id
        # TODO: Want this to be inline like:
        # can [:admin, :manage], Spree::Variant, artist_ids: user.artist_id
        can [:admin, :create, :index], Spree::Variant
				can [:admin, :manage], Spree::Variant do |variant|
          variant.artist_ids.include?(user.artist_id)
        end
      end

      if SpreeArtistMarketplace::Config[:allow_signup]
        can :create, Spree::artist
      end

      if SpreeArtistMarketplace::Engine.ckeditor_available?
        can :access, :ckeditor

        can :create, Ckeditor::AttachmentFile
        can [:read, :index, :destroy], Ckeditor::AttachmentFile, artist_id: user.artist_id

        can :create, Ckeditor::Picture
        can [:read, :index, :destroy], Ckeditor::Picture, artist_id: user.artist_id
      end
    end

  end
end