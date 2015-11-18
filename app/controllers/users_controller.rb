class UsersController < ApplicationController

  # load_and_authorize_resource
  # before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
   
    respond_to do |format|
      if @user.save
        # Tell the UserMailer to send a welcome email after save
        UserMailer.welcome_email(@user).deliver_later
   
        format.html { redirect_to(@user, notice: 'User was successfully created.') }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @user = User.new
    @schedule = Schedule.new
  end



  # def show
  #   @schedules = @user.schedules
  # end

  # private
  # def set_user
  #   @user = User.find(params[:id])
  # end
  
  # def user_params
  #   params[:user].permit(:email, :password, :role, :schedule_ids=>[])
  # end

end