# frozen_string_literal: true

class KittensController < ApplicationController
  def new
    @kitten ||= Kitten.new
  end

  def show
    @kitten = Kitten.find(params[:id])
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      redirect_to @kitten
    else
      flash[:danger] = 'Unable to save your kitten!'
      render 'new'
    end
  end

  def index
    @kittens = Kitten.all
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
      flash[:danger] = 'Unable to update your kitten'
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'Kitten deleted!'
    redirect_to kittens_url
  end

  private

  def kitten_params
    params.permit(:kitten).require(:name, :cuteness,
                                   :softness, :age)
  end
end
