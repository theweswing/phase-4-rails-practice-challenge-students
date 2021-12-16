class StudentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_input

  def index
    render json: Student.all, status: :ok
  end

  def show
    found_student = Student.find(params[:id])
    render json: found_student, status: :ok
  end

  def destroy
    found_student = Student.find(params[:id])
    found_student.destroy
    head :no_content
  end

  def create
    found_instructor = Instructor.find(params[:instructor_id])
    new_student = Student.create!(strong_params)
    found_instructor.students << new_student
    render json: new_student, status: :created
  end

  def update
    found_student = Student.find_by(params[:id])
    found_student.update!(strong_params)
    render json: found_student, status: :accepted
  end

  private

  def strong_params
    params.permit(:name, :major, :age)
  end

  def invalid_input(e)
    render json: {
             errors: e.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end

  def not_found
    render json: { error: 'Instructor Not Found!' }, status: :not_found
  end
end
