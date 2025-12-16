class Api::V1::SubjectsController < Api::V1::BaseController
  def show
    subject = Subject.find(params[:id])
    render json: { subject: ::Api::V1::SubjectSerializer.new(subject).as_json }
  rescue
    render json: { error: "Subject does not exist"}, status: :not_found
  end

  def create
    subject = Subject.new(subject_params)

    if subject.save
      render json: { message: 'Subject created successfully', subject: ::Api::V1::SubjectSerializer.new(subject).as_json }
    else
      render json: { error: subject.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    subject = Subject.find(params[:id])

    if subject.update(subject_params)
      render json: { message: 'Subject updated successfully', subject: ::Api::V1::SubjectSerializer.new(subject).as_json }
    else
      render json: { error: subject.errors.full_messages }, status: :unprocessable_entity
    end
  rescue
    render json: { error: "Subject does not exist"}, status: :not_found
  end

  def index
    subjects = Subject.all

    render json: { subjects: subjects.map { |subject| ::Api::V1::SubjectSerializer.new(subject).as_json } }
  end

  def destroy
    subject = Subject.find(params[:id])

    subject.destroy
    render json: { message: 'Subject deleted successfully' }
  rescue
    render json: { error: "Subject does not exist"}, status: :not_found
  end

  private

  def subject_params
    params.require(:subject).permit(:subject_code, :subject_name, :semester, :instructor_id)
  end
end
