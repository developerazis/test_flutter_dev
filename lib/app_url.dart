class AppUrl {
  static String baseUrl = "https://reqres.in/api/";
  static String getUsers = "${baseUrl}users";
  static String createUser = "${baseUrl}users";
  static String updateUser(id) => "${baseUrl}users/$id";
}