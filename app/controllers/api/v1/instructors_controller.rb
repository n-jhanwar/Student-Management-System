class Api::V1::InstructorsController < Api::V1::BaseController
  def show
    instructor = Instructor.find(params[:id])
    render json: { instructor: ::Api::V1::InstructorSerializer.new(instructor).as_json }
  rescue
    render json: { error: "Instructor does not exist"}, status: :not_found
  end

  def create
    instructor = Instructor.new(create_instructor_params)

    if instructor.save
      render json: { message: 'Instructor created successfully', instructor: ::Api::V1::InstructorSerializer.new(instructor).as_json }
    else
      render json: { error: instructor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    instructor = Instructor.find(params[:id])
    if instructor.update(update_instructor_params)
      render json: { message: 'Instructor updated successfully', instructor: ::Api::V1::InstructorSerializer.new(instructor).as_json }
    else
      render json: { error: instructor.errors.full_messages }, status: :unprocessable_entity
    end
  rescue
    render json: { error: "Instructor does not exist"}, status: :not_found
  end

  def index
    instructors = Instructor.all
    render json: { instructors: instructors.map { |instructor| ::Api::V1::InstructorSerializer.new(instructor).as_json } }
  end

  def destroy
    instructor = Instructor.find(params[:id])
    instructor.destroy
    render json: { message: 'Instructor deleted successfully' }
  rescue
    render json: { error: "Instructor does not exist"}, status: :not_found
  end

  private

  def create_instructor_params
    params.require(:instructor).permit(:first_name, :last_name, :email, :contact, :hire_date)
  end

  def update_instructor_params
    params.require(:instructor).permit(:first_name, :last_name, :email, :contact, :hire_date, :status)
  end
end
