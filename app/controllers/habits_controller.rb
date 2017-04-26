# frozen_string_literal: true

# api end point for habits
class HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_habit, except: %I[index create]
  before_action :build_remind_at, only: %I[create update]

  def index
    render json: Builders::Json::Habits.new(current_user.habits).build
  end

  def create
    habit = current_user.habits.new(habit_params.merge(remind_at: @remind_at))

    if habit.save
      render json: Builders::Json::Habit.new(habit).build
    else
      render json: Builders::Json::Errors.new(habit).build
    end
  end

  def update
    if @habit.update(habit_params.merge(remind_at: @remind_at))
      render json: Builders::Json::Habit.new(@habit.reload).build
    else
      render json: Builders::Json::Errors.new(@habit).build
    end
  end

  def show
    render json: Builders::Json::Habit.new(@habit).build
  end

  def destroy
    @habit.toggle(:deleted)

    if @habit.save
      render json: Builders::Json::Habit.new(@habit.reload).build
    else
      render json: Builders::Json::Errors.new(@habit).build
    end
  end

  private

  def habit_params
    params.required(:habit).permit(
      :title,
      :question,
      :color,
      :monday,
      :tuesday,
      :wednesday,
      :thursday,
      :friday,
      :saturday,
      :sunday,
      :remind_at,
      :tz
    )
  end

  def habit_remind_at_param
    params.required(:habit).permit(:remind_at)[:remind_at]
  end

  def build_remind_at
    invalid_date and return unless habit_remind_at_param

    begin
      @remind_at = ActiveSupport::TimeZone[habit_params[:tz]].parse(habit_remind_at_param)
    rescue StandardError => _
      invalid_date and return
    end
  end

  def fetch_habit
    @habit = current_user.habits.find_by(id: params[:habit_id] || params[:id])
    habit_not_found unless @habit
  end

  def habit_not_found
    render json: { errors: ['Habit not found'] }, status: :unauthorized
  end

  def invalid_date
    render json: { errors: ['Invalid date'] }, status: :unauthorized
  end
end
