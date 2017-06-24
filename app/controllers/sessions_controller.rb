class SessionsController < ApplicationController

  include SessionsHelper

  before_action :check_not_signed_in, only: [:new, :create]

  def new

  end

  def create
    auth = request.env["omniauth.auth"]
    if !Teacher.find_by(email: auth['info']['email']).nil?
      @teacher = Teacher.find_by(email: auth['info']['email'])
      if @teacher.activated?
        flash[:success] = "Welcome #{@teacher.name}."
        session[:user_id] = @teacher.id
        redirect_to root_url(subdomain: '')
      else
        flash[:warning] = "Please activate your account first."
        redirect_to root_url(subdomain: '')
      end
    elsif !Student.find_by(email: auth['info']['email']).nil?
      @student = Student.find_by(email: auth['info']['email'])
      if @student.activated?
        flash[:success] = "Welcome #{@student.name}."
        session[:user_id] = @student.id
        redirect_to root_url(subdomain: 'dashboard')
      else
        flash[:warning] = "Please activate your account first."
        redirect_to root_url(subdomain: '')
      end
    else
      flash[:info] = "Please sign up with #{auth['provider']} email id."
      redirect_to signup_url(subdomain: 'accounts')
    end
  end

  def cas_login
    fix_cas_session
    if session[:cas].nil? || session[:cas][:user].nil?
      render status: 401, text: "Redirecting to SSO..."
    else
      if !Teacher.find_by(email: session[:cas][:extra_attributes][:email].downcase).nil?
        @teacher = Teacher.find_by(email: session[:cas][:extra_attributes][:email].downcase)
        if @teacher.activated?
          redirect_to root_url(subdomain: '')
        else
          reset_session
          flash[:danger] = "Please activate your account first."
          redirect_to root_url(subdomain: '')
        end
      elsif !Student.find_by(email: session[:cas][:extra_attributes][:email].downcase).nil?
        @student = Student.find_by(email: session[:cas][:extra_attributes][:email].downcase)
        if @student.activated?
          redirect_to root_url(subdomain: 'dashboard')
        else
          reset_session
          flash[:danger] = "Please activate your account first."
          redirect_to root_url(subdomain: '')
        end
      end
    end
  end

  def destroy
    session.delete(:user_id)
    @current_teacher=nil
    @current_student=nil
  end

  private

    def fix_cas_session
      if session[:cas].respond_to?(:with_indifferent_access)
        session[:cas] = session[:cas].with_indifferent_access
      end
    end

    def check_not_signed_in
      if !user_signed_in?
        flash[:danger] = "Not allowed!"
        redirect_to root_url(subdomain: '')
      end
    end
end
