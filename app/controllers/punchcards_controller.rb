class PunchcardsController < ApplicationController
  before_action :find_punchcards, only: %i[edit update show destroy]
  def index
    authorize :punchcard
    @punchcards = current_user.punchcards.all
  end

  def new
    authorize :punchcard
    @punchcard = current_user.punchcards.new
    @punchcards = current_user.punchcards.all

  end

  def create
      authorize :punchcard
      @punchcard = current_user.punchcards.new(punchcards_params)
      if @punchcard.save
      redirect_to punchcards_path, notice: '打卡成功'
      else
        render :new
      end
  end

  def show
  end

  def edit
    authorize :punchcard
  end

  def update
    authorize :punchcard
    if @punchcard.update(punchcards_params)
      redirect_to punchcards_path, notice: '已更新打卡紀錄'
    else
      render :edit
    end
  end

  def destroy
    authorize :punchcard
    @punchcard.update(deleted_at: Time.current)
    redirect_to punchcards_path, notice: '已刪除打卡紀錄'
  end

  private

  def punchcards_params
    params.require(:punchcard).permit(:punch_in_at, :punch_out_at, :body_temperature, :is_punched_in_today)
  end

  def find_punchcards
    @punchcard = Punchcard.friendly.find(params[:id])
  end
end
