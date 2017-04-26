# frozen_string_literal: true

# api end point for habits
class HabitRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_habit
  before_action :fetch_habit_record, only: %I[destroy]
  before_action :build_completed_at, only: %I[create]

  def index
    render json: Builders::Json::HabitRecords.new(@habit.habit_records).build
  end

  def create
    habit_record = @habit.habit_records.new(habit_record_params.merge(completed_at: @completed_at))

    if habit_record.save
      render json: Builders::Json::Habit.new(@habit.reload).build
    else
      render json: Builders::Json::Errors.new(@habit).build
    end
  end

  def destroy
    if @habit_record.destroy
      render json: Builders::Json::Habit.new(@habit.reload).build
    else
      render json: Builders::Json::Errors.new(@habit).build
    end
  end

  private

  def habit_record_params
    params.required(:habit_record).permit(:tz)
  end

  def habit_completed_at_param
    params.required(:habit_record).permit(:completed_at)[:completed_at]
  end

  def build_completed_at
    invalid_date and return unless habit_completed_at_param

    begin
      @completed_at = ActiveSupport::TimeZone[habit_record_params[:tz]].parse(habit_completed_at_param)
    rescue StandardError => _
      invalid_date and return
    end
  end

  def fetch_habit
    @habit = current_user.habits.find_by(id: params[:habit_id])
    habit_not_found unless @habit
  end

  def fetch_habit_record
    @habit_record = @habit.habit_records.find_by(id: params[:id])
    habit_record_not_found unless @habit_record
  end

  def habit_not_found
    render json: { errors: ['Habit not found'] }, status: :unauthorized
  end

  def habit_record_not_found
    render json: { errors: ['Habit Record not found'] }, status: :unauthorized
  end

  def invalid_date
    render json: { errors: ['Invalid date'] }, status: :unauthorized
  end
end
