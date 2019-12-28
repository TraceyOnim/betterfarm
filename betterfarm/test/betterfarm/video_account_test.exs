defmodule Betterfarm.VideoAccountTest do
  use Betterfarm.DataCase
  import Betterfarm.Factory

  alias Betterfarm.Account
  alias Betterfarm.Multimedia.VideoAccount
  alias Betterfarm.Multimedia.Video
  alias Betterfarm.Repo

  setup do
    farmer_attr = %{
      first_name: "first",
      last_name: "last",
      phone_number: "0718039045",
      national_id: "1234567",
      country: "Kenya",
      county: "Kisumu",
      gender: "female",
      credential: %{email: "firstlast@email.com", password: "secret"}
    }

    {:ok, farmer} = Account.register_farmer(farmer_attr)

    video_attr = %{
      url: "http://example.com",
      title: "New farming technology",
      farmer_id: farmer.id
    }

    [video_attr: video_attr, farmer: farmer]
  end

  test "create_video/1 saves video into the database", %{video_attr: video_attr} do
    {:ok, video} = VideoAccount.create_video(video_attr)
    %Video{title: title} = Repo.get_by(Video, url: video.url)
    assert title == video.title
  end

  test "get_video/1 returns the video whose given id matches", %{farmer: farmer} do
    {:ok, video} = insert!(:video, farmer_id: farmer.id)

    %Video{title: title} = VideoAccount.get_video(video.id)
    assert title == video.title
  end

  test "list_videos/0 returns a list of all videos", %{farmer: farmer} do
    # create 2 videos
    {:ok, first_video} = insert!(:video, farmer_id: farmer.id)
    {:ok, second_video} = insert!(:video, farmer_id: farmer.id)
    assert [first_video, second_video] == VideoAccount.list_videos()
    assert VideoAccount.list_videos() |> Enum.count() == 2
  end

  test "update_video/2 updates video in the db", %{video_attr: video_attr} do
    # create video
    {:ok, video} = VideoAccount.create_video(video_attr)
    # get the existing video from db
    video = VideoAccount.get_video(video.id)

    # update the existing video in db
    updated_attr = %{video_attr | title: "best technology"}
    {:ok, video} = VideoAccount.update_video(video, updated_attr)
    assert video.title == updated_attr.title
  end
end
