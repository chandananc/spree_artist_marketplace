class Spree::ArtistsController < Spree::StoreController

  before_filter :check_if_artist, only: [:create, :new]
  # ssl_required

	def index
		@artists = Spree::Artist.all
	end

	def show
	  @artist = Spree::Artist.find(params[:id])
	end

  def create
    authorize! :create, Spree::Artist

    @artist = Spree::Artist.new(artist_params)

    # Dont sign in as the newly created user if users already signed in.
    unless spree_current_user
      # Find or create user for email.
      if @user = Spree.user_class.find_by_email(params[:artist][:email])
        unless @user.valid_password?(params[:artist][:password])
          flash[:error] = Spree.t('artist_registration.create.invalid_password')
          render :new and return
        end
      else
        @user = Spree.user_class.new(email: params[:artist][:email], password: params[:artist].delete(:password), password_confirmation: params[:artist].delete(:password_confirmation))
        @user.save!
        session[:spree_user_signup] = true
      end
      sign_in(Spree.user_class.to_s.underscore.gsub('/', '_').to_sym, @user)
      associate_user
    end

    # Now create artist.

    @artist.email = spree_current_user.email if spree_current_user

    if @artist.save
      flash[:success] = Spree.t('artist_registration.create.success')
      redirect_to spree.admin_products_path
    else
      render :new
    end
  end

  def new
    authorize! :create, Spree::artist
    @artist = Spree::artist.new
    @artist.address = Spree::Address.default
  end

  private

  def check_if_artist
    if spree_current_user and spree_current_user.artist?
      flash[:error] = Spree.t('artist_registration.already_signed_up')
      redirect_to spree.admin_products_path and return
    end
  end

  def artist_params
    params.require(:artist).permit(:first_name, :name, :last_name, :tax_id, :profile_picture)
  end

end