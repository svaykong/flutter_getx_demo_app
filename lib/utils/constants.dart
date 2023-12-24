import 'package:flutter_dotenv/flutter_dotenv.dart';

const apiBaseUrl = 'https://api.themoviedb.org/3';
final apiKey = dotenv.env['APIKEY'];
const imageBaseUrl = 'https://image.tmdb.org/t/p/original';
final token = dotenv.env['TOKEN'];
