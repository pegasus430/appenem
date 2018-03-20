class V1::GroupsController < ApplicationController
  before_action :authenticate_user!

  def create
    group = current_user.groups.new(name: name)
    group.schools << School.find(school_ids)

    if group.save
      render json: group, status: :created
    else
      render json: group.errors, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.groups.find_by(id: group_id)&.destroy
    render json: { id: group_id }, status: :ok
  end

  private

  def group_id
    params.require(:group_id)
  end

  def name
    group.require(:name)
  end

  def school_ids
    group.require(:school_ids)
  end

  def group
    params.require(:group)
  end
end
