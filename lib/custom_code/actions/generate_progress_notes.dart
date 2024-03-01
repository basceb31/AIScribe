// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:supabase/supabase.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

Future generateProgressNotes(
    int transcriptId, dynamic transcript, bool isFirst) async {
  //await dotenv.load();
  var systemContent = await generatePrompt(isFirst);

  //String openaiApiKey = dotenv.env['OPENAI_API_KEY'];
  String openaiApiKey = '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';
  // get recorded audio from stop recording audio then read as raw for api call
  // Finally, make the API call with the raw audio data
  String apiUrl = "https://api.openai.com/v1/chat/completions";

  // Define the request headers
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $openaiApiKey',
  };

  // Define the request body
  final Map<String, dynamic> requestBody = {
    "model": "gpt-4",
    "messages": [
      {"role": "system", "content": systemContent},
      {"role": "user", "content": transcript}
    ],
    "temperature": 0.1
  };

  var response = await http.post(Uri.parse(apiUrl),
      headers: headers, body: jsonEncode(requestBody));

  // Check for errors in the response
  // if (response.statusCode != 200) {
  //   throw Exception("Failed to generate notes");
  // }
  // Parse the JSON response
  var jsonResponse = json.decode(response.body);

  // Access the transcript
  var progressNotes = jsonResponse['choices'][0]['message']['content'];

  final SupabaseClient supabase = SupabaseClient(
      'https://xdmphmvjlqojaanhcwoq.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhkbXBobXZqbHFvamFhbmhjd29xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDg0ODk0NjksImV4cCI6MjAyNDA2NTQ2OX0.gstLqW8xlJURVHwwyH4i_Gw6VY9ZUqhlo3KlcZZiDJc');

  // Insert the transcript into the Supabase 'transcript' table
  var insertResponse = await supabase.from('patient_transcript').update({
    'progressNotes': progressNotes,
  }).match({'id': transcriptId});

  // Check for errors in the insert operation
  // if (insertResponse.error != null) {
  //   throw Exception(
  //       "Failed to insert transcript: ${insertResponse.error.message}");
  // }

  return insertResponse.data;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
