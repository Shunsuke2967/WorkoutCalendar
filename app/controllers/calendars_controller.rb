class CalendarsController < ApplicationController
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
    @calendar = current_user.calendar.find(params[:id])
  end

  def edit
    @calendar = current_user.calendar.find(params[:id])
  end

  def update
    calendar =current_user.calendar.find(params[:id])
    if calendar.update(calendar_params)
      redirect_to calendar_path, notice: "#{calendar.start_time.strftime("%Y年%m月%d日")}のメモを変更しました"
    end
  end

  def destroy
    calendar =current_user.calendar.find(params[:id])
    calendar.destroy
    redirect_to root_path, notice: "#{calendar.start_time.strftime("%Y年%m月%d日")}の#{calendar.title}を削除しました"
  end




  private

  def calendar_params
    params.require(:calendar).permit(:title,:memo,:workouted,:start_time)
  end

end
