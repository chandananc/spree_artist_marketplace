class CreateArtistBankAccounts < ActiveRecord::Migration
  def change
    create_table :spree_artist_bank_accounts do |t|
      t.string :masked_number
      t.belongs_to :artist
      t.string :token
      t.timestamps
    end
    add_index :spree_artist_bank_accounts, :artist_id
    add_index :spree_artist_bank_accounts, :token
  end
end
#