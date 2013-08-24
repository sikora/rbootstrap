class AdminController < ApplicationController
  #load_and_authorize_resource  
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  #def set_user
  #  @user = User.find params[:id]
  #end

  def index
    @users = User.all
  end
  
  # Função que também implementa um Modal
  def show
  	@user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end 
  end
  
  # Função que implementa o cadastro de novos usuários
  def adicionar_usuario
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_index_path, success: 'Usuário criado com sucesso!' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'adicionar_usuario' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_index_path, success: 'Usuário atualizado com sucesso!' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_index_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role)
    end
end