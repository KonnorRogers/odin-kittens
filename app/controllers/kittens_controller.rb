# frozen_string_literal: true

# KittensController
class KittensController < ApplicationController
  def new
    @kitten ||= Kitten.new
  end

  def show
    @kitten = Kitten.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @kitten }
    end
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      flash[:success] = 'Kitten created!'
      redirect_to @kitten
    else
      flash.now[:danger] = 'Unable to save your kitten!'
      render 'new'
    end
  end

  def index
    @kittens = if params[:search].blank?
                 Kitten.all
               else
                 Kitten.where(name: params[:search])
               end

    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])
    if @kitten.update_attributes(kitten_params)
      flash[:success] = 'Kitten updated'
      redirect_to root_url
    else
      flash.now[:danger] = 'Unable to update your kitten'
      render 'edit'
    end
  end

  def destroy
    Kitten.find(params[:id]).destroy
    flash[:success] = 'Kitten deleted!'
    redirect_to kittens_url
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :cuteness,
                                   :softness, :age, :search)
  end
end
