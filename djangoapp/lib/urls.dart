// ignore_for_file: prefer_interpolation_to_compose_strings

var retreiveUrl = Uri.parse("http://localhost:8000/notes/");

var createUrl = Uri.parse("http://localhost:8000/notes/create/");

getNoteUrl(id) {
  return Uri.parse("http://127.0.0.1:8000/notes/" + id);
}

deleteUrl(id) {
  return Uri.parse("http://127.0.0.1:8000/notes/" + id + "/delete/");
}

updateUrl(id) {
  return Uri.parse("http://127.0.0.1:8000/notes/" + id + "/update");
}
