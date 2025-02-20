require 'rails_helper'

describe 'visitor sees a video show' do
  it 'vistor clicks on a tutorial title from the home page' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit '/'

    click_on tutorial.title

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content(video.title)
    expect(page).to have_content(tutorial.title)
  end

  it 'vistor should not see tutorials that are classroom classified' do
    tutorial = create(:tutorial, classroom: true)
    video = create(:video, tutorial_id: tutorial.id)

    visit '/'
    
    expect(page).to_not have_content(tutorial.title)
    expect(page).to_not have_content(video.title)
  end

  it 'vistor should not see tutorial title with no videos' do
    tutorial = create(:tutorial, classroom: false)

    visit '/'

    click_on tutorial.title

    expect(page).to have_content(tutorial.title)
  end
end
