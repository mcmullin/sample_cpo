class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
=begin
At this point, creating a new micropost works as expected... There is one subtlety, though: on failed micropost submission, 
the Home page expects an @feed_items instance variable, so failed submissions currently break (as you should be able to 
verify by running your test suite). The easiest solution is to suppress the feed entirely by assigning it an empty array
=end
    	@feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_url if @micropost.nil?
    end

=begin
In this case, we use find_by_id instead of find because the latter raises an exception when the micropost doesn’t exist instead 
of returning nil. By the way, if you’re comfortable with exceptions in Ruby, you could also write the correct_user filter like this:
		def correct_user
		  @micropost = current_user.microposts.find(params[:id])
		rescue
		  redirect_to root_url
		end
=end    
end