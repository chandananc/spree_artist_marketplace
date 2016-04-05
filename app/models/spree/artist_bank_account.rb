module Spree
  class ArtistBankAccount < ActiveRecord::Base

    attr_accessor :account_number, :routing_number

    belongs_to :artist

    validates :country_iso,    presence: true
    validates :masked_number,  presence: true
    validates :name,           presence: true
    validates :artist,       presence: true
    validates :token,          presence: true, uniqueness: true

  end
end