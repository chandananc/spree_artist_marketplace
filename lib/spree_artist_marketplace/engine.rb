module SpreeArtistMarketplace
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_artist_marketplace'
    
    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
    
    initializer "spree_artist_marketplace.preferences", before: :load_config_initializers  do |app|
      SpreeArtistMarketplace::Config = Spree::ArtistMarketplaceConfiguration.new
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
      Spree::Ability.register_ability(Spree::ArtistMarketplaceAbility)
    end

    def self.ckeditor_available?
      @@ckeditor_available ||= ::Rails::Engine.subclasses.map(&:instance).map{ |e| e.class.to_s }.include?('Ckeditor::Engine')
    end

    def self.spree_digital_available?
      @@spree_digital_available ||= ::Rails::Engine.subclasses.map(&:instance).map{ |e| e.class.to_s }.include?('SpreeDigital::Engine')
    end

    def self.spree_group_price_available?
      @@spree_group_price_available ||= ::Rails::Engine.subclasses.map(&:instance).map{ |e| e.class.to_s }.include?('SpreeGroupPricing::Engine')
    end

    def self.spree_related_products_available?
      @@spree_related_procues_available ||= ::Rails::Engine.subclasses.map(&:instance).map{ |e| e.class.to_s }.include?('SpreeRelatedProducts::Engine')
    end

    config.to_prepare &method(:activate).to_proc
  end
end
