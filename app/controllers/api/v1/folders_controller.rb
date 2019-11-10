class Api::V1::FoldersController < ApplicationController
  before_action :authorize_request

  def index
    render json: { folders: Folder.where(user: current_user).map { |f| encode_folder(f) } }, status: 200
  end
  
  def create
    resource_params = folder_params
    resource_params[:user] = current_user
    resource_params[:folder_id] = nil if resource_params[:folder_id] == 'null'
    @folder = Folder.new(resource_params)
    if @folder.save
      render json: { folders: Folder.where(user: current_user).map { |f| encode_folder(f) } }, status: 200
    else
      render json: { errors: { message: 'Parameters used are incorrect' } }, status: 404
    end
  end

  def update
    @folder = Folder.find(params[:id])
    if @folder.update_attributes(folder_params)
      render json: { folders: Folder.where(user: current_user).map { |f| encode_folder(f) } }, status: 200
    else
      render json: { errors: { message: 'Parameters used are incorrect' } }, status: 404
    end
  end

  def destroy
    Folder.find(params[:id]).destroy
  end

  def folders_by_folder
    if params[:id] != 'null'
      render json: { folders: Folder.where(user: current_user, folder_id: params[:id]).map { |a| encode_folder(a) } }, status: 200
    else
      render json: { folders: Folder.where(user: current_user, folder_id: nil).map { |a| encode_folder(a) } }, status: 200
    end
  end

  private
 
  def folder_params
    params.permit(:id, :title, :folder_id)
  end

  def encode_folder(folder)
    folder.structure_folder
  end
end
