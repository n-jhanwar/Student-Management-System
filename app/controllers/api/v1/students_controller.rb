class Api::V1::StudentsController < Api::V1::BaseController

  def show
    student = Student.find(params[:id])
    render json: { student: ::Api::V1::StudentSerializer.new(student).as_json }
  rescue
    render json: { error: "Student does not exist"}, status: :not_found
  end

  def create
    student = Student.new(create_student_params)
  
    if student.save
      render json: { message: 'Student created successfully', student: ::Api::V1::StudentSerializer.new(student).as_json }
    else
      render json: { error: student.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    students = Student.all

    render json: { students: students.map { |student| ::Api::V1::StudentSerializer.new(student).as_json } }
  end

  def destroy
    student = Student.find(params[:id])

    student.destroy
    render json: { message: 'Student deleted successfully' }
  rescue
    render json: { error: "Student does not exist"}, status: :not_found
  end

  private

  def create_student_params
    params.require(:student).permit(
      :first_name, :last_name, :email, :contact, :date_of_birth, :date_of_admission
    )
  end
end