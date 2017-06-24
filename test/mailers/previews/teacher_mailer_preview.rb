# Preview all emails at http://localhost:3000/rails/mailers/teacher_mailer
class TeacherMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/teacher_mailer/account_activation
  def account_activation
    teacher = Teacher.first
    teacher.activation_token = Teacher.new_token
    TeacherMailer.account_activation(teacher)
  end

  # Preview this email at http://localhost:3000/rails/mailers/teacher_mailer/password_reset
  def password_reset
    teacher = Teacher.first
    teacher.activation_token = Teacher.new_token
    TeacherMailer.password_reset(teacher)
  end

end
