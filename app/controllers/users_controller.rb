class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)

    if user.save
      session[:user_id] = user.id
      redirect_to [:products], notice: 'User!'
    else
      redirect_to '/register'
    end
  end

  def user_params
    params.require(:new).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end

end