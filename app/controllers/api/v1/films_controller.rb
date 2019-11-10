class Api::V1::FilmsController < ApplicationController
  before_action :authorize_request

  def index
    render json: { films: Film.where(user: current_user).map { |a| encode_film(a) } }, status: 200
  end
  
  def create
    resource_params = film_params
    resource_params[:user] = current_user
    resource_params[:folder_id] = nil if resource_params[:folder_id] == 'null'
    @film = Film.new(resource_params)
    if @film.save
      render json: { films: Film.where(user: current_user).map { |a| encode_film(a) } }, status: 200
    else
      render json: { errors: { message: 'Parameters used are incorrect' } }, status: 404
    end
  end

  def update
    @film = Film.find(params[:id])
    if @film.update_attributes(film_params)
      render json: { films: Film.where(user: current_user).map { |a| encode_film(a) } }, status: 200
    else
      render json: { errors: { message: 'Parameters used are incorrect' } }, status: 404
    end
  end

  def destroy
    Film.find(params[:id]).destroy
  end

  def films_by_folder
    if params[:id] != 'null'
      render json: { films: Film.where(user: current_user, folder: params[:id]).map { |a| encode_film(a) } }, status: 200
    else
      render json: { films: Film.where(user: current_user, folder: nil).map { |a| encode_film(a) } }, status: 200
    end
  end

  private
 
  def film_params
    params.permit(:id, :description)
  end

  def encode_film(film)
    film.structure_film
  end
end
