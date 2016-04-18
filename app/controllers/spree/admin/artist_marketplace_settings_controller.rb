class Spree::Admin::ArtistMarketplaceSettingsController < Spree::Admin::BaseController

  def edit
    @config = Spree::ArtistMarketplaceConfiguration.new
  end

  def update
    config = Spree::ArtistMarketplaceConfiguration.new

    params.each do |name, value|
      next unless config.has_preference? name
      config[name] = value
    end

    flash[:success] = Spree.t('admin.artist_marketplace_settings.update.success')
    redirect_to spree.edit_admin_artist_marketplace_settings_path
  end

end