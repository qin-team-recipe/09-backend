class Api::UsersController < Api::ApplicationController

  before_action :set_user, only: [:show, :update]

  def show
    render json: { user: @user }, status: 200
  end

  def update
    if user.update(user_params)
      render json: { notice: "ユーザー情報を更新しました。", user: user_json(user) }, status: 200
    else
      render json: { error: "ユーザー情報の更新に失敗しました。#{e.message}" }, status: :unprocessable_entity
    end
  end

  def current
    render json: { user: user_json(@current_user) }, status: 200
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :is_chef, :avatar, :introduction)
  end

  def set_user
    @user = User.find_by(uid: params[:id])
    unless @user
      render json: { error: 'ユーザーが見つかりませんでした。' }, status: :not_found
    end
  end
end
