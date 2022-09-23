class ApiUtils{
  static String baseUrl = "https://hellofonefix.com/";
  static String baseUrlImagePath = "${baseUrl}uploads/";

  static String loginApi = "${baseUrl}api/login";
  static String getJobsApi = "${baseUrl}api/get-jobs";
  static String searchJobsApi = "${baseUrl}api/search-jobs";
  static String getGenericDataApi = "${baseUrl}api/get-generic-data";
  static String getSearchShopApi = "${baseUrl}api/search-shops";
  static String getDeviceModelApi = "${baseUrl}api/get-models";
  static String getJobDetailApi = "${baseUrl}api/job-detail";
  static String addJobApi = "${baseUrl}api/add-jobs";
  static String changeJobStatusApi = "${baseUrl}api/change-status";
  static String deleteJobApi = "${baseUrl}api/delete-job";
  static String deleteUserApi = "${baseUrl}api/delete-user";
  static String deleteIdCardApi = "${baseUrl}api/delete-idCard";
  static String updateDocumentJobApi = "${baseUrl}api/update-jobDocument";
  static String updateIdCardImageApi = "${baseUrl}api/update-idCardImage";
  static String editJobApi = "${baseUrl}api/edit-job";
  static String getUsersApi = "${baseUrl}api/get-users";
  static String addUserApi = "${baseUrl}api/add-users";
  static String editUserApi = "${baseUrl}api/edit-user";
}