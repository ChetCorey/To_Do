class TodoItemsController < ApplicationController
  before_action :find_todo_list
  def index
  end

  def new
    @todo_item = @todo_list.todo_items.new
  end

  def edit
    @todo_item = @todo_list.todo_items.find(params[:id])
  end

  def create
    @todo_item = @todo_list.todo_items.new(todo_item_params)
    if @todo_item.save
      flash[:success] = "Added todo list item."
      redirect_to todo_list_todo_items_path
    else
      flash[:error] = "There was a problem adding that todo list item."
      render action: :new
    end
  end

  def destroy
    @todo_item = @todo_list.todo_items.find(params[:id])
    if @todo_item.destroy
      flash[:success] = "Todo list item was deleated."
    else
      flash[:error] = "Todo list item could not be deleated."
    end
    redirect_to todo_list_todo_items_path
  end

  def complete
    @todo_item = @todo_list.todo_items.find(params[:id])
    @todo_item.update_attribute(:completed_at, Time.now)
    redirect_to todo_list_todo_items_path, notice: "Item Completed."
  end

  def url_options
    { todo_list_id: params[:todo_list_id] }.merge(super)
  end

  private
  def find_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def todo_item_params
    params[:todo_item].permit(:content)
  end
end
