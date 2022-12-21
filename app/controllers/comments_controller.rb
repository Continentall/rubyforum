# frozen_string_literal: true

class CommentsController < ApplicationController
  include TopicsMessages
  before_action :set_commentable!
  before_action :set_topic
  after_action :verify_authorized

  def create
    @comment = @commentable.comments.build comment_params
    authorize @comment
    if @comment.save
      flash[:success] = t '.success'
      redirect_to topic_path(@topic)
    else
      @comment = @comment.decorate
      load_topic_messages do_render: true
    end
  end

  def destroy
    comment = @commentable.comments.find params[:id]
    authorize comment

    comment.destroy
    flash[:success] = t '.success'
    redirect_to topic_path(@topic)
  end

  
  private

  def comment_params
    params.require(:comment).permit(:body).merge(user: current_user)
  end

  def set_commentable!
    commentable_type = [Topic, Message].detect { |c| params["#{c.name.underscore}_id"] }
    raise ActiveRecord::RecordNotFound if commentable_type.blank? # если не нашли тип то выдаем ошибку

    # Detect возвращает первый элемент в списке, для которого блок возвращает TRUE
    # тут detect проходится по действительным Topic и Message и ищет в их парамметрах или topic_id или message_id
    # соответственно commentable_type будет равен или Topic или Message
    @commentable = commentable_type.find(params["#{commentable_type.name.underscore}_id"])
    # по сути это выражение будет равено или Topic.find(params["topic_id"]) или Message.find(params["message_id"])
    # и вернет конкретный коментируемый сейчас топик или сообщение
  end

  def set_topic
    @topic = @commentable.is_a?(Topic) ? @commentable : @commentable.topic
  end
end
