class PunchcardSettingController < ApplicationController
  before_action :find_punchcard_setting, only: %i[edit update]

  def edit
  end

  def new
    @punchcard_setting = current_company.build_punchcard_setting
  end

  def create
    @punchcard_setting = current_company.build_punchcard_setting(punchcard_setting_params)
    if @punchcard_setting.save
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @punchcard_setting.update(punchcard_setting_params)
      redirect_to admin_index_path, notice: '更新成功'
    else
      render :edit
    end
  end

  private

  def punchcard_setting_params
    params.require(:punchcard_setting).permit(:company_address, :latitude, :longitude, :allow_distance)
  end

  def find_punchcard_setting
    @punchcard_setting = PunchcardSetting.last
  end

end
