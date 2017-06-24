class AccountActivationsController < ApplicationController

  def edit
    if !Teacher.find_by(email: params[:email]).nil?
      teacher = Teacher.find_by(email: params[:email])
      if teacher && !teacher.activated? && teacher.authenticated?(params[:id])
        teacher.update_attribute(:activated, true)
        teacher.update_attribute(:activated_at, Time.zone.now)
        flash[:success] = "Account successfully activated. Please sign in to access your account."
        redirect_to root_url(subdomain: '')
      else
        flash[:danger] = "Invalid activation link."
        redirect_to root_url(subdomain: '')
      end
    elsif !Student.find_by(email: params[:email]).nil?
      student = Student.find_by(email: params[:email])
      if student && !student.activated? && student.authenticated?(params[:id])
        student.update_attribute(:activated, true)
        student.update_attribute(:activated_at, Time.zone.now)
        flash[:success] = "Account successfully activated. Please sign in to access your account."
        redirect_to root_url(subdomain: '')
      else
        flash[:danger] = "Invalid activation link."
        redirect_to root_url(subdomain: '')
      end
    else
      flash[:info]="How the hell did you get in?"
      redirect_to root_url(subdomain: '')
    end
  end
end
