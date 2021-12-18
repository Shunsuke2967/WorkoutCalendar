class CalendarsController < ApplicationController
  before_action :set_current_user_calendar, only: [:show, :edit,:update,:destroy]
  def index
    @calendars = current_user.calendar.all
    @calendar = current_user.calendar.new
  end

  def create
    @calendars = current_user.calendar.all
    @calendar = current_user.calendar.new(calendar_params)
    if @calendar.save
      redirect_to root_path, notice: "今日のメモ#{@calendar.memo}を記録しました"
    else
      render :index
    end
  end

  def show
  end

  def edit
  end

  def update
    if @calendar.update(calendar_params)
      redirect_to calendar_url(@calendar), notice: "#{@calendar.start_time.strftime("%Y年%m月%d日")}のメモを変更しました"
    else
      render :edit
    end
  end

  def destroy
    @calendar.destroy
    redirect_to root_path, notice: "#{@calendar.start_time.strftime("%Y年%m月%d日")}の#{@calendar.title}を削除しました"
  end




  private

  def calendar_params
    params.require(:calendar).permit(:title,:memo,:workouted,:start_time)
  end

  def set_current_user_calendar
    @calendar = current_user.calendar.find(params[:id])
  end
end
