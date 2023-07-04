class Api::RegisterController < Api::ApplicationController
  skip_before_action :authenticate

  def show
    user = User.find_by(uid: params[:id])
    render json: { user: user }, status: 200
  end

  def create
    user = User.new(register_params)
    if user.save
      render json: { notice: "ユーザー登録が完了しました。", user: user }, status: 200
    else
      render json: { alert: 'ユーザー登録に失敗しました。', user: user.errors }, status: 400
    end
  end

  private

  def register_params
    params.require(:register).permit(:uid, :email, :name)
  end
end
