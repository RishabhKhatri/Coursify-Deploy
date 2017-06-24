module SessionsHelper
  def current_teacher
    if !session[:user_id].nil?
      @current_teacher = Teacher.find(session[:user_id])
    elsif !(session[:cas].nil? || session[:cas][:user].nil?)
      @current_teacher ||= Teacher.find_by(email: session[:cas][:extra_attributes][:email])
    end
  end

  def current_student
    if !session[:user_id].nil?
      @current_student = Student.find(session[:user_id])
    elsif !(session[:cas].nil? || session[:cas][:user].nil?)
      @current_student ||= Student.find_by(email: session[:cas][:extra_attributes][:email])
    end
  end

  def current_institute
    if teacher_signed_in?
      @current_institute = Institute.find_by(id: current_teacher.institute_id)
    end
  end

  def teacher_signed_in?
    if !session[:user_id].nil?
      if Teacher.find_by(id: session[:user_id]).nil?
        return false
      else
        return true
      end
    elsif !(session[:cas].nil? || session[:cas][:user].nil?)
      if Teacher.find_by(email: session[:cas][:extra_attributes][:email]).nil?
        return false
      else
        return true
      end
    end
  end

  def student_signed_in?
    if !session[:user_id].nil?
      if Student.find(session[:user_id]).nil?
        return false
      else
        return true
      end
    elsif !(session[:cas].nil? || session[:cas][:user].nil?)
      if Student.find_by(email: session[:cas][:extra_attributes][:email]).nil?
        return false
      else
        return true
      end
    end
  end

  def user_signed_in?
    (session[:cas].nil? || session[:cas][:user].nil?) && session[:user_id].nil?
  end
end

def check_institute_admin?
  if !current_institute.nil?
    if current_teacher.email.eql? current_institute.admin
      return true
    else
      return false
    end
  end
end

def check_institute?
  if !current_teacher.institute_id.nil?
    return true
  else
    return false
  end
end

def resource_path(resource)
  "/courses/#{course.code}/resources/#{resource.id}"
end
