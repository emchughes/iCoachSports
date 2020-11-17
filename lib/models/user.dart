enum Type {
  Coach,
  Player,
}

class User {
  Type type;

  User({
    this.type = Type.Coach,
  });

  User.clone(User u) {
    this.type = u.type;
  }
}
