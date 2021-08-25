class NotesController < ApplicationController
  layout 'notes/notes'
  before_action :authenticate_user!, :except => [:show]

  def index
    @notes = current_user.notes
  end

  def new
    @note = Note.new(user_id: current_user.id, private: true)
  end

  def show
    @note = Note.find(params[:id])
  end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    if @note.save
      redirect_to @note
    else
      flash[:error] = @note.errors.full_messages
      render action: 'new'
    end
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_params)
      redirect_to @note
    else
      flash[:error] = @note.errors.full_messages
      render action: 'edit'
    end
  end

  private
  def note_params
    params.require(:note).permit(:title, :private, :content)
  end
end
