class Api::V1::ArchivesController < ApplicationController
  before_action :authorize_request

  def index
    render json: { archives: Archive.where(user: current_user).map { |a| encode_archive(a) } }, status: 200
  end
  
  def create
    resource_params = archive_params
    resource_params[:user] = current_user
    resource_params[:folder_id] = nil if resource_params[:folder_id] == 'null'
    @archive = Archive.new(resource_params)
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

  def archives_by_folder
    if params[:id] != 'null'
      render json: { archives: Archive.where(user: current_user, folder: params[:id]).map { |a| encode_archive(a) } }, status: 200
    else
      render json: { archives: Archive.where(user: current_user, folder: nil).map { |a| encode_archive(a) } }, status: 200
    end
  end

  private
 
  def archive_params
    params.permit(:id, :title, :archive, :folder_id, :remove_archive)
  end

  def encode_archive(archive)
    archive.structure_archive
  end
end
