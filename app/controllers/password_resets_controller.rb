class PasswordResetsController < ApplicationController

  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    if !Teacher.find_by(email: params[:password_reset][:email].downcase).nil?
      @teacher = Teacher.find_by(email: params[:password_reset][:email].downcase)
      if @teacher.admin?
        flash[:danger] = "Not authorised."
        redirect_to root_url(subdomain: '')
      else
        @teacher.create_reset_digest
        @teacher.send_password_reset_email
        flash[:info] = "Email sent with password reset instructions"
        redirect_to root_url(subdomain: '')
      end
    elsif !Student.find_by(email: params[:password_reset][:email].downcase).nil?
      @student = Student.find_by(email: params[:password_reset][:email].downcase)
      if @student.admin?
        flash[:danger] = "Not authorised."
        redirect_to root_url(subdomain: '')
      else
        @student.create_reset_digest
        @student.send_password_reset_email
        flash[:info] = "Email sent with password reset instructions"
        redirect_to root_url(subdomain: '')
      end
    else
      flash[:danger] = "Email address not found."
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.is_a?(Student)
      if params[:student][:password].empty?
        @user.errors.add(:password, "can't be empty.")
        render 'edit'
      elsif @user.update_attributes(user_params)
        flash[:info] = "Password has been reset. Please login to continue."
        redirect_to root_url(subdomain: '')
      end
    else
      if params[:teacher][:password].empty?
        @user.errors.add(:password, "can't be empty.")
        render 'edit'
      elsif @user.update_attributes(user_params)
        flash[:info] = "Password has been reset. Please login to continue."
        redirect_to root_url(subdomain: '')
      end
    end
  end

  private

    def user_params
      if @user.is_a?(Student)
        params.require(:student).permit(:password, :password_confirmation)
      else
        params.require(:teacher).permit(:password, :password_confirmation)
      end
    end

    def get_user
      if !Teacher.find_by(email: params[:email]).nil?
        @user = Teacher.find_by(email: params[:email])
      elsif !Student.find_by(email: params[:email]).nil?
        @user = Student.find_by(email: params[:email])
      end
    end

    def valid_user
      unless @user && @user.activated? && @user.password_authenticated?(params[:id])
        flash[:danger] = "Not a valid user."
        redirect_to root_url(subdomain: '')
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to root_url(subdomain: '')
      end
    end
end
