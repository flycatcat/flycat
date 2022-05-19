# frozen_string_literal: true

class BulletinsController < ApplicationController
  before_action :find_bulletins, only: %i[edit update show destroy]
  before_action :authenticate_user!
  
  def index
    @bulletins = current_company.bulletins.all
  end

  def new
    authorize :bulletin
    @bulletin = current_company.bulletins.new
  end

  def create
    authorize :bulletin
    @bulletin = current_company.bulletins.new(bulletins_params)
    if @bulletin.save
      redirect_to bulletins_path, notice: '已刊登公告'
    else
      render :new
    end
  end

  def show; end

  def edit
    authorize :bulletin
  end

  def update
    authorize :bulletin
    if @bulletin.update(bulletins_params)
      redirect_to bulletins_path, notice: '已更新公告'
    else
      render :edit
    end
  end

  def destroy
    authorize :bulletin
    @bulletin.update(deleted_at: Time.now)
    redirect_to bulletins_path, notice: '已刪除公告'
  end

  private

  def bulletins_params
    params.require(:bulletin).permit(:title, :content)
  end

  def find_bulletins
    @bulletin = current_company.bulletins.friendly.find(params[:id])
  end
end
