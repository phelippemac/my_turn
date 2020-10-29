class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :free_to_edit, only: [:update]
  before_action :free_to_delete, only: [:destroy]


  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = Appointment.all
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.day.to_date.past?
      format.js { redirect_to home_system_path,  notice: 'A reserva não pode ser feita com data passada'}
    else
      respond_to do |format|
        if @appointment.save
          format.html { }
          format.json { render :show, status: :created, location: @appointment }
        else
          format.html { render :new }
          format.json { render json: @appointment.errors, status: :unprocessable_entity }
        end
        format.js { redirect_to home_system_path }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    @appointment.current_user = current_user
    respond_to do |format|
      if @letty == false
        format.html { redirect_to home_system_path, notice: 'Houve um erro ao editar a reserva' }
        format.js { render home_system_path, notice: 'Houve um erro ao editar a reserva' }
      else 
        @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: 'Reserva realizada com sucesso' }
        format.json { render :show, status: :ok, location: @appointment }
        format.js
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.current_user = current_user
    respond_to do |format|
      if @letty == true
        @appointment.destroy
        format.html { redirect_to appointments_url, notice: 'Reserva cancelada com sucesso.' }
        format.json { head :no_content }
        format.js { redirect_to home_system_path }
      else
        format.html { redirect_to appointments_url, notice: 'Houve um erro ao cancelar a reserva.' }
        format.js { render home_show_message_path }
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

  def free_to_edit
    # cond1 refere-se a quem pode editar a reserva
    @appointment.user != current_user ? cond1 = false : cond1 = true
    # cond2 refere-se a reserva só poder ser editada-antes de sua data acontecer
    @appointment.day.past? ? cond2 = false : cond2 = true
    p cond1 && cond2 ? @letty = true : @letty = false
  end

  def free_to_delete
    # cond1 refere-se a quem pode deletar a reserva
    @appointment.user != current_user ? cond1 = false : cond1 = true
    # cond2 refere-se a reserva só poder ser deletada-antes de sua data acontecer
    @appointment.day.to_date.past? ? cond2 = false : cond2 = true
    cond1 && cond2 ? @letty = true : @letty = false
  end

end
