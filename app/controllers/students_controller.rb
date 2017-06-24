class StudentsController < ApplicationController

  include SessionsHelper

  before_action :check_sign_in, only: [:edit, :update, :show, :destroy, :index]
  before_action :check_correct_user, only: [:edit, :update, :show]
  before_action :check_admin_user, only: [:destroy, :index]
  before_action :check_not_signed_in, only: [:new, :create]

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      StudentMailer.account_activation(@student).deliver_now
      flash[:success] = "Please check your email to activate your account."
      redirect_to root_url(subdomain: '')
    else
      render 'new'
    end
  end

  def show
    @student = Student.find(params[:id])
  end

  def edit
    if !session[:user_id].nil?
      @student = Student.find(session[:user_id])
    else
      @student = Student.find_by(email: session[:cas][:extra_attributes][:email])
    end
  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(student_update_params)
      flash[:success] = "Profile updated successfully."
      redirect_to student_url(@student, subdomain: 'dashboard')
    else
      render 'edit'
    end
  end

  def index
    @students = Student.all
  end

  def destroy
    Student.find(params[:id]).destroy
    flash[:success] = "User deleted successfully."
    redirect_to students_url(subdomain: 'dashboard')
  end

  private

    def student_params
      params.require(:student).permit(:name, :email, :contact, :dob, :password, :password_confirmation)
    end

    def student_update_params
        params.require(:student).permit(:name, :email, :contact, :dob, :password, :password_confirmation, :picture)
    end

    def check_sign_in
      if user_signed_in?
        flash[:danger] = "Please sign in."
        redirect_to root_url(subdomain: '')
      end
    end

    def check_not_signed_in
      if !user_signed_in?
        flash[:danger] = "Not allowed!"
        redirect_to root_url(subdomain: '')
      end
    end

    def check_correct_user
      @student = Student.find(params[:id])
      flash[:danger] = "Unauthorized user." unless @student == current_student
      redirect_to root_url(subdomain: '') unless @student == current_student
    end

    def check_admin_user
      unless current_student.admin?
        flash[:danger] = "Unauthorized user."
        redirect_to root_url(subdomain: '')
      end
    end
end
