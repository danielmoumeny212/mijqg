// Future<void> uploadImage(File image) async {
//   final url = 'https://your-server-url.com/upload';
//   final request = http.MultipartRequest('POST', Uri.parse(url));
//   final file = await http.MultipartFile.fromPath('file', image.path);
//   request.files.add(file);
//   final response = await request.send();
//   if (response.statusCode != 200) {
//     print('Error uploading image');
//   }
// }