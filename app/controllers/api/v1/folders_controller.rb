class Api::V1::FoldersController < ApplicationController
  before_action :authorize_request

  def index
    render json: { archives: Archive.where(user: current_user).map { |a| encode_archive(a) } }, status: 200
  end
  
  def create
    resouce_params = archive_params
    resouce_params[:user] = current_user
    @archive = Archive.new(resouce_params)
    if @archive.save
      render json: { archives: Archive.where(user: current_user).map { |a| encode_archive(a) } }, status: 200
    else
      render json: { errors: { message: 'Parameters used are incorrect' } }, status: 404
    end
  end

  def update
    @archive = Archive.find(params[:id])
    if @archive.update_attributes(archive_params)
      render json: { archives: Archive.where(user: current_user).map { |a| encode_archive(a) } }, status: 200
    else
      render json: { errors: { message: 'Parameters used are incorrect' } }, status: 404
    end
  end

  def destroy
    Archive.find(params[:id]).destroy
  end

  private
 
  def archive_params
    params.permit(:id, :title)
  end
end
