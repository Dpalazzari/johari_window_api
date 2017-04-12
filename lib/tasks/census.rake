namespace :census do
  desc "Update cohort on all users with census data"
  task update: :environment do
    User.all.each do |user|
      user.add_cohort_and_role
    end
  end
end
