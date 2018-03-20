class OriginsController < ActionController::Base
  before_action :check_payload, :check_origin, :load_payload
  before_action :load_user, only: :sign_in
  before_action :check_params, :check_uniqueness, only: [:sign_up, :register]

  def sign_in
    credentials = user.create_new_auth_token
    render status: :ok,
           json: { credentials: credentials, redirect_to: autoload_path(credentials) }
  end

  def sign_up
    respond_to do |format|
      format.html { @user = origin.users.new(payload.permit(:name, :email)) }
      format.json do
        begin
          school = School.find(payload[:school_id])
          user = origin.users.new(payload.permit(:name, :email, :phone, :role))
          user.schools = [school]
          user.password = SecureRandom.hex(8)
          user.save!
          credentials = user.create_new_auth_token
          render status: :ok,
                 json: { credentials: credentials,
                         redirect_to: autoload_path(credentials) }
        rescue ActiveRecord::RecordNotFound
          render status: :bad_request, json: { message: 'School does not exists.' }
        rescue ActiveRecord::RecordInvalid
          render status: :unprocessable_entity, json: { message: 'Could not save user.' }
        end
      end
    end
  end

  def register
    @user = origin.users.new(user_params)
    @user.save!
    @redirect_to = autoload_path(@user.create_new_auth_token)
  rescue ActiveRecord::RecordInvalid
    render partial: 'refresh'
  end

  private

  attr_accessor :payload, :origin, :encrypted_payload, :user

  def autoload_path(credentials)
    request.base_url +
      "/autoload?credentials=#{URI.encode_www_form_component(credentials.to_json)}"
  end

  def user_params
    password = SecureRandom.hex(8)
    params.require(:user).permit(:phone, :role)
          .merge(payload.permit(:name, :email))
          .merge(school_ids_param)
          .merge({ password: password })
  end

  def school_ids_param
    schools = params.require(:user)[:schools]
    schools.blank? ? { school_ids: [] } : { school_ids: [schools] }
  end

  def check_uniqueness
    return if origin.users.where(email: payload[:email]).empty?
    respond_to do |format|
      format.html { to_lading }
      format.json { render status: :unprocessable_entity,
                           json: { message: 'User already exists.' } }
    end
  end

  def check_params
    respond_to do |format|
      format.js { }
      format.html do
        return if (['name', 'email'] - payload.keys).empty?
        to_lading
      end
      format.json do
        return if (['name', 'email', 'role', 'phone', 'school_id'] - payload.keys).empty?
        render status: :bad_request,
               json: { message: 'Parameters `name`, `email`, `role`, `phone` and '\
                                '`school_id` are required.' }
      end
    end
  end

  def load_user
    @user = origin.users.find_by!(email: payload[:email])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { to_lading }
      format.json do
        render status: :not_found, json: { message: 'No user with the given `email`.' }
      end
    end
  end

  def load_payload
    @payload, _ = JWT.decode(encrypted_payload, origin.rsa_public, 'RS256')
    @payload = ActionController::Parameters.new(@payload)
  rescue JWT::DecodeError
    respond_to do |format|
      format.html { to_lading }
      format.json do
        render status: :unauthorized, json: { message: 'Failed to read the payload.' }
      end
    end
  end

  def check_payload
    @encrypted_payload = params.require(:encrypted_payload)
  rescue ActionController::ParameterMissing
    respond_to do |format|
      format.html { to_lading }
      format.json do
        render status: :bad_request,
               json: { message: 'Parameter `encrypted_payload` is missing.' }
      end
    end
  end

  def check_origin
    @origin = Origin.find_by!(name: origin_name)
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { to_lading }
      format.json do
        render status: :forbidden, json: { message: 'This `origin` is not allowed.' }
      end
    end

  end

  def to_lading
    redirect_to '/'
  end

  def origin_name
    params.require(:origin_name)
  end
end
