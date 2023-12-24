class StoriesController < ApplicationController

    before_action :authenticate_user!
    before_action :find_story, only:[:edit, :update, :destroy]
        # 在這個controllser，只要進行action前沒有登入，就把沒有登入的使用者踢回登入畫面
        # 也可限定單個action   後面加上only: [:new]  或是濾掉except

    def index
        @stories = current_user.stories.order(created_at: :desc)
    end
    
    def new     
        # @story = Story.new 可以改寫成下面那行，只要在user.rb加上 has_many :stories
        @story = current_user.stories.new
        
    end

    def create
        @story = current_user.stories.new(story_params)

        if @story.save
            redirect_to stories_path, notice: "新增成功"
        else
            render :new 
            #重新渲染new的畫面
            # puts @story.errors.full_messages # 將錯誤訊息輸出到控制台
        end
    end

    def edit
    end


    def update
        if @story.update(story_params)
            redirect_to stories_path, notice: "故事更新成功"
        else
            render :edit
        end
    end

    def destroy
    end


    # 針對送過來的資料進行清洗，只允許給過的東西進資料庫
    private
    def story_params
        params.require(:story).permit(:title, :content)
    end

    def find_story
        @story = current_user.stories.where(id: params[:id]).first
    end

end
