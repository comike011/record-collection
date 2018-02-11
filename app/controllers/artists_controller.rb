class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      redirect_to action: 'index', status: 303
    else
      render 'new'
    end
  end

  def edit
    @artist = Artist.find(params['id'])
  end

  def update
    @artist = Artist.find(params['id'])
    if @artist.update_attributes(artist_params)
      redirect_to action: 'index', status: 303
    else
      render 'edit'
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    redirect_to action: 'index', status: 303
  end

  def csv
    @artists = sorted_artists(params['sort'])
    send_data Artist.to_csv(@artists)
  end

  def search
    @artists = Artist.where('LOWER(name) ILIKE ?', "%#{params['search']}%")
    render 'index'
  end

  private

  def sorted_artists(order)
    case order
    when 'records'
      Artist.all.sort_by { |a| a.albums.size }
    when 'min'
      Artist.all.sort_by { |a| a.record_year_min.to_i }
    when 'max'
      Artist.all.sort_by { |a| a.record_year_max.to_i }
    else
      Artist.all.order(:name)
    end
  end

  def artist_params
    params.require(:artist).permit(:name)
  end
end
