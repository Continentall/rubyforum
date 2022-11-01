# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_no_authentication, only: %i[new create] # требуем что бы пользователь не был зарегистрирован
  before_action :require_authentication, only: %i[edit update]
  before_action :find_user_by_id!, only: %i[edit update]
  before_action :authorize_user!
  after_action :verify_authorized
  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new user_params
    if @user.save
      enter_session @user
      flash[:success] = t 'global.flash.user.welcome'
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @user.update user_params
      flash[:success] = t 'global.flash.user.edit'
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :old_password)
  end

  def find_user_by_id!
    @user = User.find params[:id]
  end

  def authorize_user!
    authorize(@user || User)
  end
end
