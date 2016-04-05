class AddProfilePictureColumnsToSpreeArtists < ActiveRecord::Migration
  def change
		add_attachment :spree_artists, :profile_picture
	end
end
