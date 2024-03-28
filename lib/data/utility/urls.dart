class Urls {
  static const String _baseUrls = 'https://task.teamrabbil.com/api/v1';

  static String registration = '$_baseUrls/registration';
  static String login = '$_baseUrls/login';
  static String updateProfile = '$_baseUrls/profileUpdate';

  static String createTask = '$_baseUrls/createTask';
  static String taskCountByStatus = '$_baseUrls/taskStatusCount';

  static String newTaskList = '$_baseUrls/listTaskByStatus/New';
  static String completedTaskList = '$_baseUrls/listTaskByStatus/Completed';
  static String canceledTaskList = '$_baseUrls/listTaskByStatus/Canceled';
  static String progressTaskList = '$_baseUrls/listTaskByStatus/Progress';

  static String deleteTask(String id) => '$_baseUrls/deleteTask/$id';
  static String updateTaskStatus(String id, String status) => '$_baseUrls/updateTaskStatus/$id/$status';

  static String verifyEmail(String email) => '$_baseUrls/RecoverVerifyEmail/$email';

  static String receivedEmailOtp(String email, String otp) =>
      "$_baseUrls/RecoverVerifyOTP/$email/$otp";

  static String recoveryPasswordReset = '$_baseUrls/RecoverResetPass';
}