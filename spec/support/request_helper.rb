def groups_without_overlaps(users)
  group1, group2 = [], []
  users.each do |user|
    user_object = { name: user.name, id: user.id }
    group1.push(user_object) if user.id.odd?
    group2.push(user_object) if user.id.even?
  end
  { group: [group1, group2] }
end

def groups_with_overlaps(users)
  user_objects = users.map do |user|
    user_object = { name: user.name, id: user.id }
  end

  group1 = [ user_objects[0], user_objects[1], user_objects[3] ]
  group2 = [ user_objects[1], user_objects[3], user_objects[5] ]
  group3 = [ user_objects[0], user_objects[2], user_objects[4] ]

  { group: [group1, group2, group3] }
end