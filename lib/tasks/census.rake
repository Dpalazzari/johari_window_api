namespace :census do
  desc "Update cohort on all users with census data"
  task update_cohorts: :environment do
    User.all.each do |user|
      user.add_cohort
    end
  end
end
