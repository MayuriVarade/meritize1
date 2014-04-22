class Like < Socialization::ActiveRecordStores::Like
  # attr_accessible :title, :body
    def self.like!(liker, likeable)
      unless likes?(liker, likeable)
       self.create! do |like|
          like.liker = liker
           like.likeable = likeable
            like.count = 1
        end
       call_after_create_hooks(liker, likeable)
       true
       else
        like = Like.find_by_liker_id_and_likeable_id(liker.id,likeable.id)
         like.count=like.count+1
         like.save
       end
   end
end