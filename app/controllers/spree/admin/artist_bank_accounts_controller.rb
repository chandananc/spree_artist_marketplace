class Spree::Admin::ArtistBankAccountsController < Spree::Admin::ResourceController

  before_filter :load_artist
  create.before :set_artist

  def new
    @object = @artist.bank_accounts.build
  end

  private

    def load_artist
      @artist = Spree::Artist.friendly.find(params[:artist_id])
    end

    def location_after_save
      spree.edit_admin_artist_path(@artist)
    end

    def set_artist
      @object.artist = @artist
    end

end