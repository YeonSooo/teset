class FirstController < ApplicationController
   
    def bestmonth
      
        #post_id별 좋아요 개수
        #좋아요 개수를 받았느면 max값에 해당하는 post_id를 출력하기
        
        sql = "select id 
                from  posts 
                where id = (select post_id 
                            from (select post_id, count(post_id) as like 
                                  from likes 
                                  group by post_id) 
                            where like = (select max(like) 
                                          from (select post_id , count(post_id) as like 
                                                from likes 
                                                group by post_id)
                                                )
                             )"
      
                                   
        
        #sql문을 array로 받음 
        records_array = ActiveRecord::Base.connection.execute(sql)
        #그 array에 id에 해당하는 값을 받아온다.
        
        best_id=records_array[0]["id"]
        
        @best=Post.find(best_id)
        
      

    end
    
    def mypost
        c_user=current_user.id
        user = User.find_by(id: c_user) 
        
        @all_posts = user.posts.order('created_at desc') # <- has_many :posts를 명시해서 사용 가능!


    end    
    
    def myaccount
    
        c_user=current_user.id
        @user = User.find_by(id: c_user) 
        
        @all_posts = @user.posts.order('created_at DESC').paginate(:page => params[:page], :per_page => 3) # <- has_many :posts를 명시해서 사용 가능!
        

    end
end
