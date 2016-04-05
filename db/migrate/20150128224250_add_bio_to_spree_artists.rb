class AddBioToSpreeArtists < ActiveRecord::Migration
  def change
		add_column :spree_artists, :bio, :text
	end
end
