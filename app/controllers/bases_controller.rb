class BasesController < ApplicationController
  before_action :set_basis, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authenticate_permiss

  # GET /bases
  # GET /bases.json
  def index
    @bases = Base.all
  end

  # GET /bases/1
  # GET /bases/1.json
  def show
  end

  # GET /bases/new
  def new
    @basis = Base.new
  end

  # GET /bases/1/edit
  def edit
  end

  # POST /bases
  # POST /bases.json
  def create
    @basis = Base.new(basis_params)

    respond_to do |format|
      if @basis.save
        format.html { redirect_to @basis, notice: 'Base was successfully created.' }
        format.json { render :show, status: :created, location: @basis }
      else
        format.html { render :new }
        format.json { render json: @basis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bases/1
  # PATCH/PUT /bases/1.json
  def update
    respond_to do |format|
      if @basis.update(basis_params)
        format.html { redirect_to @basis, notice: 'Base was successfully updated.' }
        format.json { render :show, status: :ok, location: @basis }
      else
        format.html { render :edit }
        format.json { render json: @basis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bases/1
  # DELETE /bases/1.json
  def destroy
    @basis.destroy
    respond_to do |format|
      format.html { redirect_to bases_url, notice: 'Base was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_basis
      @basis = Base.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def basis_params
      params.require(:basis).permit(:code, :email, :level, :use)
    end
end
