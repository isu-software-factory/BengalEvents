class RegistrationsController < ApplicationController
  before_action :authenticate_user!, except: :registers

  def drop
    #authorize @participant, policy_class: RegistrationPolicy
    drop_user

    @user = get_participant
    params[:role] == "Team" ? (redirect_to team_path(@user)) : (redirect_to profile_path(@user))
  end

  def drop_activity
    drop_user
    render json: {data: {message: "Successfully Unregistered", capacity: Session.find(params[:session_id]).capacity_remaining}}
  end

  def registers
    event = Session.find(params[:session_id].to_i)
    participant = get_participant
    success = false

    # add participant to event
    success = event.register_participant(participant)


    if success[0]
      render json: {data: {registered: true, user: participant.id}}
    else
      error_message = "Access Denied"
      error_message = success[1]
      render json: {data: {registered: false, error: error_message}}
    end

  end

  private

  def get_participant
    if params[:role] == "Team"
      participant = Team.find(params[:id])
      participant
    else
      participant = User.find(params[:id])
      participant
    end
  end

  def drop_user
    # drop participants from activities
    @session = Session.find(params[:session_id])

    @user = get_participant

    if params[:role] == "Team"
      @session.teams.delete(@user)
    else
      @session.users.delete(@user)
    end
    # check the wait list
    @session.wait_list_check
  end
end