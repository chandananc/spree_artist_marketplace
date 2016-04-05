class ConvertToStripe < ActiveRecord::Migration
  def change
    add_column :spree_artist_bank_accounts, :country_iso, :integer
    add_column :spree_artist_bank_accounts, :name, :string
  end
end
