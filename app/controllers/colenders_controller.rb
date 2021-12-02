class ColendersController < ApplicationController
  def index
    @colenders = Colender.all
    @colender = Colender.new
  end

  def create
    @colenders = Colender.all
    @colender = Colender.new(colender_params)
    if @colender.save
      redirect_to root_path, notice: "今日のメモ#{@colender.memo}を記録しました"
    else
      render :index
    end
  end

  def show
    @colender = Colender.find(params[:id])
  end

  def edit
    @colender = Colender.find(params[:id])
  end

  def update
    colender = Colender.find(params[:id])
    if colender.update(colender_params)
      redirect_to colender_path, notice: "#{colender.start_time.strftime("%Y年%m月%d日")}のメモを変更しました"
    end
  end

  def destroy
    colender = Colender.find(params[:id])
    colender.destroy
    redirect_to root_path, notice: "#{colender.start_time.strftime("%Y年%m月%d日")}の#{colender.title}を削除しました"
  end




  private

  def colender_params
    params.require(:colender).permit(:title,:memo,:workouted,:start_time)
  end
end
