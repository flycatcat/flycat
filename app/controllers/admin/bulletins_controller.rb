# frozen_string_literal: true

module Admin
  class BulletinsController < Admin::BaseController
    before_action :find_Bulletins, only: %i[edit update show destroy]
    def index
      @bulletins = Bulletin.all
    end

  def new
    authorize :bulletin
    @bulletin = Bulletin.new
  end

    def create
        authorize :bulletin
        @bulletin = Bulletin.new(bulletins_params)
        if @bulletin.save
        redirect_to admin_bulletins_path, notice: '已刊登公告'
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
        redirect_to admin_bulletins_path, notice: '已更新公告'
      else
        render :edit
      end
    end

    def destroy
      authorize :bulletin
      @bulletin.destroy
      redirect_to admin_bulletins_path, notice: '已刪除公告'
    end

    private

    def bulletins_params
      params.require(:bulletin).permit(:title, :content)
    end

    def find_Bulletins
      @bulletin = Bulletin.friendly.find(params[:id])
    end
  end
end
