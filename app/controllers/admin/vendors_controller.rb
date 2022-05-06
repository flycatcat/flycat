# frozen_string_literal: true

module Admin
  class VendorsController < BaseController
    before_action :set_vendor, only: %i[edit update destroy]
    def index
      authorize :vendor
      @vendors = User.all
    end

    def new
      authorize :vendor
      @vendor = User.new
    end

    def create
      authorize :vendor
      @vendor = User.new(vendor_params)

      if @vendor.save
        redirect_to admin_vendors_path, notice: '已成功新增'
      else
        render :new
      end
    end

    def edit
      authorize :vendor
    end

    def update
      authorize :vendor

      if @vendor.update(vendor_params)
        redirect_to edit_admin_vendor_path(@vendor), notice: '廠商資料已更新'
      else
        render :edit
      end
    end

    def destroy
      authorize :vendor
      @vendor.destroy
      redirect_to admin_vendors_path, notice: '廠商資料已刪除'
    end

    private

    def set_vendor
      @vendor = User.find(params[:id])
    end

    def vendor_params
      params.require(:user).permit(:email, :password, :password_confirmation).merge(role: 'vendor')
    end
  end
end
