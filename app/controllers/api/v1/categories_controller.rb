class Api::V1::CategoriesController < ApplicationController
  before_action :authorize_request

  def index
    render json: { categories: Category.where(user: current_user).map { |a| encode_category(a) } }, status: 200
  end
  
  def create
    resource_params = category_params
    resource_params[:user] = current_user
    resource_params[:folder_id] = nil if resource_params[:folder_id] == 'null'
    @category = Category.new(resource_params)
    if @category.save
      render json: { categories: Category.where(user: current_user).map { |a| encode_category(a) } }, status: 200
    else
      render json: { errors: { message: 'Parameters used are incorrect' } }, status: 404
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      render json: { categories: Category.where(user: current_user).map { |a| encode_category(a) } }, status: 200
    else
      render json: { errors: { message: 'Parameters used are incorrect' } }, status: 404
    end
  end

  def destroy
    Category.find(params[:id]).destroy
  end

  def categories_by_folder
    if params[:id] != 'null'
      render json: { categories: Category.where(user: current_user, folder: params[:id]).map { |a| encode_category(a) } }, status: 200
    else
      render json: { categories: Category.where(user: current_user, folder: nil).map { |a| encode_category(a) } }, status: 200
    end
  end

  private
 
  def category_params
    params.permit(:id, :description)
  end

  def encode_category(category)
    category.structure_category
  end
end
