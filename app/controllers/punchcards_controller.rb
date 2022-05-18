class PunchcardsController < ApplicationController
  before_action :find_punchcards, only: %i[edit update show destroy]
  def index
      authorize :punchcard
      @punchcards = current_user.punchcards.all
  end

  def new
      authorize :punchcard
      @punchcard = current_user.punchcards.new
  end

  def create
    authorize :punchcard
    if current_user.punchcards.last.punch_in_at.today? ===true
      redirect_to punchcards_path, notice: '今日已有上班打卡紀錄，請打下班卡!!!'
    else
      @punchcard = current_user.punchcards.new(punchcards_params)
      if @punchcard.save
        redirect_to punchcards_path, notice: '打卡成功!!!'
      else
        render :new, notice: '打卡失敗，請勿重複打卡!!!'
      end
    end
  end

  def show
  end

  def edit
    authorize :punchcard
  end

  def update
    authorize :punchcard
    if current_user.punchcards.last.punch_out_at.to_s.empty? ===true
      @punchcard.update(punchcards_params)
      redirect_to punchcards_path, notice: '已更新下班打卡紀錄!!!'
    else
      redirect_to punchcards_path, notice: '打卡失敗，請勿重複打卡!!!'

    end
  end

  def destroy
    authorize :punchcard
    @punchcard.destroy
    redirect_to punchcards_path, notice: '已刪除打卡紀錄!!!'
  end

  private

  def punchcards_params
    params.require(:punchcard).permit(:punch_in_at, :punch_out_at, :body_temperature, :is_punched_in_today)
  end

  def find_punchcards
    @punchcard = Punchcard.friendly.find(params[:id])
  end
end
