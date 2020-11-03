class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]


  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = Appointment.all
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show; end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit; end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.day.to_date.past?
      format.js { redirect_to home_system_path, notice: 'A reserva não pode ser feita com data passada'}
    else
      respond_to do |format|
        system
        if @appointment.save
          format.html {}
          format.json { render :show, status: :created, location: @appointment }
          format.js { render home_system_path, locals: {msg: 'reserva_success'} }
        else
          format.html { render :new }
          format.json { render json: @appointment.errors, status: :unprocessable_entity }
          format.js { render home_system_path, locals: {msg: 'reserva_error'} }
        end
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    @appointment.current_user = current_user
    respond_to do |format|
      system
      if @appointment.update(appointment_params)
        format.html { redirect_to home_system_path, notice: 'Houve um erro ao editar a reserva' }
        format.js { render home_system_path, locals: {msg: 'edit_success'} }
      else 
        format.html { redirect_to @appointment, notice: 'Reserva realizada com sucesso' }
        format.js { render home_system_path, locals: {msg: 'edit_error'} }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.current_user = current_user
    respond_to do |format|
      system
      if @appointment.destroy
        format.html { redirect_to appointments_url, notice: 'Reserva cancelada com sucesso.' }
        format.js { render home_system_path, locals: { msg: 'destroy_success'} }
      else
        format.html { redirect_to appointments_url, notice: 'Houve um erro ao cancelar a reserva.' }
        format.js { render home_system_path, locals: { msg: 'destroy_error'} }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.permit(:day, :hour, :duration, :description, :user_id)
  end
end
