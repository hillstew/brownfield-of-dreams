desc 'update position to 0'
task :update_position => [:environment] do
  videos = Video.where(position: nil)

  videos.each do |video|
    video.update(position: 0)
  end
  
  puts 'DONE.'
end