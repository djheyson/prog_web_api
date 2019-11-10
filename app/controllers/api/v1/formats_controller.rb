class Api::V1::FormatsController < ApplicationController
  before_action :authorize_request

  def index
    render json: { formats: Format.where(user: current_user).map { |a| encode_format(a) } }, status: 200
  end
  
  def create
    resource_params = format_params
    resource_params[:user] = current_user
    resource_params[:folder_id] = nil if resource_params[:folder_id] == 'null'
    @format = Format.new(resource_params)
    if @format.save
      render json: { formats: Format.where(user: current_user).map { |a| encode_format(a) } }, status: 200
    else
      render json: { errors: { message: 'Parameters used are incorrect' } }, status: 404
    end
  end

  def update
    @format = Format.find(params[:id])
    if @format.update_attributes(format_params)
      render json: { formats: Format.where(user: current_user).map { |a| encode_format(a) } }, status: 200
    else
      render json: { errors: { message: 'Parameters used are incorrect' } }, status: 404
    end
  end

  def destroy
    Format.find(params[:id]).destroy
  end

  def formats_by_folder
    if params[:id] != 'null'
      render json: { formats: Format.where(user: current_user, folder: params[:id]).map { |a| encode_format(a) } }, status: 200
    else
      render json: { formats: Format.where(user: current_user, folder: nil).map { |a| encode_format(a) } }, status: 200
    end
  end

  private
 
  def format_params
    params.permit(:id, :description)
  end

  def encode_format(format)
    format.structure_format
  end
end
